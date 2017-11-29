#!/bin/sh
set -xe

while [ $# -gt 0 ]; do
	case "$1" in
		-h|--help)
			echo "This script generates Turris medkit using user lists and updater-ng."
			echo "Usage: $0 BINPATH OUTPUT"
			echo "Example usage:"
			echo "  $0 bin-nand/mvebu-musl medkit.tar.gz"
			echo "  Note that this script is expected to be run in openwrt sdk root"
			exit 0
			;;
		*)
			if [ -z "$OPENWRT_BIN" ]; then
				OPENWRT_BIN="$1"
			elif [ -z "$OUTPUT" ]; then
				OUTPUT="$(readlink -f $1)"
				if [ -e "$OUTPUT" ]; then
					echo "Output $1 already exists!" >&2
					exit 1
				fi
			else
				echo "Unknown option: $1" >&2
				exit 1
			fi
			;;
	esac
	shift
done

# Check that we are running as root (or fakeroot)
[ "$(id -u)" = 0 ] || {
	echo "This script have to be executed with root rights. Please use fakeroot." >&2
	exit 1
}
[ -d staging_dir ] || {
	echo "Directory staging_dir is missing from current working one!" >&2
	exit 1
}

# Insert staging path to environment so we can use tools from staging
export PATH="staging_dir/host/bin:staging_dir/host/usr/bin:$PATH"
export LD_LIBRARY_PATH="staging_dir/host/lib:staging_dir/host/usr/lib:$LD_LIBRARY_PATH"
if [ -z "$(which opkg-trans 2>/dev/null)" ] || [ -z "$(which pkgupdate)" ]; then
	echo "opkg-trans doesn't seems to be compiled! Please compile it first." >&2
	exit 1
fi

BUILD_DIR="$(mktemp -d /tmp/updater-medkit-XXXXXX)"
ROOT=$BUILD_DIR/root
mkdir $ROOT

ln -s tmp $ROOT/var
# Create lock required by updater
mkdir -p $ROOT/tmp/lock
# Create opkg status file and info file
mkdir -p $ROOT/usr/lib/opkg/info
touch $ROOT/usr/lib/opkg/status
# And updater directory
mkdir -p $ROOT/usr/share/updater
# Copy additional files
cp -r files/* $ROOT/

# Create fake reboot to not potentially reboot host if requested
mkdir -p $BUILD_DIR/bin
echo "#!/bin/sh
echo Reboot faked!" > $BUILD_DIR/bin/reboot
chmod +x $BUILD_DIR/bin/reboot
export PATH="$(readlink -f $BUILD_DIR/bin):$PATH"

# Create /tmp/sysinfo files
# TODO we should use some internal option of updater it self
mkdir -p /tmp/sysinfo
echo "Turris Omnia" > /tmp/sysinfo/model
# We are only using board_name anyway atm.
echo "rtunknown" > /tmp/sysinfo/board_name  

ABSOUT="$(readlink -f $ROOT)"
# First install base files before anything else
BASE_FILES="$(ls $OPENWRT_BIN/packages/base/base-files*.ipk | head -1)" # ls magic to get full name of package file
opkg-trans -R "$ABSOUT" -a "$BASE_FILES"

# Get base.lua and change path to repository and remove fallback
UPDATER_BASECONF="$BUILD_DIR/base.lua"
cat $OPENWRT_BIN/lists/base.lua | \
	sed "s#https://repo.turris.cz/openwrt-repo/omnia.*/packages#file://$OPENWRT_BIN/packages#;/^-- The fallback repository/,/^}$/d" > "$UPDATER_BASECONF"
# Dump our entry file
UPDATER_CONF="$BUILD_DIR/entry.lua"
echo "l10n = {'cs', 'de'} -- table with selected localizations
Export('l10n')
-- This is helper function for including localization packages.
function for_l10n(fragment)
	for _, lang in pairs(l10n or {}) do
		Install(fragment .. lang, {ignore = {'missing'}})
	end
end
Export('for_l10n')

Script('base', 'file://$UPDATER_BASECONF')" > "$UPDATER_CONF"
for USRL in cacerts luci-controls nas netutils; do
	echo "Script('$USRL', 'file://$OPENWRT_BIN/lists/$USRL.lua')" >> "$UPDATER_CONF"
done
# Run updater to pull in packages from base list
pkgupdate --out-of-root --usign=staging_dir/host/bin/usign -R $ABSOUT --batch file://$UPDATER_CONF

# Run all postinst scripts because as we are bootstrapping environment some
# packages on beginning might have failed to be settled correctly (for example rc
# script in base-files as we don't have procd installed in time of base-files
# installation. You know that egg and chicken problem...
for postinst in "$ABSOUT"/usr/lib/opkg/info/*.postinst; do
	IPKG_INSTROOT="$ABSOUT" "$postinst" configure
done

# Tar it to archive in current directory
(
	cd $ROOT
	# Do cleanups first
	rm -f var/lock/opkg.lock
	rm -f usr/share/updater/flags
	rm -rf usr/share/updater/unpacked
	rm -rf var/opkg-collided
	# Now create archive
	tar -czf "$OUTPUT" *
)

# Do cleanups
rm -rf $BUILD_DIR

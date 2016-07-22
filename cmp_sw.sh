#!/bin/sh
TMPDIR="/tmp/build.bump"
rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"
SRC="$1"
DST="$2"
OPENWRT="$3"

SAME=""
BUMP=""

check_package() {
    SRC_FILE="$SRC"/"$FILE"
    DST_FILE="$DST"/"$FILE"

    tar -xOf "$SRC_FILE" ./control.tar.gz | gzip -cd - | tar -xOvf - ./files-md5sum 2> /dev/null | sort > $TMPDIR/files.src
    tar -xOf "$DST_FILE" ./control.tar.gz | gzip -cd - | tar -xOvf - ./files-md5sum 2> /dev/null | sort > $TMPDIR/files.dst
    # All files are the same, no reason to update package
    SOURCE="`tar -xOf "$DST_FILE" ./control.tar.gz | gzip -cd - | tar -xOvf - ./control 2> /dev/null | sed -n 's|Source:\ ||p'`"
    if diff -q $TMPDIR/files.src $TMPDIR/files.dst > /dev/null; then
        SAME="$SAME $SOURCE"
    else
        BUMP="$BUMP $SOURCE"
    fi
}

mkdir -p "$DST"
# Iterate over all packages in source directory
for i in "$SRC"/*/*.ipk; do
    FILE="$(basename $(dirname "$i"))/$(basename "$i")"
    if [ -f "$DST"/"$FILE" ]; then
        check_package
    fi
done

BUMP="`echo $BUMP | tr ' ' '\n' | sort -u`"

echo "Packages that need to be bumped ($(echo "$BUMP" | wc -l))":
echo "$BUMP" | sed 's|^| + |'
echo
echo "Packages that stayed same ($(echo $SAME | tr ' ' '\n' | sort -u | wc -l))":
echo $SAME | tr ' ' '\n' | sort -u | sed 's|^| - |'
echo
OVERLAP=0
for i in $BUMP; do
    if echo $SAME | grep -q " $i "; then
        OVERLAP_PKG="$OVERLAP_PKG $i"
    fi
done
echo "Overlap ($(echo $OVERLAP_PKG | tr ' ' '\n' | sort -u | wc -l)):"
echo $OVERLAP_PKG | tr ' ' '\n' | sort -u | sed 's|^| * |'
if [ "$OPENWRT" ]; then
    echo
    echo Bumping release numbers
    for i in $BUMP; do
        REL="`sed -n "s|^$i "'\([0-9]\+\)$|\1|p' "$OPENWRT"/release-override 2> /dev/null`"
        [ "$REL" ] || REL="`sed -n 's|^PKG_RELEASE:\?=\([0-9]\+\)$|\1|p' "$OPENWRT"/"$i"/Makefile`"
        [ "$REL" ] || [ -z "`grep '^PKG_RELEASE:\?=\$(PKG_SOURCE_VERSION)$' "$OPENWRT"/"$i"/Makefile`" ] || REL=1
        if [ "$REL" ]; then
            REL="`expr $REL + 1`"
            if grep -q "^$i " "$OPENWRT"/release-override 2> /dev/null; then
                sed -i "s|^$i .*|$i $REL|" "$OPENWRT"/release-override
            else
                echo "$i $REL" >> "$OPENWRT"/release-override
            fi
            echo " * $i bumped to $REL"
        else
            echo " - Can't bump $i :-("
        fi
    done
fi

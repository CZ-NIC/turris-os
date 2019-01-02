#!/bin/sh
die() {
    echo "$1"
    exit 1
}

BOARD="$1"
[ -n "$BOARD" ] || BOARD=omnia
DATE="`wget -qO - https://repo.turris.cz/$BOARD/ | sed -n 's|.*git-hash.sig.*>\(20[1-9][0-9]-[0-9:[:blank:]-]*\)[[:blank:]]*</td>.*|\1|p' | sed 's|[[:blank:]]*$||'`"
HASH="`wget -qO - https://repo.turris.cz/$BOARD/git-hash`"
if [ -z "$DATE" ] || [ -z "$HASH" ]; then
    die "Something went wrong"
fi
git checkout "$HASH"
VERSION="`sed -n 's|PKG_VERSION:=||p' ./package/system/turris-version/Makefile`"
cat > /tmp/turrisos-$VERSION << EOF
Released version $VERSION

`sed -n '/" "/,/"$/ p' ./package/system/turris-version/Makefile | sed -e 's|.*" "||' -e 's|"$||' -e 's| • | * |'`
EOF
THASH="`cat ./feeds.conf.default | sed -n 's|.*turris-os-packages.git^||p'`"
[ -n "$THASH" ] || die "Can't get ToS hash"
GIT_TAGGER_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" GIT_AUTHOR_DATE="$DATE" git tag -F /tmp/turrisos-$VERSION -s --force v$VERSION || die "Can't tag OpenWRT"
git push --tags
cd feeds/turrispackages
git fetch
git checkout $THASH
GIT_TAGGER_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" GIT_AUTHOR_DATE="$DATE" git tag -F /tmp/turrisos-$VERSION -s --force v$VERSION || die "Can't tag TOS"
git push --tags git@gitlab.labs.nic.cz:turris/turris-os-packages.git

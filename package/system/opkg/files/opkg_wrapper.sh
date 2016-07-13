#!/bin/sh
PKGUPDATER="`which opkg-pkgupdate-wrapper.sh`"
[ -n "$PKGUPDATER" ] || PKGUPDATER="/usr/bin/opkg-pkgupdate-wrapper.sh"
if [ -x "$PKGUPDATER" ]; then
    exec "$PKGUPDATER" "$@"
else
    exec /bin/opkg-cl "$@"
fi

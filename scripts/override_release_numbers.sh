#!/bin/sh

# Bump release numbers when asked for
while read pkg orig_release release; do
        if [ $orig_release = X ]; then
                sed -i 's|^PKG_RELEASE\(:\?\)=\$(PKG_SOURCE_VERSION)$|PKG_RELEASE\1=\$(PKG_SOURCE_VERSION)-'"$release"'|' $PWD/$pkg/Makefile || true
        else
                sed -i 's|^PKG_RELEASE\(:\?\)='"$orig_release"'\+$|PKG_RELEASE\1='"$release"'|' "$pkg"/Makefile || true
                sed -i 's|^PKG_RELEASE\(:\?\)=\$(PKG_SOURCE_VERSION)-'"$orig_release"'\+$|PKG_RELEASE\1=\$(PKG_SOURCE_VERSION)-'"$release"'|' $PWD/$pkg/Makefile || true
        fi
done < $PWD/release-override


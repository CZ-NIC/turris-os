#!/bin/sh
# Copyright (C) 2017 CZ.NIC
# Unpack Turris OS and OpenWRT version from packages

SOURCE="$1"
DESTINATION="$2"

OPENWRT_PKG=base/base-files_*.ipk
OPENWRT_VERSION=./etc/openwrt_version
OPENWRT_RELEASE=./etc/openwrt_release

TURRIS_PKG=base/turris-version_*.ipk
TURRIS_VERSION=./etc/turris-version

unpack_files() {
	local PKG=`readlink -f "$SOURCE"`/"$1"
	local DIR="$2"
	shift 2
	(cd "$DIR" && tar -xzOf $PKG ./data.tar.gz | tar -xz "$@")
}

TMPDIR=`mktemp -d`
unpack_files $OPENWRT_PKG "$TMPDIR" "$OPENWRT_VERSION" "$OPENWRT_RELEASE"
unpack_files $TURRIS_PKG "$TMPDIR" "$TURRIS_VERSION"
mv "$TMPDIR"/"$OPENWRT_VERSION" "$TMPDIR"/"$OPENWRT_RELEASE" "$TMPDIR"/"$TURRIS_VERSION" "$DESTINATION"
rm -rf "$TMPDIR"

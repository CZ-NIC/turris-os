#!/bin/sh
# Copyright (C) 2017 CZ.NIC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

# Get a name of a package in the given file and list its files.

set -e

WORKDIR="$(mktemp -d)"
trap 'cd / && rm -rf "$WORKDIR"' EXIT HUP INT QUIT ILL TRAP ABRT BUS FPE SEGV PIPE ALRM TERM

cd "$WORKDIR"
gzip -d <"$1" | tar x
gzip -d <control.tar.gz | tar x
sed -ne 's/^Package: //p' control
mkdir data
cd data
gzip -d <../data.tar.gz | tar x
find -type f

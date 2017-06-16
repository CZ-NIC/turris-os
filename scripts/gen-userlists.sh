#!/bin/sh
set -e

MINIMAL=false
while [ $# -gt 0 ]; do
	case "$1" in
		-h|--help)
			echo "This script generates updater-ng userlists from Turris OS repository."
			echo "Usage: $0 [OPTION]... OUTPUT_PATH"
			echo
			echo "Options:"
			echo "  --help, -h"
			echo "    Prints this help text."
			echo "  --model (turris|omnia)"
			echo "    Target Turris model. Currently only turris or omnia are supported."
			echo "  --branch BRANCH"
			echo "    Target branch for which this userlist is generated."
			echo "  --minimal"
			echo "    Generate userlists for minimal branch. (This adds nightly as a fallback branch)"
			exit
			;;
		--model)
			shift
			[ "$1" != "turris" -a "$1" != "omnia" ] && {
				echo "Unknown model: $1" >&2
				exit 1
			}
			BOARD="$1"
			;;
		--branch)
			shift
			BRANCH="$1"
			;;
		--minimal)
			MINIMAL=true
			;;
		*)
			OUTPUT_PATH="$1"
			;;
	esac
	shift
done

[ -z "$OUTPUT_PATH" ] && {
	echo "You have to specify output path." >&2
	exit 1
}
[ -z "$BOARD" ] && {
	echo "Missing --model option." >&2
	exit 1
}
[ -z "$BRANCH" ] && {
	echo "Missing --branch option." >&2
	exit 1
}
[ -d lists ] || {
	echo "$0 have to be run in Turris OS root directory." >&2
	exit 1
}

mkdir -p $OUTPUT_PATH

M4ARGS="--include=lists -D _INCLUDE_=lists/ -D _BRANCH_=$BRANCH -D _BOARD_=$BOARD"
$MINIMAL && M4ARGS="$M4ARGS -D _BRANCH_FALLBACK_=nightly"

for f in $(find lists -name '*.lua.m4'); do
	m4 $M4ARGS $f > "$OUTPUT_PATH/$(basename $f | sed s/\.m4$//)"
done
for f in $(find lists -name '*.lua'); do
	cp $f "$OUTPUT_PATH/$(basename $f)"
done

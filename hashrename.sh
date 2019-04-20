#!/bin/sh
set -e

die() {
    echo "$1"
    exit 1
}

allowed="^md5|sha256|sha1|sha512$"
checksum="sha256"
while getopts 'c:' a; do
    case "$a" in
    c)
        if ! echo "$OPTARG" | grep -qE -- "$allowed"; then
            die "Invalid checksum specified, allowed: $allowed"
        fi
        checksum=$OPTARG
        ;;
    *)
        die "Usage: $(basename -- "$0") [-c CHECKSUM] FILES"
        ;;
    esac
done
shift $((OPTIND - 1))

checksum="${checksum}sum"

for file in "$@"; do
    ext=${file##*.}
    sum=$("$checksum" -- "$file" | grep -Eo '^\S+')
    mv -iv -- "$file" "${sum}.${ext}"
done

#!/bin/sh
set -e
prefix="$HOME/.local/bin"
mkdir -p "$prefix"
this_script=$(basename "$0")
for script in *; do
    if test -x "$script" && test -f "$script" && ! [ "$script" = "$this_script" ]; then
        abs_script="$PWD/$script"
        dest="$prefix/${script%.*}"
        ln -s "$abs_script" "$dest"
        echo "$abs_script -> $dest"
    fi
done

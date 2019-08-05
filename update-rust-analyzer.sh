#!/bin/sh
set -e
cd /tmp
dir="rust-analyzer"
if [ -d "$dir" ]; then
    cd "$dir"
    git pull
else
    git clone "https://github.com/rust-analyzer/rust-analyzer"
    cd "$dir"
fi
cargo install-ra --server

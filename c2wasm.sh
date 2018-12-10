#! /usr/bin/env bash

platform=$(uname -s | tr '[:upper:]' '[:lower:]')

function realpath {
    local r=$1; local t=$(readlink $r)
    while [ $t ]; do
        r=$(cd $(dirname $r) && cd $(dirname $t) && pwd -P)/$(basename $t)
        t=$(readlink $r)
    done
    echo $r
}


dir=$(dirname $(realpath $0))

echo "DIR" $dir

"$dir/$platform/dist/bin/clang" \
  --target=wasm32-unknown-unknown-wasm \
  --sysroot="$dir/$platform/sysroot" \
  -nostartfiles -Wl,--no-entry,--allow-undefined \
  "$@"







#! /usr/bin/env bash

platform=$(uname -s | tr '[:upper:]' '[:lower:]')

# I got a feeling osx doesn't come with readlink.
# thanks: https://stackoverflow.com/a/17577143

function readlink_crossplatform() {
  (
  cd $(dirname $1)         # or  cd ${1%/*}
  echo $PWD/$(basename $1) # or  echo $PWD/${1##*/}
  )
}

dir=$(dirname $(readlink_crossplatform $BASH_SOURCE))

"$dir/$platform/dist/bin/clang" \
  --target=wasm32-unknown-unknown-wasm \
  --sysroot="$dir/$platform/sysroot" \
  -nostartfiles -Wl,--no-entry,--allow-undefined \
  "$@"


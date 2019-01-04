#!/bin/sh

set -eux

if [ $# -lt 2 ]; then
  echo "Usage: $0 <extension name> <target files>"
  exit 1
fi

target=$1
shift 1

for src in "$@"
do
  if [ ! -e "${src}" ]; then
    echo "${src} does not exist"
    continue
  fi

  ext=${src##*.}
  dst=$(echo "${src}" | sed "s/\(.*\.\)${ext}/\1${target}/")

  echo "mv ${src} ${dst}"
  mv "${src}" "${dst}"
done

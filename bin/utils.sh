#!/bin/sh

jwtd() {
    cut -d. -f2 "$1" | tr '_-' '/+' | awk '{ n = length($0) % 4; if (n) $0 = $0 substr("====", 1, 4 - n); print }' | base64 -d | jq .
}

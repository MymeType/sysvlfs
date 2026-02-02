#!/usr/bin/env bash
# This gets run after the $(RENDERTMP)/{bootscripts,packages.ent} and aux-files targets

set -eu

if [ $# -lt 1 ] ; then
    echo "usage: $0 FILE"
    exit 1
fi

# Get bootscripts data
. "$RENDERTMP/bootscripts-data"

for FILE in "$@"; do
    sed -e "s|BOOTSCRIPTS-SIZE|$bootsize|"              \
        -e "s|BOOTSCRIPTS-INSTALL-KB|$bootinstallsize|" \
        -e "s|BOOTSCRIPTS-MD5SUM|$bootmd5|"             \
        -i "$FILE"
done

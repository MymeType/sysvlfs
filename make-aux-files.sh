#!/usr/bin/env bash
# This gets run before the aux-files-data target

set -eu

pushd "$RENDERTMP" > /dev/null

# Get base file name and copy bootscripts directory to that name
version="$(grep "^<!ENTITY lfs-bootscripts-version " packages.ent | cut -d\" -f2)"
bootscripts="lfs-bootscripts-$version"
mv -f bootscripts "$bootscripts"

# Create the tarball
bootscripts_tarball="$bootscripts.tar.xz"
tar -cJf "$bootscripts_tarball" "$bootscripts"

# Bootscripts data
cat >> bootscripts-data << EOF
bootscripts_tarball="$bootscripts.tar.xz"
bootinstallsize="$(du -sk "$bootscripts" | cut -f1)"
bootsize="$(du -sbk "$bootscripts_tarball" | cut -f1)"
bootmd5="$(md5sum "$bootscripts_tarball" | cut -d\  -f1)"
EOF

popd > /dev/null

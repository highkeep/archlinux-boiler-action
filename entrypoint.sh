#!/bin/bash
set -euo pipefail

# Install required packages
pacman -Syu --noconfirm --needed sudo

# Added builder as seen in edlanglois/pkgbuild-action - mainly for permissions
useradd builder -m
# When installing dependencies, makepkg will use sudo
# Give user `builder` passwordless sudo access
echo "builder ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

# Give all users (particularly builder) full access to these files
chmod -R a+rw .

# Set up sudo cmd to make life a little easier
sudoCMD="sudo -H -u builder"

# Do Stuff
echo "someInputName: ${INPUT_SOMEINPUTNAME:-nul}"

echo "someOtherInputName: ${INPUT_SOMEOTHERINPUTNAME:-nul}"

touch rootFile
ls -l rootFile
${sudoCMD} touch userFile
ls -l userFile

echo "someOutputName=${INPUT_SOMEINPUTNAME:-nul}" >>$GITHUB_OUTPUT

files=($(ls))
echo ${files[1]}
echo ${files[2]}

echo "someOtherOutputName=${files[@]}" >>$GITHUB_OUTPUT

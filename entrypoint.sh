#!/bin/bash
set -euo pipefail

# Install required packages
pacman -Syu --noconfirm --needed sudo

# ls -l within ubuntu-latest shows owner of clone is runner and group is docker
# id of runner user: uid=1001(runner) gid=123(docker) groups=123(docker),4(adm),101(systemd-journal)
# So lets match that from now on...

# Add docker group
groupadd -g 123 docker

# Add runner user
useradd runner -m -u 1001 -g 123
# When installing dependencies, makepkg will use sudo
# Give user `runner` passwordless sudo access
echo "runner ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

# Set up sudo cmd to make life a little easier
sudoCMD="sudo -H -u runner"

# Do Stuff
echo "someInputName: ${INPUT_SOMEINPUTNAME:-nul}"
echo "someOtherInputName: ${INPUT_SOMEOTHERINPUTNAME:-nul}"

echo "multipleInputs: ${INPUT_MULTIPLEINPUTS:-1 2 3}"
readarray -td ' ' multipleInputs < <(awk '{ gsub(/, /,"\0"); print; }' <<<"${INPUT_MULTIPLEINPUTS:-1 2 3}, ")
unset 'multipleInputs[-1]'
declare -p multipleInputs

for i in "${multipleInputs[@]}"; do
    echo "${i}"
done

touch rootFile
ls -l rootFile
${sudoCMD} touch userFile
ls -l userFile

echo "someOutputName=${INPUT_SOMEINPUTNAME:-nul}" >>$GITHUB_OUTPUT
echo "someOtherInputName=${INPUT_SOMEOTHERINPUTNAME:-nul}" >>$GITHUB_OUTPUT

files=($(ls))
echo "multipleOutputs=${files[@]}" >>$GITHUB_OUTPUT

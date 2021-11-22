#!/bin/sh
# build the whole project

umask 0002

cd ${0%/*}

git pull
(cd meta-mld; git pull)

for machine in x86 x86-qemu rpi4; do
  /usr/local/bin/kas build mld6-$machine.yml
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake packagegroup-all"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake package-index"
done

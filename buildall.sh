#!/bin/sh
# build the whole project

umask 0002

cd ${0%/*}

git pull
(cd meta-mld; git pull)

export USER=${USER:-$(whoami)}

for machine in x86 x86-qemu rpi2 rpi3 rpi4 rock-pi-4; do
  /usr/local/bin/kas build mld6-$machine.yml
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-addons"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-alsa"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-extra"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-gstreamer"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-tools"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-vdr"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-debug"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake package-index"
done

for machine in bpi cubietruck; do
  /usr/local/bin/kas build mld6-$machine.yml
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build mld-image-boot"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-extra"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake package-index"
done

for machine in x86 x86-qemu rpi2 rpi3 rpi4 rock-pi-4; do
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-kernel-modules"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake --runall build packagegroup-webbrowser"
  /usr/local/bin/kas shell mld6-$machine.yml -c "bitbake package-index"
done

#!/bin/sh
# build the whole project

umask 0002

cd ${0%/*}

git pull
(cd meta-mld; git pull)

export USER=${USER:-$(whoami)}

for machine in x86 x86-qemu rpi2 rpi3 rpi4 rock-pi-4 tinker-board tinker-board-s odroidn2l-hardkernel odroidn2plus-hardkernel; do
  kas build mld6-$machine.yml
  kas shell mld6-$machine.yml -c "bitbake -k --runall build packagegroup-all"
  kas shell mld6-$machine.yml -c "bitbake -k --runall build packagegroup-core-nfs"
  kas shell mld6-$machine.yml -c "bitbake -k --runall build docker-moby"
  kas shell mld6-$machine.yml -c "bitbake package-index"
done

#for machine in bpi cubietruck; do
#  kas build mld6-$machine.yml
#  kas shell mld6-$machine.yml -c "bitbake -k --runall build oscam"
#  kas shell mld6-$machine.yml -c "bitbake -k --runall build mld-image-boot"
#  kas shell mld6-$machine.yml -c "bitbake package-index"
#done

#for machine in x86 x86-qemu rpi2 rpi3 rpi4 rock-pi-4 tinker-board tinker-board-s; do
#  kas shell mld6-$machine.yml -c "bitbake -k --runall build packagegroup-webbrowser"
#  kas shell mld6-$machine.yml -c "bitbake package-index"
#done

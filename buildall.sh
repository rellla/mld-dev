#!/bin/sh
# build the whole project

umask 0002

cd ${0%/*}

git pull
(cd meta-mld && git pull)

export USER=${USER:-$(whoami)}

for machine in intel x86 x86-qemu rpi2 rpi3 rpi4 rpi5 rock-pi-4 tinker-board tinker-board-s odroidn2l-hardkernel odroidn2plus-hardkernel; do
  #echo "------------------------------------"
  #echo "Clear $machine recipes cache"
  #kas shell mld6-$machine.yml -c "bitbake -S parse ''"
  echo "------------------------------------"
  echo "Build $machine packages"
  kas shell mld6-$machine.yml -c "bitbake -k --runall build packagegroup-all"
  echo "------------------------------------"
  echo "Build $machine image"
  kas build mld6-$machine.yml
  echo "------------------------------------"
  echo "Build $machine index"
  kas shell mld6-$machine.yml -c "bitbake package-index"
done

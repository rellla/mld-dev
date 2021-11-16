#!/bin/sh
# build the whole project

cd ${0%/*}

{
  echo '----'
  date

  git pull
  (cd meta-mld; git pull)

  for machine in x86 x86-qemu rpi4; do
    kas build mld6-$machine.yml
    kas shell mld6-$machine.yml -c "bitbake packagegroup-all"
    kas shell mld6-$machine.yml -c "bitbake package-index"
  done
  
  date
} &> buildall.log

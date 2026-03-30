# Build MLD

## Clone project
```
git clone https://gitlab.com/MLD-6/mld-dev.git
```

## Setup build environment

You can use docker or build direkt on your Linux system.

### a) Either with docker

For this you have to install docker. Then you can start the docker container as the user, who owned the files.
```
cd mld-dev
USER_ID=$(id -u) GROUP_ID=$(id -g) docker compose up -d
```

Enter the docker container
```
docker exec -it MLD-6 bash
```

Or set a password for user mld
```
docker exec -it MLD-6 passwd mld
```

and then you can enter it by ssh
```
ssh mld@localhost -p 2200
```

### b) Or direkt on your Linux system

Installation of the packages you need for your build environment.
```
sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat libsdl1.2-dev xterm python3-pip locales locales-all \
     file cpio default-jre zstd lz4
```

Installation of the kas build tool
```
sudo pip3 install kas
```

## Build project

We use kas as build tool https://kas.readthedocs.io/en/latest/

Enter project folder
```
cd mld-dev
```

Then you can do for exampe:

- Build image for x86 systems
  ```
  kas build mld6-x86.yml
  ```

- Enter bitbake develop environment, to use all normal bitbake functions
  ```
  kas shell mld6-x86.yml
  ```

- Compile all VDR Plugins new (incl. VDR)
  ```
  kas shell mld6-x86.yml -c "bitbake --runall build packagegroup-vdr"
  ```

- Update package index (e.g. for apt)
  ```
  kas shell mld6-x86.yml -c "bitbake package-index"
  ```

# Build MLD

## Clone project
```
git clone https://gitlab.com/MLD-6/mld-dev.git
```

## Setup build environment

You can use docker or build direkt on your system.

### a) With docker

For this you have to install docker. Then you can start the docker container.
```
cd mld-dev
docker compose up -d
```

Enter the docker container
```
docker exec -it MLD-6 bash
```

Or enter it by ssh
```
ssh localhost -p 2200
```

### b) On your system

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

1.) Installation of build enviroment packages
```
sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat libsdl1.2-dev xterm python3-pip locales locales-all \
     cpio
```
	 
2.) Installation of KAS build tool
```
sudo pip3 install kas
```
(https://kas.readthedocs.io/en/latest/)

3.) Clone project
```
git clone https://gitlab.com/MLD-6/mld-dev.git
```

4.) Build project
```
cd mld-dev

```
as example
```
kas build mld6-x86.yml
```

5.) Initialize bitbake develop environment
```
kas shell mld6-x86.yml
```
then all normal bitbake functions can be used. 

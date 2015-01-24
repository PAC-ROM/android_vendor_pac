##How to prepare and build PAC-ROM in Ubuntu 14.04 or 14.10

**This guide applies to all variations of Ubuntu 14.04 or 14.10 (Mate, Kubuntu, Lubuntu, Xubuntu) or Linux Mint 17. ONLY 64 bit. Do not use the 32 bit version.**

###General Instruction:
**Enter the following commands into your terminal. (the commands are those that start with the $ symbol)**

######*Note: When you copy and paste commands, do not copy the $ symbol. It is only to indicate a command line.*

**1 - Remove ALL older and any unsupported Java versions**

```shell
$ apt-cache search java | awk '{print($1)}' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e 'java-common' | xargs sudo apt-get -y remove
$ sudo apt-get -y autoremove
$ dpkg -l | grep ^rc | awk '{print($2)}' | xargs sudo apt-get -y purge
$ sudo bash -c 'ls -d /home/*/.java' | xargs sudo rm -rf
$ sudo rm -rf /usr/lib/jvm/*
$ for g in ControlPanel java java_vm javaws jcontrol jexec keytool mozilla-javaplugin.so orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200 appletviewer apt extcheck HtmlConverter idlj jar jarsigner javac javadoc javah javap jconsole jdb jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd native2ascii rmic schemagen serialver wsgen wsimport xjc xulrunner-1.9-javaplugin.so; do sudo update-alternatives --remove-all $g; done
```


**2 - Install OpenJDK 7**

```shell
$ sudo apt-get install openjdk-7-jdk
$ java -version
```
    You should see something like:

        java version "1.7.0_55"
        OpenJDK Runtime Environment (IcedTea 2.4.7) (7u55-2.4.7-1ubuntu1~0.13.10.1)
        OpenJDK 64-Bit Server VM (build 24.51-b03, mixed mode)


**3 - Install tools needed to build**

```shell
$ sudo apt-get install bison build-essential bzip2 curl dpkg-dev flex g++-multilib git git-review gnupg gperf lib32bz2-1.0 lib32bz2-dev lib32ncurses5-dev lib32readline-gplv2-dev lib32z1-dev libbz2-1.0 libbz2-dev libc6-dev libghc-bzlib-dev libgl1-mesa-dev libgl1-mesa-glx:i386 libncurses5-dev libreadline6-dev libreadline6-dev:i386 libx11-dev:i386 libxml2-utils lzop mingw32 pngcrush python-markdown schedtool squashfs-tools tofrodos x11proto-core-dev xsltproc zip zlib1g-dev zlib1g-dev:i386
```


**4 - Create a symbolic link to libGL.so.1**

```shell
$ sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so
```


**5 - Now download and configure repo to download the source code:**

```shell
$ mkdir ~/bin && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo
```


**6 - Now edit ~/.bashrc**

```shell
$ pico ~/.bashrc
```
    Add the following line at the end of the file:

        export PATH=~/bin:$PATH

    Close pico (ctrl+x) and save the changes. Restart bash:
```shell
$ source ~/.bashrc
```


**7 - Create source folder and download source**

```shell
$ mkdir ~/pac-rom && cd ~/pac-rom
$ repo init -u https://github.com/PAC-man/pacman.git -b pac-5.0 -g all,-notdefault,-darwin
$ repo sync -j#

Where # is the specific number of jobs, 4 is default, change in accordance to internet performance/bandwidth/speed. Default is 4.
```


**8 - Then to build**

```shell
$ ./build-pac.sh <device_codename>

Example for Nexus 5:
    $ ./build-pac.sh hammerhead
```

For a list of supported options, run the script on it's own:
```shell
    $ ./build-pac.sh
```


<br><br>
###OPTIONAL! Configure ccache. This is used to build more quickly.

In your home directory edit ~/.bashrc:
```shell
$ pico ~/.bashrc
```
    Add the following line at the end of the file:

        export USE_CCACHE=1
        export CCACHE_DIR=(directory where ccache will be located)

        example: export CCACHE_DIR=/home/build/.ccache

    Close pico (ctrl+x) and save the changes. Restart bash:
```shell
$ source ~/.bashrc
```

Now specify the maximum size that can occupy ccache. The suggested cache size is 50-100GB, in this case 64GB.
Now in the root directory of the source code, run:
```shell
$ prebuilts/misc/linux-x86/ccache/ccache -M 64G
You can change this setting anytime with the value you want.
```


<br><br>
##PAC build script options

    Usage:
        build-pac.sh [options] device

    Options:
        -a  Disable ADB authentication and set root access to Apps and ADB
        -b# Prebuilt Chromium options:
                1 - Remove
                2 - No Prebuilt Chromium
        -c# Cleaning options before build:
                1 - Run make clean
                2 - Run make installclean
        -f  Fetch cherry-picks
        -j# Set number of jobs
        -k  Rewrite roomservice after dependencies update
        -r  Reset source tree before build
        -s# Sync options before build:
                1 - Normal sync
                2 - Make snapshot
                3 - Restore previous snapshot, then snapshot sync
        -o# Only build:
                1 - Boot Image
                2 - Recovery Image
        -p  Build using pipe
        -t  Build ROM with TWRP Recovery (Extreme caution, ONLY for developers)
                (This may produce an invalid recovery. Use only if you have the correct settings for these)
        -v  Verbose build output

    Example:
        ./build-pac.sh -c1 hammerhead

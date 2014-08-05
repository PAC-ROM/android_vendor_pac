How to build in Ubuntu 14.04
============================
This guide applies to all variations of Ubuntu 14.04 64 bit. Do not use the 32 Bit version

General Instruction:
--------------------
Copy and paste the following command in your terminal (the command are those who start with the following symbol  $)

Note: When you copy and paste the command, please do not copy the $, This symbol is only to indicate that a command

1 - Remove openjdk system (if installed):

    $ sudo apt purge openjdk-\* icedtea-\* icedtea6-\*

2 - Install JDK 6:

    $ sudo add-apt-repository ppa:webupd8team/java
    $ sudo apt update && sudo apt install oracle-java6-installer

    You must accept the agreement to continue with the installation
    once installed, make sure the version of jdk is correct:

    $ java -version

    You should see something like:

        java version "1.6.0_45"
        Java(TM) SE Runtime Environment (build 1.6.0_45-b06)
        Java HotSpot(TM) 64-Bit Server VM (build 20.45-b01, mixed mode)

    Continue to Step 3

3 - Now install all the tools to build:

    $ sudo apt install bison build-essential bzip2 curl dpkg-dev flex g++-multilib git git-review gnupg gperf lib32bz2-1.0 lib32bz2-dev lib32ncurses5-dev lib32readline-gplv2-dev lib32z1-dev libbz2-1.0 libbz2-dev libc6-dev libghc-bzlib-dev libgl1-mesa-dev libgl1-mesa-glx:i386 libncurses5-dev libreadline6-dev libreadline6-dev:i386 libx11-dev:i386 libxml2-utils lzop mingw32 pngcrush python-markdown schedtool squashfs-tools tofrodos x11proto-core-dev xsltproc zip zlib1g-dev zlib1g-dev:i386

4 - When finished installing the tools, we will create a symbolic link of libGL.so.1:

    $ sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

5 - Now we download and configure the tool to download the source code:

    $ mkdir ~/bin && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo

6 - Now edit it ~/.bashrc, with the editor of your choice, in this case gedit:

    $ sudo gedit ~/.bashrc

    Add the following line at the end of the document

        export PATH=~/bin:$PATH

    Save the changes and close gedit, now Restart bash

    $ source ~/.bashrc

7 - Now you will create the folder where you download the source code, then you will open the folder:

    $ mkdir ~/android && cd ~/android

Congratulations
---------------
Your machine is now ready to build, for download the source code and build you must follow the steps [here](https://github.com/PAC-man/pacman/blob/pac-4.4/README.md)


OPTIONAL! Configure ccache, this is used to build more quickly:

    In your home directory edit ~/.bashrc

    $ sudo gedit ~/.bashrc

    Add the following line at the end of the document

        export USE_CCACHE=1
        export CCACHE_DIR=(directory where ccache will be located)

        example: export CCACHE_DIR=/home/build/.ccache

    Now specify the maximum size that can occupy ccache, The suggested cache size is 50-100GB, in this case 64GB
    Now in the root directory of the source code, run

    $ prebuilts/misc/linux-x86/ccache/ccache -M 64G

    You can change this setting anytime, with the value you want

##How to prepare and build PAC-ROM in Mac OS X 10.9

###General Instruction:
**Enter the following commands into your terminal. (the commands are those that start with the $ symbol)**

######*Note: When you copy and paste commands, do not copy the $ symbol. It is only to indicate a command line.*


**1 - To prepare your computer, follow these [instructions] (http://forum.xda-developers.com/showthread.php?t=2510898) when you finish setting return to this guide.**

**2 - Create source folder and download source**

```shell
$ mkdir ~/pac-rom && cd ~/pac-rom
$ repo init -u https://github.com/PAC-man/pacman.git -b pac-5.0 -g all,-notdefault,-linux
$ repo sync -j#

Where # is the specific number of jobs, 4 is default, change in accordance to internet performance/bandwidth/speed. Default is 4.
```


**3 - Then to build**

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

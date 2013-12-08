#!/bin/bash

#Preamble: Some repos outside of PAC may have commits we need that takes too
#  long to be merged. Adding these cherry-picks here can automate the process
#  and makes it possible to add them to the nightlies
#  currently supported gerrit accounts are:
#    AOKP - Android Open Kang Project
#    AOSP - Android Open Kang Project
#    CM   - CyanogenMod
#    PAC  - pac-rom

device=$1

# colors
. ./vendor/pac/tools/colors

## Add commits for all devices here
# Name of commit for maintenance purposes
#cherries+=(279_PA)

# Add device specific commits here
case $device in
    anzu | coconut | haida | hallon | iyokan | mango | satsuma | smultron | urushi)
        #camera: Fix preview on SEMC msm7x30 devices
        cherries+=(48673_CM)
        # msm7x30: Add support for SEMC camcorder mic
        cherries+=(53435_CM)
        # init.local.rc: Tweak KSM values
        cherries+=(57320_CM)
        # recovery: Add support for performance control
        cherries+=(56720_CM)
    ;;
    some_device_name)
        # some commit name
        # cherries+=(1234_AOKP)
    ;;
esac

if [ "$cherries" != "" ]; then
    echo -e ""
    echo -e ${bldblu}"Picking the required cherries"${txtrst}
    echo -e ""
    ./build/tools/repopick.py -b ${cherries[@]}
fi

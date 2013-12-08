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
        # libstagefright: Add msm7x30 to the legacy alsa audio check
        cherries+=(56502_CM)
        # libc: Unbreak build for scorpion
        cherries+=(56062_CM)
        #SoftapControllerTI: update parameters for setSoftap
        cherries+=(55805_CM)
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


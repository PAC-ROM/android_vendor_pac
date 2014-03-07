#!/bin/bash

#Preamble: Some repos outside of PAC may have commits we need that takes too
#  long to be merged. Adding these cherry-picks here can automate the process
#  and makes it possible to add them to the nightlies
#  currently supported gerrit accounts are:
#    AOKP - Android Open Kang Project
#    AOSP - Android Open Source Project
#    CM   - CyanogenMod
#    PAC  - pac-rom
#    LX   - LegacyXperia

device=$1

# colors
. ./vendor/pac/tools/colors

## Add commits for all devices here
# Name of commit for maintenance purposes
#cherries+=(279_PA)

# Add device specific commits here
case $device in
    anzu | coconut | haida | hallon | iyokan | mango | satsuma | smultron | urushi)
        # Allow using Classic WebView
        cherries+=(56054_CM)
    ;;
    janice | codina)
        # STE OMX Fix [1/3]
        cherries+=(338_PAC)
        # STE OMX Fix [2/3]
        cherries+=(339_PAC)
        # STE OMX Fix [3/3]
        cherries+=(343_PAC)
        # STE OMX Fix and Fix shutdown/reboot bug
        cherries+=(344_PAC)
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


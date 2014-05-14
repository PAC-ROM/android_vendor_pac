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
        # Workspace: Quad interpolator
        cherries+=(1898_PAC)
        # Revert "wpa_supplicant_8 - Hostapd: Android related changes for sockets"
        cherries+=(63203_CM)
        # bluedroid: increase uhid report buffer size for wiimote
        cherries+=(63389_CM)
        # audio: Add A2DP notification support
        cherries+=(63131_CM)
        # framework/av: Add Usb AoA v2.0 support
        cherries+=(63410_CM)
        # libstagefright: Convert mono to stereo for LPA clips
        cherries+=(63411_CM)
        # libstagefright: Stability issue with LPA play back.
        cherries+=(63412_CM)
        # libstagefright: LPA playback fails when non-LPA clip is next clip
        cherries+=(63413_CM)
    ;;
    i9082)
        # OMX patch
        cherries+=(1162_PAC)
        # native patch
        cherries+=(1163_PAC)
    ;;
    p705)
        #libstagefright: Add support for custom LPA buffer size in legacy LPAPlayer
        cherries+=(1343_PAC)
        # Allow using Classic WebView
        cherries+=(56054_CM)
    ;;
    ariesve)
        #hwc: Blank and unblank primary on first boot
        cherries+=(56473_CM)
        #MemoryHeapBase: ifdef for gingerbread/froyo compatibility
        cherries+=(58227_CM)
        #Overlay support for legacy camera libs
        cherries+=(58228_CM)
        #sensorservice: Add legacy sensors fusion
        cherries+=(1164_PAC)
        #native: add flag to disable legacy sensors fusion
        cherries+=(1165_PAC)
    ;;
    janice | codina)
        # Swap Storages
        cherries+=(56515_CM)
    ;;
    janice)
        # fix default colors for janice
        cherries+=(2154_PAC)
    ;;

esac

if [ "$cherries" != "" ]; then
    echo -e ""
    echo -e ${bldblu}"Picking the required cherries"${txtrst}
    echo -e ""
    ./build/tools/repopick.py -b ${cherries[@]}
fi

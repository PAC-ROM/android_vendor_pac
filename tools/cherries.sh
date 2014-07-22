#!/bin/bash

#Preamble: Some repos outside of PAC may have commits we need that take too
#  long to be merged. Adding these cherry-picks here can automate the process
#  and makes it possible to add them to the nightlies
#  currently supported gerrit accounts are:
#    AOKP - Android Open Kang Project
#    AOSP - Android Open Source Project
#    CM   - CyanogenMod
#    PAC  - pac-rom
#    PA   - Paranoid Android (AOSPA)
#
#  in addition, cherry-pick patch files can be created for commits that aren't
#  available in the above gerrit accounts.
#
# ADDED BY SHUMASH 2014-07-22
#  add cherry-pick patches for non-gerrit commits like this:
#  After the NON-GERRIT case statement:
#
#  <device_name>)
#      PATCH=<name of patch without extension>
#      FOLDER=<name of folder in build tree where patch is to be applied>
#      patch_it  # this function call is required for each patch file
#	|
#      <Repeat for each separate patch>
#   ;;
#
#  All patches must have a .patch extension and stored in the vendor/pac/tool/patches folder
#  with a prefix name that exactly matches the PATCH name. 
#  Create a patch for the latest or last n patches with this command  
#     git format-patch -n
#  Go here for a good description of how to create patches:
#  http://docs.moodle.org/dev/How_to_create_a_patch
#  Additionally, you can create a patch file from a github commit by going into the URL address
#  line in your browser and adding ".patch" at the end.  It will immediately be downloaded as 
#  patch file.
# ---------------------------------------------------------

device=$1
BASEDIR=$PWD

# colors
. $BASEDIR/vendor/pac/tools/colors

function patch_it {
  cp -f $BASEDIR/vendor/pac/tools/patches/${PATCH}.patch $BASEDIR/${FOLDER}
  cd $BASEDIR/${FOLDER}
  git am ${PATCH}.patch

  if [ -e *.patch ]
  then
    rm *.patch
  fi
  if [ -e ".git/rebase-apply" ]
  then
    git am --abort
  elif [ -e ".git/CHERRY_PICK_HEAD" ]
  then
    git cherry-pick --abort
  fi
  cd $BASEDIR
}

## Add commits for all devices here
#
# Insert NON-GERRIT cherry-picks below
#
case $device in
    tenderloin)
	# btservice/AdaperState: handle ENABLED_READY in OffState
	PATCH=13-11-25_btservice-AdaperState-handle-ENABLED_READY
	FOLDER=packages/apps/Bluetooth
	patch_it #add this function call for each patch
    ;;

esac

if [ "$PATCH" != "" ]; then
    echo -e ""
    echo -e ${bldblu}"Completed patching required cherries "${txtrst}
    echo -e ""

fi

# Add device specific gerrit commits here
# Name of commit for maintenance purposes
#cherries+=(279_PA)


case $device in
    anzu | coconut | haida | hallon | iyokan | mango | satsuma | smultron | urushi)
        # Revert "wpa_supplicant_8 - Hostapd: Android related changes for sockets"
        cherries+=(63203_CM)
        # libstagefright: Allow using camera recording buffer as input for encoder
        cherries+=(103_PAC)
        # libstagefright: Fix video encoder input buffer
        cherries+=(104_PAC)
    ;;
    i9082)
        # OMX patch
        cherries+=(1162_PAC)
        # native patch
        cherries+=(1163_PAC)
    ;;
    s2ve | s2vep)
        # av patch
        cherries+=(20_PAC)
        # native patch
        cherries+=(21_PAC)
        # mediaprovider patch
        cherries+=(22_PAC)
    ;;
    p705)
        #libstagefright: Add support for custom LPA buffer size in legacy LPAPlayer
        cherries+=(1343_PAC)
        # Allow using Classic WebView
        cherries+=(56054_CM)
    ;;
    nozomi)
        #FwNative: Bootlogo and screenshot fix for Xperia S
        cherries+=(3018_PAC)
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

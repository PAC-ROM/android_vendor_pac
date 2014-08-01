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
# PATCH CAPABILITY BY SHUMASH 2014-07-22
# ONLINE OPTION BY LUKASZ 2014-07-27
# case $device in
#  <device_name>)
#    add cherry-pick patches for non-gerrit commits like this:
#      PATCH=<name of patch without extension>
#      FOLDER=<name of folder in build tree where patch is to be applied>
#      patch_it  # this function call is required for each patch file
#        |
#      <Repeat for each separate patch>
#
#    For gerrit commits, add the cherry-pick(s) in the form:
#      cherries +=(GERRIT-COMMIT#_GERRIT-ACCOUNT)
#     e.g. http://review.pac-rom.com/#/c/250/2/tools/cherries.sh would be cherries+=(250_PAC)
#        |
#      <Repeat for each separate cherry-pick>
#
#   ;;
#  On-line patches can be called by specifying a URL as the PATCH variable and calling the
#  patch_it function with the parameter 'true', i.e., patch_it true
#
#  Any patches stored in the vendor/pac/tool/patches folder must have a .patch extension
#  with a prefix name that exactly matches the PATCH name.  See below for examples.
#  All patches must be in the git format-patch email format for use by git am
#  Create a patch for the latest or last n patches with this command
#     git format-patch -n (-1 for the last commit, -3 for the last three, etc.)
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
  cd $BASEDIR/${FOLDER}
  LASTCOMMIT=$(git show --format=email | sed -n '4,4p')

  if [ "$1" = "true" ]; then
   PATCH="$(curl -s ${PATCH})"
   THISCOMMIT=$(echo -e "${PATCH}" | sed -n '4,4p')

   if [ "$LASTCOMMIT" != "$THISCOMMIT" ] ; then  #Patch if not already applied
    echo -e "${PATCH}" | git am
   else
    echo -e "skipped $(echo $THISCOMMIT | sed -r 's/^.{9}//')"
   fi

  else
   THISCOMMIT=$(cat $BASEDIR/vendor/pac/tools/patches/${PATCH}.patch | sed -n '4,4p')

   if [ "$LASTCOMMIT" != "$THISCOMMIT" ] ; then  #Patch if not already applied
    git am $BASEDIR/vendor/pac/tools/patches/${PATCH}.patch
   else
    echo -e "skipped $(echo $THISCOMMIT | sed -r 's/^.{9}//')"
   fi

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


# Add device specific commits and patches here

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
        PATCH="https://raw.githubusercontent.com/luk1337/build_tools/pac/0001-FRAMEWORKS-AV-PATCH-for-s2ve-s2vep-device.patch"
        FOLDER=frameworks/av
        patch_it true
        # native patch
        PATCH="https://raw.githubusercontent.com/luk1337/build_tools/pac/0001-FRAMEWORKS-NATIVE-PATCH-for-s2ve-s2vep-device.patch"
        FOLDER=frameworks/native
        patch_it true
        # mediaprovider patch
        PATCH="https://raw.githubusercontent.com/luk1337/build_tools/pac/0001-PROVIDERS-MEDIA-MEDIAPROVIDER-PATCH-for-s2ve-s2vep-d.patch"
        FOLDER=packages/providers/MediaProvider
        patch_it true
        # bluetooth patch
        PATCH="https://raw.githubusercontent.com/luk1337/build_tools/pac/0001-Add-BT-support-for-s2ve-s2vep.patch"
        FOLDER=hardware/broadcom/libbt
        patch_it true
        # hwc patch
        PATCH="https://raw.githubusercontent.com/luk1337/build_tools/pac/0001-Fix-HWC-for-s2ve-s2vep.patch"
        FOLDER=external/chromium_org
        patch_it true
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

if [ "$cherries" != "" ]; then
    echo -e ""
    echo -e ${bldblu}"Now picking the required cherries"${txtrst}
    echo -e ""
    ./build/tools/repopick.py -b ${cherries[@]}
fi

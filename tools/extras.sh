#!/bin/bash
#
# extras.sh: (git) cherry-picks additional commits needed by devices.
# Copyright (C) 2015 The PAC-ROM Project
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#
# Preamble:
# Some repos outside of PAC may have commits we need that take too
# long to be merged. Adding these cherry-picks here can automate the process
# and makes it possible to add them to the weeklies but not the nightlies.
# currently supported gerrit accounts are:
#     AOKP - Android Open Kang Project
#     AOSP - Android Open Source Project
#     CM   - CyanogenMod
#     PAC  - PAC-Rom
#     PA   - Paranoid Android (AOSPA)
#
# in addition, cherry-pick patch files can be created for commits that aren't
# available in the above gerrit accounts.
#
# PATCH CAPABILITY BY SHUMASH 2014-07-22
# ONLINE OPTION BY LUKASZ 2014-07-27
#
# case $device in
#     <device_name>)
#         # Get cherry-pick patches for non-gerrit commits like this:
#         PATCH=<name of patch without extension>
#         FOLDER=<name of folder in build tree where patch is to be applied>
#         patch_it # this function call is required for each patch file
#         # NOTE: Repeat for each separate patch
#
#         # To get gerrit commits, add the cherry-pick(s) in the form:
#         cherries+=(GERRIT-COMMIT#_GERRIT-ACCOUNT)
#             e.g. http://review.pac-rom.com/#/c/250/2/tools/cherries.sh would be:
#                  cherries+=(250_PAC)
#
#         # To get gerrit topics, add the topics(s) in the form:
#         topics+=(TOPIC_GERRIT-ACCOUNT)
#             e.g. http://review.pac-rom.com/#/q/topic:CREncoder would be:
#                  topics+=(CREncoder_PAC)
#
#         # To get gerrit queries, add the query(s) in the form:
#         queriess+=(QUERY_GERRIT-ACCOUNT)
#             e.g. queries+=(status:open+project:CyanogenMod/android_packages_apps_Nfc+branch:cm-11.0_CM)
#             NB: use full e-mail addresses for owners, no usernames with spaces
#
# ;;
#
# On-line patches can be called by specifying a URL as the PATCH variable and calling the
# patch_it function with the parameter 'true', i.e., patch_it true
#
# Any patches stored in the vendor/pac/extras/patches folder must have a .patch extension
# with a prefix name that exactly matches the PATCH name.  See below for examples.
# All patches must be in the git format-patch email format for use by git am
# Create a patch for the latest or last n patches with this command
#     git format-patch -n (-1 for the last commit, -3 for the last three, etc.)
#
# Go here for a good description of how to create patches:
# http://docs.moodle.org/dev/How_to_create_a_patch
# Additionally, you can create a patch file from a github commit by going into the URL address
# line in your browser and adding ".patch" at the end.  It will immediately be downloaded as patch file.
#


# Import colors
. ./vendor/pac/tools/colors


device=$1
BASEDIR=$PWD


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
        THISCOMMIT=$(cat $BASEDIR/vendor/pac/extras/patches/${PATCH}.patch | sed -n '4,4p')
        if [ "$LASTCOMMIT" != "$THISCOMMIT" ] ; then  #Patch if not already applied
            git am $BASEDIR/vendor/pac/extras/patches/${PATCH}.patch
        else
            echo -e "skipped $(echo $THISCOMMIT | sed -r 's/^.{9}//')"
        fi
    fi

    if [ -e ".git/rebase-apply" ]; then
        git am --abort
    elif [ -e ".git/CHERRY_PICK_HEAD" ]; then
        git cherry-pick --abort
    fi
    cd $BASEDIR
}


# Add device specific commits and patches here
case $device in
    anzu | coconut | haida | hallon | iyokan | mango | satsuma | smultron | urushi)
        # build: Add option to disable block-based ota
        cherries+=(78849_CM)
        # Revert "Revert "Reenable support for non-PIE executables""
        cherries+=(79136_CM)
        # arm: Allow disabling PIE for dynamically linked executables
        cherries+=(81758_CM)
        # libstagefright: Allow using camera recording buffer as input for encoder
        cherries+=(84178_CM)
        # libstagefright: Fix video encoder input buffer
        cherries+=(84179_CM)
        # vold: add ro.vold.umsdirtyratio property
        cherries+=(88635_CM)

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
        #cherries+=(1343_PAC) : this was lost during a gerrit rebuild, suggest the maintainer make a patch file for it
        # Allow using Classic WebView
        cherries+=(56054_CM)
    ;;
    tenderloin)
        # btservice/AdaperState: handle ENABLED_READY in OffState
        PATCH=tenderloin_13-11-25_btservice-AdaperState-handle-ENABLED_READY
        FOLDER=packages/apps/Bluetooth
        patch_it #add this function call for each patch
        # tenderloin_allow devices to specify driver delay
        PATCH=tenderloin_allow-devices-to-specify-driver-delay
        FOLDER=hardware/libhardware_legacy
        patch_it #add this function call for each patch
        # tenderloin_packagemanager-allow-install-to-complete
        PATCH=tenderloin_packagemanager-allow-install-to-complete
        FOLDER=frameworks/base
        patch_it #add this function call for each patch
        # tenderloin_ART-Hack-to-get-working-on-TP
        PATCH=tenderloin_ART-Hack-to-get-working-on-TP
        FOLDER=art
        patch_it #add this function call for each patch
        #sepolicy: add a domain for lvm
        cherries+=(82660_CM)
        #art: allow devices to opt out of GAP check
        cherries+=(82661_CM)
        #libart: Allow adjustment of the base address
        cherries+=(82668_CM)
    ;;
    huashan)
        # kernel-some-folders-can-not-be-used
        PATCH=kernel-some-folders-can-not-be-used
        FOLDER=hardware/cm
        patch_it
        # display-Add-support-for-interleaved-YUY2
        PATCH=0001-REVERT-display-Add-support-for-interleaved-YUY2-and-
        FOLDER=hardware/qcom/display-caf
        patch_it
        # mm-video-venc-Correct-a-typo-in-variable-name
        PATCH=0001-REVERT-mm-video-venc-Correct-a-typo-in-variable-name
        FOLDER=hardware/qcom/media-caf
        patch_it
    ;;
    i9300)
        # change hardware path from hardware/samsung -> hardware/i9300
        PATCH=i9300-fw-av-change-hw-path
        FOLDER=frameworks/av
        patch_it
    ;;
    serranodsdd)
        # initial-support-for-i9192-ril
        PATCH=0001-initial-support-for-i9192-ril
        FOLDER=frameworks/opt/telephony
        patch_it
        # Add-support-for-serranodsril
        PATCH=0001-Add-support-for-serranodsril
        FOLDER=devide/samsung/serrano-common
        patch_it
        # Network-Add-netowrk-modes
        PATCH=0001-Network-Add-netowrk-modes
        FOLDER=packages/services/Telephony
        patch_it
        # add-s4-mini-dual-sim-ril-blobs
        PATCH=0001-add-s4-mini-dual-sim-ril-blobs
        FOLDER=vendor/samsung/serrano-common
        patch_it
    ;;
esac


if [ "$PATCH" != "" ]; then
    echo ""
    echo -e "${bldblu}Done applying the specified patches${rst}"
    echo ""
fi


if [ "$cherries" != "" ]; then
    echo ""
    echo -e "${bldblu}Now cherry-picking the specified cherries${rst}"
    echo ""
    ./build/tools/repopick.py -b "${cherries[@]}"
fi


if [ "$topics" != "" ]; then
    echo ""
    echo -e "${bldblu}Now cherry-picking the specified topics${rst}"
    echo ""
    ./build/tools/repopick.py -is auto -t "${topics[@]}"
fi


if [ "$queries" != "" ]; then
    echo ""
    echo -e "${bldblu}Now cherry-picking based on the specified queries${rst}"
    echo ""
    ./build/tools/repopick.py -is auto -Q "${queries[@]}"
fi

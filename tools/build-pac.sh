#!/bin/bash
: '
 ================ Copyright (C) 2015 PAC-Roms Project ================
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 =====================================================================
'

usage() {
    echo -e "${bldblu}Usage:${bldgrn}"
    echo -e "  build-pac.sh [options] device"
    echo -e ""
    echo -e "${bldblu}  Options:${bldgrn}"
    echo -e "    -a  Disable ADB authentication and set root access to Apps and ADB"
    echo -e "    -b# Prebuilt Chromium options:"
    echo -e "        1 - Remove"
    echo -e "        2 - No Prebuilt Chromium"
    echo -e "    -c# Cleaning options before build:"
    echo -e "        1 - Run make clean"
    echo -e "        2 - Run make installclean"
    echo -e "    -e# Extra build output options:"
    echo -e "        1 - Verbose build output"
    echo -e "        2 - Quiet build output"
    echo -e "    -f  Fetch cherry-picks"
    echo -e "    -j# Set number of jobs"
    echo -e "    -k  Rewrite roomservice after dependencies update"
    echo -e "    -r  Reset source tree before build"
    echo -e "    -s# Sync options before build:"
    echo -e "        1 - Normal sync"
    echo -e "        2 - Make snapshot"
    echo -e "        3 - Restore previous snapshot, then snapshot sync"
    echo -e "    -o# Only build:"
    echo -e "        1 - Boot Image"
    echo -e "        2 - Recovery Image"
    echo -e "    -p  Build using pipe"
    echo -e "    -t  Build ROM with TWRP Recovery (Extreme caution, ONLY for developers)"
    echo -e "        (This may produce an invalid recovery. Use only if you have the correct settings for these)"
    echo -e ""
    echo -e "${bldblu}  Example:${bldgrn}"
    echo -e "    ./build-pac.sh -c1 hammerhead"
    echo -e "${txtrst}"
    exit 1
}


# Import Colors
. ./vendor/pac/tools/colors
echo -e ""


# PAC version
export PAC_VERSION_MAJOR="LP"
export PAC_VERSION_MINOR="Alpha-1"
export PAC_VERSION_MAINTENANCE="dev"    # Acceptible maintenance versions are; stable, dev, nightly


# Maintenance logic
if [ -s ~/PACname ]; then
    export PAC_MAINTENANCE=$(cat ~/PACname)
else
    export PAC_MAINTENANCE="$PAC_VERSION_MAINTENANCE"
fi
export PAC_VERSION="$PAC_VERSION_MAJOR $PAC_VERSION_MINOR $PAC_MAINTENANCE"


# Check directories
if [ ! -d ".repo" ]; then
    echo -e "${bldred}No .repo directory found.  Is this an Android build tree?${txtrst}"
    echo -e ""
    exit 1
fi
if [ ! -d "vendor/pac" ]; then
    echo -e "${bldred}No vendor/pac directory found.  Is this a PAC build tree?${txtrst}"
    echo -e ""
    exit 1
fi


# Figure out the output directories
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
thisDIR="${PWD##*/}"

findOUT() {
    if [ -n "${OUT_DIR_COMMON_BASE+x}" ]; then
        return 1
    else
        return 0
    fi
}

findOUT
RES="$?"

if [ $RES = 1 ];then
    export OUTDIR=$OUT_DIR_COMMON_BASE/$thisDIR
    echo -e "${bldblu}External out directory is set to: ${bldgrn}($OUTDIR)"
elif [ $RES = 0 ];then
    export OUTDIR=$DIR/out
    echo -e "${bldblu}No external out, using default: ${bldgrn}($OUTDIR)"
else
    echo -e "${bldred}NULL"
    echo -e "Error, wrong results! Blame the split screen!"
fi
echo -e "${txtrst}"


# Get OS (Linux / Mac OS X)
IS_DARWIN=$(uname -a | grep Darwin)
if [ -n "$IS_DARWIN" ]; then
    CPUS=$(sysctl hw.ncpu | awk '{print $2}')
    DATE=gdate
else
    CPUS=$(grep "^processor" /proc/cpuinfo -c)
    DATE=date
fi


# Get time of startup
t1=$($DATE +%s)


# Use Ccache
export USE_CCACHE=1


opt_adb=0
opt_chromium=0
opt_clean=0
opt_extra=0
opt_fetch=0
opt_jobs="$CPUS"
opt_kr=0
opt_only=0
opt_pipe=0
opt_reset=0
opt_sync=0
opt_twrp=0

while getopts "ab:c:e:fj:ko:prs:t" opt; do
    case "$opt" in
    a) opt_adb=1 ;;
    b) opt_chromium="$OPTARG" ;;
    c) opt_clean="$OPTARG" ;;
    e) opt_extra="$OPTARG" ;;
    f) opt_fetch=1 ;;
    j) opt_jobs="$OPTARG" ;;
    k) opt_kr=1 ;;
    o) opt_only="$OPTARG" ;;
    p) opt_pipe=1 ;;
    r) opt_reset=1 ;;
    s) opt_sync="$OPTARG" ;;
    t) opt_twrp=1 ;;
    *) usage
    esac
done

shift $((OPTIND-1))
if [ "$#" -ne 1 ]; then
    usage
fi
device="$1"


# Chromium options
if [ "$opt_chromium" -eq 1 ]; then
    rm -rf prebuilts/chromium/"$device"
    echo -e "${bldblu}Prebuilt Chromium for $device removed${txtrst}"
    echo -e ""
elif [ "$opt_chromium" -eq 2 ]; then
    unset USE_PREBUILT_CHROMIUM
    echo -e "${bldblu}Prebuilt Chromium will not be used${txtrst}"
    echo -e ""
else
    export USE_PREBUILT_CHROMIUM=1
fi


# PAC device dependencies
echo -e "${bldblu}Looking for PAC product dependencies${bldgrn}"
if [ "$opt_kr" -ne 0 ]; then
    vendor/pac/tools/getdependencies.py "$device" "$opt_kr"
else
    vendor/pac/tools/getdependencies.py "$device"
fi
echo -e "${txtrst}"


# Cleaning out directory
if [ "$opt_clean" -eq 1 ]; then
    make clean >/dev/null
    echo -e "${bldblu}Output directory is: ${bldgrn}Clean"
elif [ "$opt_clean" -eq 2 ]; then
    . build/envsetup.sh
    lunch "pac_$device-userdebug"
    make installclean >/dev/null
    echo -e "${bldblu}output directory is: ${bldred}Dirty"
else
    echo -e "${bldblu}Output directory is: ${bldylw}Untouched"
fi
echo -e "${txtrst}"


# TWRP Recovery
if [ "$opt_twrp" -eq 1 ]; then
    echo -e "${bldblu}TWRP Recovery will be built${txtrst}"
    export RECOVERY_VARIANT=twrp
    echo -e ""
else
    unset RECOVERY_VARIANT
fi


# Disable ADB authentication
if [ "$opt_adb" -ne 0 ]; then
    echo -e "${bldblu}Disabling ADB authentication and setting root access to Apps and ADB${txtrst}"
    export DISABLE_ADB_AUTH=true
    echo -e ""
else
    unset DISABLE_ADB_AUTH
fi


# Reset source tree
if [ "$opt_reset" -ne 0 ]; then
    echo -e "${bldblu}Resetting source tree and removing all uncommitted changes${txtrst}"
    repo forall -c "git reset --hard HEAD; git clean -qf"
    echo -e ""
fi


# Repo sync/snapshot
if [ "$opt_sync" -eq 1 ]; then
    # Sync with latest sources
    echo -e "${bldblu}Fetching latest sources${txtrst}"
    repo sync -j"$opt_jobs"
    echo -e ""
elif [ "$opt_sync" -eq 2 ]; then
    # Take snapshot of current sources
    echo -e "${bldblu}Making a snapshot of the repo${txtrst}"
    repo manifest -o snapshot-"$device".xml -r
    echo -e ""
elif [ "$opt_sync" -eq 3 ]; then
    # Restore snapshot tree, then sync with latest sources
    echo -e "${bldblu}Restoring last snapshot of sources${txtrst}"
    echo -e ""
    cp snapshot-"$device".xml .repo/manifests/

    # Prevent duplicate projects
    cd .repo/local_manifests
    for file in *.xml; do
        mv "$file" "$(echo $file | sed 's/\(.*\.\)xml/\1xmlback/')"
    done

    # Start snapshot file
    cd "$DIR"
    repo init -m snapshot-"$device".xml
    echo -e "${bldblu}Fetching snapshot sources${txtrst}"
    echo -e ""
    repo sync -d -j"$opt_jobs"

    # Prevent duplicate backups
    cd .repo/local_manifests
    for file in *.xmlback; do
        mv "$file" "$(echo $file | sed 's/\(.*\.\)xmlback/\1xml/')"
    done

    # Remove snapshot file
    cd "$DIR"
    rm -f .repo/manifests/snapshot-"$device".xml
    repo init
fi


# Fetch cherry-picks
if [ "$opt_fetch" -ne 0 ]; then
    ./vendor/pac/tools/cherries.sh "$device"
fi


# Setup environment
echo -e "${bldblu}Setting up environment${txtrst}"
. build/envsetup.sh


# This will create a new build.prop with updated build time and date
rm -f "$OUTDIR"/target/product/"$device"/system/build.prop

# This will create a new .version for kernel version is maintained on one
rm -f "$OUTDIR"/target/product/"$device"/obj/KERNEL_OBJ/.version


# Lunch device
echo -e ""
echo -e "${bldblu}Lunching device${bldgrn}"
lunch "pac_$device-userdebug"


# Pipe option
if [ "$opt_pipe" -ne 0 ]; then
    export TARGET_USE_PIPE=true
else
    unset TARGET_USE_PIPE
fi


# Start compilation
if [ "$opt_only" -eq 1 ]; then
    echo -e "${bldblu}Starting compilation: ${bldgrn}Only will be built Boot Image${txtrst}"
    echo -e ""
    make -j"$opt_jobs" bootimage
elif [ "$opt_only" -eq 2 ]; then
    echo -e "${bldblu}Starting compilation: ${bldgrn}Only will be built Recovery Image${txtrst}"
    echo -e ""
    make -j"$opt_jobs" recoveryimage
else
    echo -e "${bldblu}Starting compilation: ${bldblu}Building ${bldgrn}P ${bldred}A ${bldblu}C ${bldylw}$PAC_VERSION${txtrst}"
    echo -e ""
    if [ "$opt_extra" -eq 1 ]; then
        make -j"$opt_jobs" showcommands bacon
    elif [ "$opt_extra" -eq 2 ]; then
        make -j"$opt_jobs" -s bacon
    else
        make -j"$opt_jobs" bacon
    fi
fi


# Cleanup unused built
rm -f "$OUTDIR"/target/product/"$device"/cm-*.*
rm -f "$OUTDIR"/target/product/"$device"/pac_*-ota*.zip


# Finished! Get elapsed time
t2=$($DATE +%s)
tmin=$(( (t2-t1)/60 ))
tsec=$(( (t2-t1)%60 ))
echo -e "#### ${bldblu}Total time elapsed: ${bldgrn}$tmin minutes $tsec seconds ${txtrst}####"
echo -e ""

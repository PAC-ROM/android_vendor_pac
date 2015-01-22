#!/bin/bash

# PAC version
export PAC_VERSION_MAJOR="LP"
export PAC_VERSION_MINOR="Alpha-1"
export PAC_VERSION_MAINTENANCE="dev"
# Acceptible maintenance versions are; stable, dev, nightly

# PAC version logic
if [ -s ~/PACname ]; then
    export PAC_MAINTENANCE=$(cat ~/PACname)
else
    export PAC_MAINTENANCE="$PAC_VERSION_MAINTENANCE"
fi
export PAC_VERSION="$PAC_VERSION_MAJOR $PAC_VERSION_MINOR $PAC_MAINTENANCE"

usage()
{
    echo -e ""
    echo -e ${txtbld}"Usage:"${txtrst}
    echo -e "  build-pac.sh [options] device"
    echo -e ""
    echo -e ${txtbld}"  Options:"${txtrst}
    echo -e "    -a  Disable ADB authentication and set root access to Apps and ADB"
    echo -e "    -b# Prebuilt Chromium options:"
    echo -e "        1 - Remove"
    echo -e "        2 - No Prebuilt Chromium"
    echo -e "    -c# Cleaning options before build:"
    echo -e "        1 - Run make clean"
    echo -e "        2 - Run make installclean"
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
    echo -e "    -v  Verbose build output"
    echo -e ""
    echo -e ${txtbld}"  Example:"${txtrst}
    echo -e "    ./build-pac.sh -c1 hammerhead"
    echo -e ""
    exit 1
}

# Colors
. ./vendor/pac/tools/colors

if [ ! -d ".repo" ]; then
    echo -e ${red}"No .repo directory found.  Is this an Android build tree?"${txtrst}
    exit 1
fi
if [ ! -d "vendor/pac" ]; then
    echo -e ${red}"No vendor/pac directory found.  Is this a PAC build tree?"${txtrst}
    exit 1
fi

# Figure out the output directories
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
thisDIR="${PWD##*/}"

findOUT() {
if [ -n "${OUT_DIR_COMMON_BASE+x}" ]; then
return 1; else
return 0
fi;}

findOUT
RES="$?"

if [ $RES = 1 ];then
    export OUTDIR=$OUT_DIR_COMMON_BASE/$thisDIR
    echo -e ""
    echo -e ${cya}"External out directory is set to: ($OUTDIR)"${txtrst}
    echo -e ""
elif [ $RES = 0 ];then
    export OUTDIR=$DIR/out
    echo -e ""
    echo -e ${cya}"No external out, using default: ($OUTDIR)"${txtrst}
    echo -e ""
else
    echo -e ""
    echo -e ${red}"NULL"${txtrst}
    echo -e ${red}"Error, wrong results! Blame the split screen!"${txtrst}
    echo -e ""
fi

# Get OS (Linux / Mac OS X)
IS_DARWIN=$(uname -a | grep Darwin)
if [ -n "$IS_DARWIN" ]; then
    CPUS=$(sysctl hw.ncpu | awk '{print $2}')
    DATE=gdate
else
    CPUS=$(grep "^processor" /proc/cpuinfo | wc -l)
    DATE=date
fi

export USE_PREBUILT_CHROMIUM=1
export USE_CCACHE=1

opt_adb=0
opt_chromium=0
opt_clean=0
opt_fetch=0
opt_jobs="$CPUS"
opt_kr=0
opt_only=0
opt_pipe=0
opt_reset=0
opt_sync=0
opt_twrp=0
opt_verbose=0

while getopts "ab:c:fj:ko:prs:tv" opt; do
    case "$opt" in
    a) opt_adb=1 ;;
    b) opt_chromium="$OPTARG" ;;
    c) opt_clean="$OPTARG" ;;
    f) opt_fetch=1 ;;
    j) opt_jobs="$OPTARG" ;;
    k) opt_kr=1 ;;
    o) opt_only="$OPTARG" ;;
    p) opt_pipe=1 ;;
    r) opt_reset=1 ;;
    s) opt_sync="$OPTARG" ;;
    t) opt_twrp=1 ;;
    v) opt_verbose=1 ;;
    *) usage
    esac
done
shift $((OPTIND-1))
if [ "$#" -ne 1 ]; then
    usage
fi
device="$1"

echo -e ${cya}"Building ${bldgrn}P ${bldppl}A ${bldblu}C ${bldylw}$PAC_VERSION"${txtrst}

if [ "$opt_chromium" -eq 1 ]; then
    rm -rf prebuilts/chromium/$device
    echo -e ""
    echo -e ${bldblu}"Prebuilt Chromium for $device removed"${txtrst}
elif [ "$opt_chromium" -eq 2 ]; then
    unset USE_PREBUILT_CHROMIUM
    echo -e ""
    echo -e ${bldblu}"Prebuilt Chromium will not be used"${txtrst}
fi

# PAC device dependencies
echo -e ""
echo -e ${bldblu}"Looking for PAC product dependencies${txtrst}"${cya}
if [ "$opt_kr" -ne 0 ]; then
    vendor/pac/tools/getdependencies.py "$device" "$opt_kr"
else
    vendor/pac/tools/getdependencies.py "$device"
fi
echo -e "${txtrst}"

if [ "$opt_clean" -eq 1 ]; then
    make clean >/dev/null
    echo -e ${bldblu}"Out is clean"${txtrst}
    echo -e ""
elif [ "$opt_clean" -eq 2 ]; then
    . build/envsetup.sh && lunch "pac_$device-userdebug";
    make installclean >/dev/null
    echo -e ${bldblu}"Out is dirty"${txtrst}
    echo -e ""
fi

# TWRP Recovery
if [ "$opt_twrp" -eq 1 ]; then
    echo -e ${bldblu}"TWRP Recovery will be built"${txtrst}
    export RECOVERY_VARIANT=twrp
    echo -e ""
else
    unset RECOVERY_VARIANT
fi

# Disable ADB authentication and set root access to Apps and ADB
if [ "$opt_adb" -ne 0 ]; then
    echo -e ${bldblu}"Disabling ADB authentication and setting root access to Apps and ADB"${txtrst}
    export DISABLE_ADB_AUTH=true
    echo -e ""
else
    unset DISABLE_ADB_AUTH
fi

# Reset source tree
if [ "$opt_reset" -ne 0 ]; then
    echo -e ${bldblu}"Resetting source tree and removing all uncommitted changes"${txtrst}
    repo forall -c "git reset --hard HEAD; git clean -qf"
    echo -e ""
fi

# Repo sync/snapshot
if [ "$opt_sync" -eq 1 ]; then
    # Sync with latest sources
    echo -e ${bldblu}"Fetching latest sources"${txtrst}
    repo sync -j"$opt_jobs"
    echo -e ""
elif [ "$opt_sync" -eq 2 ]; then
    # Take snapshot of current sources
    echo -e ${bldblu}"Making a snapshot of the repo"${txtrst}
    repo manifest -o snapshot-$device.xml -r
    echo -e ""
elif [ "$opt_sync" -eq 3 ]; then
    # Restore snapshot tree, then sync with latest sources
    echo -e ${bldblu}"Restoring last snapshot of sources"${txtrst}
    echo -e ""
    cp snapshot-$device.xml .repo/manifests/

    # Prevent duplicate projects
    cd .repo/local_manifests
      for file in *.xml ; do mv $file `echo $file | sed 's/\(.*\.\)xml/\1xmlback/'` ; done

    cd $DIR
    repo init -m snapshot-$device.xml
    echo -e ${bldblu}"Fetching snapshot sources"${txtrst}
    repo sync -d -j"$opt_jobs"
    cd .repo/local_manifests
      for file in *.xmlback ; do mv $file `echo $file | sed 's/\(.*\.\)xmlback/\1xml/'` ; done
    echo -e ""
    cd $DIR
    rm -f .repo/manifests/snapshot-$device.xml
    repo init
fi

rm -f $OUTDIR/target/product/$device/obj/KERNEL_OBJ/.version

# Fetch cherry-picks
if [ "$opt_fetch" -ne 0 ]; then
    ./vendor/pac/tools/cherries.sh $device
fi

# Get time of startup
t1=$($DATE +%s)

# Setup environment
echo -e ${bldblu}"Setting up environment"${txtrst}
. build/envsetup.sh

# Remove system folder (This will create a new build.prop with updated build time and date)
rm -f $OUTDIR/target/product/$device/system/build.prop

# Lunch device
echo -e ""
echo -e ${bldblu}"Lunching device"${txtrst}
lunch "pac_$device-userdebug";

# Start compilation
if [ "$opt_pipe" -ne 0 ]; then
    export TARGET_USE_PIPE=true
else
    unset TARGET_USE_PIPE
fi

if [ "$opt_only" -eq 1 ]; then
    echo -e ${bldblu}"Starting compilation: ${cya}Only will be built Boot Image"${txtrst}
    echo -e ""
    make -j"$opt_jobs" bootimage
elif [ "$opt_only" -eq 2 ]; then
    echo -e ${bldblu}"Starting compilation: ${cya}Only will be built Recovery Image"${txtrst}
    echo -e ""
    make -j"$opt_jobs" recoveryimage
else
    echo -e ${bldblu}"Starting compilation"${txtrst}
    echo -e ""
    if [ "$opt_verbose" -ne 0 ]; then
        make -j"$opt_jobs" showcommands bacon
    else
        make -j"$opt_jobs" bacon
    fi
fi
echo -e ""

# Cleanup unused built
rm -f $OUTDIR/target/product/$device/cm-*.*
rm -f $OUTDIR/target/product/$device/pac_*-ota*.zip

# Finished! Get elapsed time
t2=$($DATE +%s)

tmin=$(( (t2-t1)/60 ))
tsec=$(( (t2-t1)%60 ))

echo -e ${bldgrn}"Total time elapsed:${txtrst} ${grn}$tmin minutes $tsec seconds"${txtrst}
echo -e ${bldred}"********************************************************************************"${txtrst}
echo -e ${bldred}"*******************************PLEASE READ THIS!!*******************************"${txtrst}
echo -e ""
echo -e ${bldylw}"     Please remember that this source is currently for private builds ONLY!"${txtrst}
echo -e ""
echo -e ${bldylw}"       Public builds are NOT ALLOWED, all public builds will be removed.${txtrst}"${txtrst}
echo -e ""
echo -e ${bldylw}"   It will be welcomed after nightlies (5.0) begin. Thank you, the Developers.${txtrst}"${txtrst}
echo -e ""
echo -e ${bldred}"*******************************PLEASE READ THIS!!*******************************"${txtrst}
echo -e ${bldred}"********************************************************************************"${txtrst}

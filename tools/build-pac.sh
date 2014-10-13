#!/bin/bash

#Pac version
export PAC_VERSION_MAJOR="KK"
export PAC_VERSION_MINOR="RC-2"
export PAC_VERSION_MAINTENANCE="dev"
# Acceptible maitenance versions are; Stable, Dev, Nightly

# pac Version Logic
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
    echo -e "    -c# Cleaning options before build:"
    echo -e "        1 - make clean"
    echo -e "        2 - make dirty"
    echo -e "        3 - make magicbrownies"
    echo -e "    -d  Use dex optimizations"
    echo -e "    -f  Fetch cherry-picks"
    echo -e "    -j# Set jobs"
    echo -e "    -k  Set -k1 to rewrite roomservice after dependencies update"
    echo -e "    -r  Reset source tree before build"
    echo -e "    -s#  Sync options before build"
    echo -e "        1 - normal sync"
    echo -e "        2 - restore previous snapshot, then snapshot sync"
    echo -e "    -p  Build using pipe"
    echo -e "    -o# Select GCC O Level"
    echo -e "        Valid O Levels are"
    echo -e "        1 (Os) or 3 (O3)"
    echo -e "    -t# Build with a different Recovery (extreme caution, ONLY for developers)"
    echo -e "        1 - Build TWRP Recovery (extreme caution, ONLY for developers)"
    echo -e "        2 - Build CM Recovery (extreme caution, ONLY for developers)"
    echo -e "        (this may produce invalid recovery. Use only if you have the correct settings for these)"
    echo -e "    -v  Verbose build output"
    echo -e ""
    echo -e ${txtbld}"  Example:"${txtrst}
    echo -e "    ./build-pac.sh -c1 hammerhead"
    echo -e ""
    exit 1
}

# colors
. ./vendor/pac/tools/colors

if [ ! -d ".repo" ]; then
    echo -e ${red}"No .repo directory found.  Is this an Android build tree?"${txtrst}
    exit 1
fi
if [ ! -d "vendor/pac" ]; then
    echo -e ${red}"No vendor/pac directory found.  Is this a PAC build tree?"${txtrst}
    exit 1
fi

# figure out the output directories
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
    echo -e ${cya}"External out DIR is set ($OUTDIR)"${txtrst}
    echo -e ""
elif [ $RES = 0 ];then
    export OUTDIR=$DIR/out
    echo -e ""
    echo -e ${cya}"No external out, using default ($OUTDIR)"${txtrst}
    echo -e ""
else
    echo -e ""
    echo -e ${red}"NULL"${txtrst}
    echo -e ${red}"Error wrong results; blame tyler"${txtrst}
    echo -e ""
fi

# get OS (linux / Mac OS x)
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
opt_clean=0
opt_dex=0
opt_fetch=0
opt_jobs="$CPUS"
opt_kr=0
opt_olvl=0
opt_pipe=0
opt_reset=0
opt_sync=0
opt_recovery=0
opt_verbose=0

while getopts "ac:dfj:ko:prs:t:v" opt; do
    case "$opt" in
    a) opt_adb=1 ;;
    c) opt_clean="$OPTARG" ;;
    d) opt_dex=1 ;;
    f) opt_fetch=1 ;;
    j) opt_jobs="$OPTARG" ;;
    k) opt_kr=1 ;;
    o) opt_olvl="$OPTARG" ;;
    p) opt_pipe=1 ;;
    r) opt_reset=1 ;;
    s) opt_sync="$OPTARG" ;;
    t) opt_recovery="$OPTARG" ;;
    v) opt_verbose=1 ;;
    *) usage
    esac
done
shift $((OPTIND-1))
if [ "$#" -ne 1 ]; then
    usage
fi
device="$1"

# get current version
eval $(grep "^PAC_VERSION_" vendor/pac/config/pac_common.mk | sed 's/ [:=]\+ /=/g' | sed 's/shell //g')
VERSION="$PAC_VERSION_MAJOR.$PAC_VERSION_MINOR.$PAC_VERSION_MAINTENANCE"

echo -e ${cya}"Building ${bldgrn}P ${bldppl}A ${bldblu}C ${bldylw}v$VERSION"${txtrst}

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
    echo -e ""
    echo -e ${bldblu}"Out is clean"${txtrst}
    echo -e ""
elif [ "$opt_clean" -eq 2 ]; then
    make dirty >/dev/null
    echo -e ""
    echo -e ${bldblu}"Out is dirty"${txtrst}
    echo -e ""
elif [ "$opt_clean" -eq 3 ]; then
    make magicbrownies >/dev/null
    echo -e ""
    echo -e ${bldblu}"Enjoy your magical adventure"${txtrst}
    echo -e ""
fi

# download prebuilt files
date=`date '+%d'`
if [ -x "vendor/cm/get-prebuilts" -a ! -d "vendor/cm/proprietary" ] || [ $date == 01 ] || [ $date == 15 ]; then
    echo -e ""
    echo -e ${bldblu}"Downloading prebuilts"${txtrst}
    vendor/cm/get-prebuilts
    echo -e ""
fi

# TWRP Recovery
if [ "$opt_recovery" -eq 1 ]; then
    echo -e ""
    echo -e ${bldblu}"TWRP Recovery will be built"${txtrst}
    export RECOVERY_VARIANT=twrp
    echo -e ""
elif [ "$opt_recovery" -eq 2 ]; then
    echo -e ""
    echo -e ${bldblu}"CM Recovery will be built"${txtrst}
    export RECOVERY_VARIANT=cm
    echo -e ""
else
    unset RECOVERY_VARIANT
fi

# Disable ADB authentication and set root access to Apps and ADB
if [ "$opt_adb" -ne 0 ]; then
    echo -e ""
    echo -e ${bldblu}"Disabling ADB authentication and setting root access to Apps and ADB"${txtrst}
    export DISABLE_ADB_AUTH=true
    echo -e ""
else
    unset DISABLE_ADB_AUTH
fi

# reset source tree
if [ "$opt_reset" -ne 0 ]; then
    echo -e ""
    echo -e ${bldblu}"Resetting source tree and removing all uncommitted changes"${txtrst}
    repo forall -c "git reset --hard HEAD; git clean -qf"
    echo -e ""
fi

# take snapshot of current sources
echo -e ${bldblu}"Making a snapshot of the repo"${txtrst}
repo manifest -o snapshot-$device.xml -r
echo -e ""

if [ "$opt_sync" -eq 1 ]; then
    # sync with latest sources
    echo -e ""
    echo -e ${bldblu}"Fetching latest sources"${txtrst}
    repo sync -j"$opt_jobs"
    echo -e ""
elif [ "$opt_sync" -eq 2 ]; then
    # restore snapshot tree, then sync with latest sources
    echo -e ""
    echo -e ${bldblu}"Restoring last snapshot of sources"${txtrst}
    echo -e ""
    cp snapshot-$device.xml .repo/manifests/

    #prevent duplicate projects
    cd .repo/local_manifests
      for file in *.xml ; do mv $file `echo $file | sed 's/\(.*\.\)xml/\1xmlback/'` ; done

    cd $DIR
    repo init -m snapshot-$device.xml
    echo -e ""
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

# fetch cherry-picks
if [ "$opt_fetch" -ne 0 ]; then
        ./vendor/pac/tools/cherries.sh $device
fi

# get time of startup
t1=$($DATE +%s)

# setup environment
echo -e ${bldblu}"Setting up environment"${txtrst}
. build/envsetup.sh

# Remove system folder (this will create a new build.prop with updated build time and date)
rm -f $OUTDIR/target/product/$device/system/build.prop
rm -f $OUTDIR/target/product/$device/system/app/*.odex
rm -f $OUTDIR/target/product/$device/system/framework/*.odex

# lunch device
echo -e ""
echo -e ${bldblu}"Lunching device"${txtrst}
lunch "pac_$device-userdebug";

echo -e ""
echo -e ${bldblu}"Starting compilation"${txtrst}

# start compilation
if [ "$opt_dex" -ne 0 ]; then
    export WITH_DEXPREOPT=true
else
    unset WITH_DEXPREOPT
fi

if [ "$opt_pipe" -ne 0 ]; then
    export TARGET_USE_PIPE=true
else
    unset TARGET_USE_PIPE
fi

if [ "$opt_olvl" -eq 1 ]; then
    export TARGET_USE_O_LEVEL_S=true
    echo -e ""
    echo -e ${bldgrn}"Using Os Optimization"${txtrst}
    echo -e ""
elif [ "$opt_olvl" -eq 3 ]; then
    export TARGET_USE_O_LEVEL_3=true
    echo -e ""
    echo -e ${bldgrn}"Using O3 Optimization"${txtrst}
    echo -e ""
else
    unset TARGET_USE_O_LEVEL_S
    unset TARGET_USE_O_LEVEL_3
    echo -e ""
    echo -e ${bldgrn}"Using the default GCC Optimization Level, O2"${txtrst}
    echo -e ""
fi

if [ "$opt_verbose" -ne 0 ]; then
make -j"$opt_jobs" showcommands bacon
else
make -j"$opt_jobs" bacon
fi
echo -e ""

# squisher
vendor/pac/tools/squisher

# cleanup unused built
rm -f $OUTDIR/target/product/$device/cm-*.*
rm -f $OUTDIR/target/product/$device/pac_*-ota*.zip

# finished? get elapsed time
t2=$($DATE +%s)

tmin=$(( (t2-t1)/60 ))
tsec=$(( (t2-t1)%60 ))

echo -e ${bldgrn}"Total time elapsed:${txtrst} ${grn}$tmin minutes $tsec seconds"${txtrst}

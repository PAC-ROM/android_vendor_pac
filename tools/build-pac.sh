#!/bin/bash

# PAC version
export PAC_VERSION_MAJOR="LP"
export PAC_VERSION_MINOR="Beta-1"
export PAC_VERSION_MAINTENANCE="Unofficial"
# Acceptable maintenance versions are; Stable, Official, Nightly or Unofficial

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
    echo -e "${bldwhi}Usage:${rst}"
    echo -e "  build-pac.sh [options] device"
    echo -e ""
    echo -e "${bldwhi}  Options:${rst}"
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
    echo -e "    -f  Fetch extras"
    echo -e "    -j# Set number of jobs"
    echo -e "    -l  Optimizations for devices with low-RAM"
    echo -e "    -k  Rewrite roomservice after dependencies update"
    echo -e "    -i  Ignore minor errors during build"
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
    echo -e "${bldwhi}  Example:${rst}"
    echo -e "    ./build-pac.sh -c1 hammerhead"
    echo -e ""
    exit 1
}

# Colors
. ./vendor/pac/tools/colors

if [ ! -d ".repo" ]; then
    echo -e "${bldred}No .repo directory found.  Is this an Android build tree?${rst}"
    exit 1
fi
if [ ! -d "vendor/pac" ]; then
    echo -e "${bldred}No vendor/pac directory found.  Is this a PAC build tree?${rst}"
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
    echo -e "${cya}External out directory is set to: ($OUTDIR)${rst}"
    echo -e ""
elif [ $RES = 0 ];then
    export OUTDIR=$DIR/out
    echo -e ""
    echo -e "${cya}No external out, using default: ($OUTDIR)${rst}"
    echo -e ""
else
    echo -e ""
    echo -e "${bldred}NULL${rst}"
    echo -e "${bldred}Error, wrong results! Blame the split screen!${rst}"
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
opt_extra=0
opt_fetch=0
opt_jobs="$CPUS"
opt_kr=0
opt_ignore=0
opt_lrd=0
opt_only=0
opt_pipe=0
opt_reset=0
opt_sync=0
opt_twrp=0

while getopts "ab:c:e:fj:kilo:prs:t" opt; do
    case "$opt" in
    a) opt_adb=1 ;;
    b) opt_chromium="$OPTARG" ;;
    c) opt_clean="$OPTARG" ;;
    e) opt_extra="$OPTARG" ;;
    f) opt_fetch=1 ;;
    j) opt_jobs="$OPTARG" ;;
    k) opt_kr=1 ;;
    i) opt_ignore=1 ;;
    l) opt_lrd=1 ;;
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

echo -e "$Building ${bldylw}PAC-ROM ${bldmag}$PAC_VERSION_MAJOR${rst} ${bldcya}$PAC_VERSION_MINOR ${bldred}$PAC_MAINTENANCE${rst}"

if [ "$opt_chromium" -eq 1 ]; then
    rm -rf prebuilts/chromium/$device
    echo -e ""
    echo -e "${bldcya}Prebuilt Chromium for $device removed${rst}"
elif [ "$opt_chromium" -eq 2 ]; then
    unset USE_PREBUILT_CHROMIUM
    echo -e ""
    echo -e "${bldcya}Prebuilt Chromium will not be used${rst}"
fi

# PAC device dependencies
echo -e ""
echo -e "${bldcya}Looking for PAC product dependencies${rst}${cya}"
if [ "$opt_kr" -ne 0 ]; then
    vendor/pac/tools/getdependencies.py "$device" "$opt_kr"
else
    vendor/pac/tools/getdependencies.py "$device"
fi
echo -e "${rst}"

# Check if last build was made ignoring errors
# Set if unset
if [ -f ".ignore_err" ]; then
   : ${TARGET_IGNORE_ERRORS:=$(cat .ignore_err)}
else
   : ${TARGET_IGNORE_ERRORS:=false}
fi

export TARGET_IGNORE_ERRORS

if [ "$TARGET_IGNORE_ERRORS" == "true" ]; then
   opt_clean=1
   echo -e ${bldred}"Last build ignored errors. Cleaning Out"${rst}
   unset TARGET_IGNORE_ERRORS
   echo -e "false" > .ignore_err

fi

if [ "$opt_clean" -eq 1 ]; then
    make clean >/dev/null
    echo -e "${bldcya}Out is clean${rst}"
    echo -e ""
elif [ "$opt_clean" -eq 2 ]; then
    . build/envsetup.sh && lunch "pac_$device-userdebug";
    make installclean >/dev/null
    echo -e "${bldcya}Out is dirty${rst}"
    echo -e ""
fi

# TWRP Recovery
if [ "$opt_twrp" -eq 1 ]; then
    echo -e "${bldcya}TWRP Recovery will be built${rst}"
    export RECOVERY_VARIANT=twrp
    echo -e ""
else
    unset RECOVERY_VARIANT
fi

# Disable ADB authentication and set root access to Apps and ADB
if [ "$opt_adb" -ne 0 ]; then
    echo -e "${bldcya}Disabling ADB authentication and setting root access to Apps and ADB${rst}"
    export DISABLE_ADB_AUTH=true
    echo -e ""
else
    unset DISABLE_ADB_AUTH
fi

# Lower RAM devices
if [ "$opt_lrd" -ne 0 ]; then
    echo -e ${bldblu}"Applying optimizations for devices with low RAM"${txtrst}
    export PAC_LOW_RAM_DEVICE=true
    echo -e ""
else
    unset PAC_LOW_RAM_DEVICE
fi

# Reset source tree
if [ "$opt_reset" -ne 0 ]; then
    echo -e "${bldcya}Resetting source tree and removing all uncommitted changes${rst}"
    repo forall -c "git reset --hard HEAD; git clean -qf"
    echo -e ""
fi

# Repo sync/snapshot
if [ "$opt_sync" -eq 1 ]; then
    # Sync with latest sources
    echo -e "${bldcya}Fetching latest sources${rst}"
    repo sync -j"$opt_jobs"
    echo -e ""
elif [ "$opt_sync" -eq 2 ]; then
    # Take snapshot of current sources
    echo -e "${bldcya}Making a snapshot of the repo${rst}"
    repo manifest -o snapshot-$device.xml -r
    echo -e ""
elif [ "$opt_sync" -eq 3 ]; then
    # Restore snapshot tree, then sync with latest sources
    echo -e "${bldcya}Restoring last snapshot of sources${rst}"
    echo -e ""
    cp snapshot-$device.xml .repo/manifests/

    # Prevent duplicate projects
    cd .repo/local_manifests
      for file in *.xml ; do mv $file `echo $file | sed 's/\(.*\.\)xml/\1xmlback/'` ; done

    cd $DIR
    repo init -m snapshot-$device.xml
    echo -e "${bldcya}Fetching snapshot sources${rst}"
    repo sync -d -j"$opt_jobs"
    cd .repo/local_manifests
      for file in *.xmlback ; do mv $file `echo $file | sed 's/\(.*\.\)xmlback/\1xml/'` ; done
    echo -e ""
    cd $DIR
    rm -f .repo/manifests/snapshot-$device.xml
    repo init
fi

rm -f $OUTDIR/target/product/$device/obj/KERNEL_OBJ/.version

# Fetch extras
if [ "$opt_fetch" -ne 0 ]; then
    ./vendor/pac/tools/extras.sh $device
fi

# Setup environment
echo -e "${bldcya}Setting up environment${rst}"
. build/envsetup.sh

# Remove system folder (This will create a new build.prop with updated build time and date)
rm -f $OUTDIR/target/product/$device/system/build.prop

# Lunch device
echo -e ""
echo -e "${bldcya}Lunching device${rst}"
lunch "pac_$device-userdebug";

# Start compilation
if [ "$opt_pipe" -ne 0 ]; then
    export TARGET_USE_PIPE=true
else
    unset TARGET_USE_PIPE
fi

if [ "$opt_only" -eq 1 ]; then
    echo -e "${bldcya}Starting compilation: ${cya}Only will be built Boot Image${rst}"
    echo -e ""
    make -j"$opt_jobs" bootimage
elif [ "$opt_only" -eq 2 ]; then
    echo -e "${bldcya}Starting compilation: ${cya}Only will be built Recovery Image${rst}"
    echo -e ""
    make -j"$opt_jobs" recoveryimage
else
    echo -e "${bldcya}Starting compilation${rst}"
    echo -e ""
    if [ "$opt_extra" -eq 1 ]; then
        opt_v=" "showcommands
    elif [ "$opt_extra" -eq 2 ]; then
        opt_v=" "-s
    else
        opt_v=""
    fi
    if [ "$opt_ignore" -eq 1 ]; then
        opt_i=" "-k
	export TARGET_IGNORE_ERRORS=true
        echo -e "true" > .ignore_err
    else
        opt_i=""
    fi

    make -j$opt_jobs$opt_v$opt_i bacon
    fi

# Cleanup unused built
rm -f $OUTDIR/target/product/$device/cm-*.*
rm -f $OUTDIR/target/product/$device/pac_*-ota*.zip

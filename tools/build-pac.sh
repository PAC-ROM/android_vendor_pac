#!/bin/bash
#
# build-pac.sh: the overarching build script for the ROM.
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

usage() {
    echo -e "${bldblu}Usage:${bldcya}"
    echo -e "  build-pac.sh [options] device"
    echo ""
    echo -e "${bldblu}  Options:${bldcya}"
    echo -e "    -a  Disable ADB authentication and set root access to Apps and ADB"
    echo -e "    -c# Cleaning options before build:"
    echo -e "        1 - Run make clean"
    echo -e "        2 - Run make installclean"
    echo -e "    -d  Build rom without ccache"
    echo -e "    -e# Extra build output options:"
    echo -e "        1 - Verbose build output"
    echo -e "        2 - Quiet build output"
    echo -e "    -f  Fetch extras"
    echo -e "    -i  Ignore minor errors during build"
    echo -e "    -j# Set number of jobs"
    echo -e "    -k  Rewrite roomservice after dependencies update"
    echo -e "    -l  Optimizations for devices with low-RAM"
    echo -e "    -o# Only build:"
    echo -e "        1 - Boot Image"
    echo -e "        2 - Recovery Image"
    echo -e "    -p  Build using pipe"
    echo -e "    -r  Reset source tree before build"
    echo -e "    -s# Sync options before build:"
    echo -e "        1 - Normal sync"
    echo -e "        2 - Make snapshot"
    echo -e "        3 - Restore previous snapshot, then snapshot sync"
    echo -e "    -t  Build ROM with TWRP Recovery (Extreme caution, ONLY for developers)"
    echo -e "        (This may produce an invalid recovery. Use only if you have the correct settings for these)"
    echo -e "    -w  Log file options:"
    echo -e "        1 - Send warnings and errors to a log file"
    echo -e "        2 - Send all output to a log file"
    echo ""
    echo -e "${bldblu}  Example:${bldcya}"
    echo -e "    ./build-pac.sh -c1 shamu"
    echo -e "${rst}"
    exit 1
}


# Import Colors
. ./vendor/pac/tools/colors
. ./vendor/pac/tools/res/pac-start


# PAC version
export PAC_VERSION_MAJOR="LP-MR1"
export PAC_VERSION_MINOR="Beta-3"
export PAC_VERSION_MAINTENANCE="Unofficial"
# Acceptable maintenance versions are; Stable, Official, Nightly or Unofficial


# Default global variable values with preference to environmant.
if [ -z "${USE_CCACHE}" ]; then
    export USE_CCACHE=1
fi


# Maintenance logic
if [ -s ~/PACname ]; then
    export PAC_MAINTENANCE=$(cat ~/PACname)
else
    export PAC_MAINTENANCE="$PAC_VERSION_MAINTENANCE"
fi
export PAC_VERSION="$PAC_VERSION_MAJOR $PAC_VERSION_MINOR $PAC_MAINTENANCE"


# Check directories
if [ ! -d ".repo" ]; then
    echo -e "${bldred}No .repo directory found.  Is this an Android build tree?${rst}"
    echo ""
    exit 1
fi
if [ ! -d "vendor/pac" ]; then
    echo -e "${bldred}No vendor/pac directory found.  Is this a PAC build tree?${rst}"
    echo ""
    exit 1
fi


# Figure out the output directories
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
thisDIR="${PWD##*/}"

if [ -n "${OUT_DIR_COMMON_BASE+x}" ]; then
    RES=1
else
    RES=0
fi


if [ $RES = 1 ];then
    export OUTDIR=$OUT_DIR_COMMON_BASE/$thisDIR
    echo -e "${bldcya}External out directory is set to: ${bldgrn}($OUTDIR)${rst}"
    echo ""
elif [ $RES = 0 ];then
    export OUTDIR=$DIR/out
    echo -e "${bldcya}No external out, using default: ${bldgrn}($OUTDIR)${rst}"
    echo ""
else
    echo -e "${bldred}NULL"
    echo -e "Error, wrong results! Blame the split screen!${rst}"
    echo ""
fi


# Get OS (Linux / Mac OS X)
IS_DARWIN=$(uname -a | grep Darwin)
if [ -n "$IS_DARWIN" ]; then
    CPUS=$(sysctl hw.ncpu | awk '{print $2}')
else
    CPUS=$(grep "^processor" /proc/cpuinfo -c)
fi


opt_adb=0
opt_clean=0
opt_ccache=0
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
opt_log=0

while getopts "ac:de:fij:klo:prs:tw:" opt; do
    case "$opt" in
    a) opt_adb=1 ;;
    c) opt_clean="$OPTARG" ;;
    d) opt_ccache=1 ;;
    e) opt_extra="$OPTARG" ;;
    f) opt_fetch=1 ;;
    i) opt_ignore=1 ;;
    j) opt_jobs="$OPTARG" ;;
    k) opt_kr=1 ;;
    l) opt_lrd=1 ;;
    o) opt_only="$OPTARG" ;;
    p) opt_pipe=1 ;;
    r) opt_reset=1 ;;
    s) opt_sync="$OPTARG" ;;
    t) opt_twrp=1 ;;
    w) opt_log="$OPTARG" ;;
    *) usage
    esac
done

shift $((OPTIND-1))
if [ "$#" -ne 1 ]; then
    usage
fi
device="$1"


# Ccache options
if [ "$opt_ccache" -eq 1 ]; then
    echo -e "${bldcya}Ccache not be used in this build${rst}"
    unset USE_CCACHE
    echo ""
fi


# PAC device dependencies
echo -e "${bldcya}Looking for PAC product dependencies${bldgrn}"
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
   echo -e "${bldred}Last build ignored errors. Cleaning Out${rst}"
   unset TARGET_IGNORE_ERRORS
   echo -e "false" > .ignore_err
fi


# Cleaning out directory
if [ "$opt_clean" -eq 1 ]; then
    echo -e "${bldcya}Cleaning output directory${rst}"
    make clean >/dev/null
    echo -e "${bldcya}Output directory is: ${bldgrn}Clean${rst}"
    echo ""
elif [ "$opt_clean" -eq 2 ]; then
    . build/envsetup.sh
    lunch "pac_$device-userdebug"
    make installclean >/dev/null
    echo -e "${bldcya}Output directory is: ${bldred}Dirty${rst}"
    echo ""
else
    if [ -d "$OUTDIR/target" ]; then
        echo -e "${bldcya}Output directory is: ${bldylw}Untouched${rst}"
        echo ""
    else
        echo -e "${bldcya}Output directory is: ${bldgrn}Clean${rst}"
        echo ""
    fi
fi


# TWRP Recovery
if [ "$opt_twrp" -eq 1 ]; then
    echo -e "${bldcya}TWRP Recovery will be built${rst}"
    export RECOVERY_VARIANT=twrp
    echo ""
else
    unset RECOVERY_VARIANT
fi


# Disable ADB authentication
if [ "$opt_adb" -ne 0 ]; then
    echo -e "${bldcya}Disabling ADB authentication and setting root access to Apps and ADB${rst}"
    export DISABLE_ADB_AUTH=true
    echo ""
else
    unset DISABLE_ADB_AUTH
fi


# Lower RAM devices
if [ "$opt_lrd" -ne 0 ]; then
    echo -e "${bldcya}Applying optimizations for devices with low RAM${rst}"
    export PAC_LOW_RAM_DEVICE=true
    echo ""
else
    unset PAC_LOW_RAM_DEVICE
fi


# Reset source tree
if [ "$opt_reset" -ne 0 ]; then
    echo -e "${bldcya}Resetting source tree and removing all uncommitted changes${rst}"
    repo forall -c "git reset --hard HEAD; git clean -qf"
    echo ""
fi


# Repo sync/snapshot
if [ "$opt_sync" -eq 1 ]; then
    # Sync with latest sources
    echo -e "${bldcya}Fetching latest sources${rst}"
    repo sync -j"$opt_jobs"
    echo ""
elif [ "$opt_sync" -eq 2 ]; then
    # Take snapshot of current sources
    echo -e "${bldcya}Making a snapshot of the repo${rst}"
    repo manifest -o snapshot-"$device".xml -r
    echo ""
elif [ "$opt_sync" -eq 3 ]; then
    # Restore snapshot tree, then sync with latest sources
    echo -e "${bldcya}Restoring last snapshot of sources${rst}"
    echo ""
    cp snapshot-"$device".xml .repo/manifests/

    # Prevent duplicate projects
    cd .repo/local_manifests
    for file in *.xml; do
        mv "$file" "$(echo $file | sed 's/\(.*\.\)xml/\1xmlback/')"
    done

    # Start snapshot file
    cd "$DIR"
    repo init -m snapshot-"$device".xml
    echo -e "${bldcya}Fetching snapshot sources${rst}"
    echo ""
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


# Fetch extras
if [ "$opt_fetch" -ne 0 ]; then
    ./vendor/pac/tools/extras.sh "$device"
fi


# Setup environment
echo -e "${bldcya}Setting up environment${rst}"
echo -e "${bldmag}${line}${rst}"
. build/envsetup.sh
echo -e "${bldmag}${line}${rst}"


# This will create a new build.prop with updated build time and date
rm -f "$OUTDIR"/target/product/"$device"/system/build.prop

# This will create a new .version for kernel version is maintained on one
rm -f "$OUTDIR"/target/product/"$device"/obj/KERNEL_OBJ/.version


# Lunch device
echo ""
echo -e "${bldcya}Lunching device${rst}"
lunch "pac_$device-userdebug"


# Pipe option
if [ "$opt_pipe" -ne 0 ]; then
    export TARGET_USE_PIPE=true
else
    unset TARGET_USE_PIPE
fi


# Get extra options for build
if [ "$opt_extra" -eq 1 ]; then
    opt_v=" "showcommands
elif [ "$opt_extra" -eq 2 ]; then
    opt_v=" "-s
else
    opt_v=""
fi


# Ignore minor errors during build
if [ "$opt_ignore" -eq 1 ]; then
    opt_i=" "-k
    export TARGET_IGNORE_ERRORS=true
    echo -e "true" > .ignore_err
    if [ "$opt_log" -eq 0 ]; then
        opt_log=1
    fi
else
    opt_i=""
fi


# Log file options
if [ "$opt_log" -ne 0 ]; then
    rm -rf build.log
    if [ "$opt_log" -eq 1 ]; then
        exec 2> >(sed -r 's/'$(echo -e "\033")'\[[0-9]{1,2}(;([0-9]{1,2})?)?[mK]//g' | tee -a build.log)
    else
        exec &> >(tee -a build.log)
    fi
fi


# Start compilation
unset PAC_MAKE
if [ "$opt_only" -eq 1 ]; then
    echo -e "${bldcya}Starting compilation: ${bldgrn}Building Boot Image only${rst}"
    echo ""
    make -j$opt_jobs$opt_v$opt_i bootzip
elif [ "$opt_only" -eq 2 ]; then
    echo -e "${bldcya}Starting compilation: ${bldgrn}Building Recovery Image only${rst}"
    echo ""
    export PAC_MAKE=recoveryimage
    make -j$opt_jobs$opt_v$opt_i recoveryimage
else
    echo -e "${bldcya}Starting compilation: ${bldgrn}Building ${bldylw}PAC-ROM ${bldmag}$PAC_VERSION_MAJOR ${bldcya}$PAC_VERSION_MINOR ${bldred}$PAC_MAINTENANCE${rst}"
    echo ""
    make -j$opt_jobs$opt_v$opt_i bacon
fi


# Cleanup unused built
rm -f "$OUTDIR"/target/product/"$device"/cm-*.*
rm -f "$OUTDIR"/target/product/"$device"/pac_*-ota*.zip

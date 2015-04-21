#!/sbin/sh
#
# backuptool.sh: Backup and restore addon /system files
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

export C=/tmp/backupdir
export S=/system
export V="LP-MR1"

# Scripts in /system/addon.d expect to find backuptool.functions in /tmp
cp -f /tmp/install/bin/backuptool.functions /tmp

# Preserve /system/addon.d in /tmp/addon.d
preserve_addon_d() {
    mkdir -p /tmp/addon.d/
    cp -a /system/addon.d/* /tmp/addon.d/
    chmod 755 /tmp/addon.d/*.sh
}

# Restore /system/addon.d in /tmp/addon.d
restore_addon_d() {
    cp -a /tmp/addon.d/* /system/addon.d/
    rm -rf /tmp/addon.d/
}

# Proceed only if /system is the expected major and minor version
check_prereq() {
    retval=1
    ver=$(awk "/ro.pac.version=($V)/ {print \"LP\"}" /system/build.prop)
    case "$ver" in
        LP)
            echo "Found compatible version, backing up files."
        ;;
         *)
            echo "Not backing up files from incompatible version: $V"
            retval=0
        ;;
    esac
    return $retval
}

check_blacklist() {
    if [ -f /system/addon.d/blacklist ];then
        ## Discard any known bad backup scripts
        cd /"$1"/addon.d/
        for f in *sh; do
            s=$(md5sum "$f" | awk '{print $1}')
            grep -q "$s" /system/addon.d/blacklist && rm -f "$f"
        done
    fi
}

check_whitelist() {
    found=0
    if [ -f /system/addon.d/whitelist ];then
        ## forcefully keep any version-independent stuff
        cd /"$1"/addon.d/
        for f in *sh; do
            s=$(md5sum "$f" | awk '{print $1}')
            grep -q "$s" /system/addon.d/whitelist
            if [ $? -eq 0 ]; then
                found=1
            else
                rm -f "$f"
            fi
        done
    fi
    return $found
}

# Execute /system/addon.d/*.sh scripts with $1 parameter
run_stage() {
    for script in $(find /tmp/addon.d/ -name '*.sh' |sort -n); do
        $script "$1"
    done;
}

case "$1" in
    backup)
       mkdir -p $C
       if check_prereq; then
           if check_whitelist system; then
               exit 127
           fi
       fi
       check_blacklist system
       preserve_addon_d
       run_stage pre-backup
       run_stage backup
       run_stage post-backup
    ;;
    restore)
       if check_prereq; then
          if check_whitelist tmp; then
             exit 127
          fi
       fi
       check_blacklist tmp
       run_stage pre-restore
       run_stage restore
       run_stage post-restore
       restore_addon_d
       rm -rf $C
       rm -rf /data/data/android.pacstats
       sync
    ;;
    *)
       echo "Usage: $0 {backup|restore}"
       exit 1
esac

exit 0

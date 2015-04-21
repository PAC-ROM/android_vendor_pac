#!/sbin/sh
#
# 50-backup-script.sh: Backup /system/etc/hosts whch upgrading ROM.
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
# This script generally will be at /system/addon.d/50-backup-script.sh
# During a ROM upgrade, this script backs up /system/etc/hosts.
# /system is formatted and reinstalled, then the file is restored.
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
etc/hosts
EOF
}

case "$1" in
    backup)
        list_files | while read FILE DUMMY; do
            backup_file "$S"/"$FILE"
        done
    ;;
    restore)
        list_files | while read FILE REPLACEMENT; do
            R=""
            [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
            [ -f "$C/$S/$FILE" ] && restore_file "$S"/"$FILE" "$R"
        done
    ;;
    pre-backup)
        # Stub
    ;;
    post-backup)
        # Stub
    ;;
    pre-restore)
        # Stub
    ;;
    post-restore)
        # Stub
    ;;
esac

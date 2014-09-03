#!/sbin/sh
#
# Backup and restore addon /system files
#

export C=/tmp/backupdir
export S=/system
export V=4.4
export cfg_file="/data/local/init.d.cfg"

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
if ( ! grep -q "^ro.pac.version=$V.*" /system/build.prop ); then
  echo "Not backing up files from incompatible version: $V"
  return 0
fi
return 1
}

check_blacklist() {
  if [ -f /system/addon.d/blacklist ];then
      ## Discard any known bad backup scripts
      cd /$1/addon.d/
      for f in *sh; do
          s=$(md5sum $f | awk {'print $1'})
          grep -q $s /system/addon.d/blacklist && rm -f $f
      done
  fi
}

check_whitelist() {
  found=0
  if [ -f /system/addon.d/whitelist ];then
      ## forcefully keep any version-independent stuff
      cd /$1/addon.d/
      for f in *sh; do
          s=$(md5sum $f | awk {'print $1'})
          grep -q $s /system/addon.d/whitelist
          if [ $? -eq 0 ]; then
              found=1
          else
              rm -f $f
          fi
      done
  fi
  return $found
}

# Backup Xposed Framework (bin/app_process)
xposed_backup() {
    if [ -f /system/bin/app_process.orig ]; then
        cp /system/bin/app_process /tmp/backup/
    fi;
}

# Restore Xposed Framework (bin/app_process)
xposed_restore() {
    if [ -f /tmp/backup/app_process ]; then
        mv /system/bin/app_process /system/bin/app_process.orig
        cp /tmp/backup/app_process /system/bin/
    fi;
}

# Fix Permission of cfg_file
fix_init() {
    if [ -e $cfg_file ]; then
        chmod 644 $cfg_file
    fi;
}

# Execute /system/addon.d/*.sh scripts with $1 parameter
run_stage() {
for script in $(find /tmp/addon.d/ -name '*.sh' |sort -n); do
    $script $1
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
    xposed_backup
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
    xposed_restore
    fix_init
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

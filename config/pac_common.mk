# now use pac sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=PAC-Ringtone.ogg \
    ro.config.notification_sound=PAC-Notifications.ogg \
    ro.config.alarm_alert=PAC-Alarm.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bin/50-backup-script.sh:system/addon.d/50-backup-script.sh \
    vendor/pac/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pac/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh

# Chromium Prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

# Screen recorder
PRODUCT_PACKAGES += \
    libscreenrecorder \
    ScreenRecorder

# init.d support
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/pac/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/pac/prebuilt/common/etc/init.d.cfg:data/local/init.d.cfg \
    vendor/pac/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check \
    vendor/pac/prebuilt/common/etc/init.d/01zipalign:system/etc/init.d/01zipalign \
    vendor/pac/prebuilt/common/etc/init.d/02sysctl:system/etc/init.d/02sysctl \
    vendor/pac/prebuilt/common/etc/init.d/03setrenice:system/etc/init.d/03setrenice \
    vendor/pac/prebuilt/common/etc/init.d/04filesystem:system/etc/init.d/04filesystem \
    vendor/pac/prebuilt/common/etc/init.d/05freemem:system/etc/init.d/05freemem \
    vendor/pac/prebuilt/common/etc/init.d/06removecache:system/etc/init.d/06removecache \
    vendor/pac/prebuilt/common/etc/init.d/07fixperms:system/etc/init.d/07fixperms \
    vendor/pac/prebuilt/common/etc/init.d/08tweaks:system/etc/init.d/08tweaks \
    vendor/pac/prebuilt/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/pac/prebuilt/common/etc/init.d/10sdboost:system/etc/init.d/10sdboost \
    vendor/pac/prebuilt/common/etc/init.d/11battery:system/etc/init.d/11battery \
    vendor/pac/prebuilt/common/etc/init.d/12touch:system/etc/init.d/12touch \
    vendor/pac/prebuilt/common/etc/init.d/13minfree:system/etc/init.d/13minfree \
    vendor/pac/prebuilt/common/etc/init.d/14gpurender:system/etc/init.d/14gpurender \
    vendor/pac/prebuilt/common/etc/init.d/15sleepers:system/etc/init.d/15sleepers \
    vendor/pac/prebuilt/common/etc/init.d/16journalism:system/etc/init.d/16journalism \
    vendor/pac/prebuilt/common/etc/init.d/17sqlite3:system/etc/init.d/17sqlite3 \
    vendor/pac/prebuilt/common/etc/init.d/18wifisleep:system/etc/init.d/18wifisleep \
    vendor/pac/prebuilt/common/etc/init.d/19iostats:system/etc/init.d/19iostats \
    vendor/pac/prebuilt/common/etc/init.d/20loopy:system/etc/init.d/20loopy \
    vendor/pac/prebuilt/common/etc/init.d/21speedy:system/etc/init.d/21speedy \
    vendor/pac/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# cron support
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/etc/cron/cron.conf:system/etc/cron/cron.conf \
    vendor/pac/prebuilt/common/etc/cron/cron.daily/00drop_caches:system/etc/cron/cron.daily/00drop_caches \
    vendor/pac/prebuilt/common/etc/cron/cron.daily/01clear_cache:system/etc/cron/cron.daily/01clear_cache \
    vendor/pac/prebuilt/common/etc/cron/cron.hourly/00drop_caches:system/etc/cron/cron.hourly/00drop_caches \
    vendor/pac/prebuilt/common/etc/cron/cron.hourly/01clear_cache:system/etc/cron/cron.hourly/01clear_cache \
    vendor/pac/prebuilt/common/etc/cron/cron.weekly/00drop_caches:system/etc/cron/cron.weekly/00drop_caches \
    vendor/pac/prebuilt/common/etc/cron/cron.weekly/01clear_cache:system/etc/cron/cron.weekly/01clear_cache

# Pac Sounds
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/media/audio/alarms/PAC-Alarm.ogg:system/media/audio/alarms/PAC-Alarm.ogg \
    vendor/pac/prebuilt/common/media/audio/notifications/PAC-Notifications.ogg:system/media/audio/notifications/PAC-Notifications.ogg \
    vendor/pac/prebuilt/common/media/audio/ringtones/PAC-Ringtone.ogg:system/media/audio/ringtones/PAC-Ringtone.ogg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/xbin/zip:system/xbin/zip \
    vendor/pac/prebuilt/common/xbin/zipalign:system/xbin/zipalign

# OmniRom Packages
PRODUCT_PACKAGES += \
    OmniSwitch \

# PAC Packages
PRODUCT_PACKAGES += \
    HALO \
    InsertCoins \
    PacConsole \
    PacPapers \
    PACPerformance

# PAC Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/common

BOARD := $(subst pac_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# PAC version
PAC_VERSION_MAJOR = 4
PAC_VERSION_MINOR = 4.4
PAC_VERSION_MAINTENANCE := $(shell if [ -s ~/PACname ]; then cat ~/PACname; else echo "RC-2"; fi)
PAC_VERSION := $(PAC_VERSION_MAJOR).$(PAC_VERSION_MINOR).$(PAC_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.pac.version=$(PAC_VERSION) \
    ro.pacrom.version=pac_$(BOARD)_$(PAC_VERSION)_$(shell date +%Y%m%d-%H%M%S) \
    ro.modversion=pac_$(BOARD)_$(PAC_VERSION)_$(shell date +%Y%m%d-%H%M%S)

# ROMStats Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.pacstats.url=http://stats.pac-rom.com \
    ro.pacstats.name=PAC-man \
    ro.pacstats.version=$(PAC_VERSION) \
    ro.pacstats.tframe=1

# Disable ADB authentication and set root access to Apps and ADB
ifeq ($(DISABLE_ADB_AUTH),true)
    ADDITIONAL_DEFAULT_PROPERTIES += \
        ro.adb.secure=3 \
        persist.sys.root_access=3
endif

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
    vendor/pac/prebuilt/common/etc/init.d/80check:system/etc/init.d/80check \
    vendor/pac/prebuilt/common/etc/init.d/81sysctl:system/etc/init.d/81sysctl \
    vendor/pac/prebuilt/common/etc/init.d/81setrenice:system/etc/init.d/81setrenice \
    vendor/pac/prebuilt/common/etc/init.d/81filesystem:system/etc/init.d/81filesystem \
    vendor/pac/prebuilt/common/etc/init.d/81freemem:system/etc/init.d/81freemem \
    vendor/pac/prebuilt/common/etc/init.d/81removecache:system/etc/init.d/81removecache \
    vendor/pac/prebuilt/common/etc/init.d/81fixperms:system/etc/init.d/81fixperms \
    vendor/pac/prebuilt/common/etc/init.d/81kernel:system/etc/init.d/81kernel \
    vendor/pac/prebuilt/common/etc/init.d/81cron:system/etc/init.d/81cron \
    vendor/pac/prebuilt/common/etc/init.d/81sdboost:system/etc/init.d/81sdboost \
    vendor/pac/prebuilt/common/etc/init.d/81battery:system/etc/init.d/81battery \
    vendor/pac/prebuilt/common/etc/init.d/81touch:system/etc/init.d/81touch \
    vendor/pac/prebuilt/common/etc/init.d/81vm:system/etc/init.d/81vm \
    vendor/pac/prebuilt/common/etc/init.d/81net:system/etc/init.d/81net \
    vendor/pac/prebuilt/common/etc/init.d/81sleepers:system/etc/init.d/81sleepers \
    vendor/pac/prebuilt/common/etc/init.d/81journalism:system/etc/init.d/81journalism \
    vendor/pac/prebuilt/common/etc/init.d/81sqlite:system/etc/init.d/81sqlite \
    vendor/pac/prebuilt/common/etc/init.d/81wifisleep:system/etc/init.d/81wifisleep \
    vendor/pac/prebuilt/common/etc/init.d/81iostats:system/etc/init.d/81iostats \
    vendor/pac/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Cron
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
    vendor/pac/prebuilt/common/xbin/zip:system/xbin/zip

# OmniRom Packages
PRODUCT_PACKAGES += \
    OmniSwitch \

# PAC Packages
PRODUCT_PACKAGES += \
    HALO \
    InsertCoins \
    PACConsole \
    PACPapers \
    PACPerformance

# PAC Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/common

BOARD := $(subst pac_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# PAC version
PACVERSION := $(shell echo $(PAC_VERSION) | sed -e 's/^[ \t]*//;s/[ \t]*$$//;s/ /./g')

PRODUCT_PROPERTY_OVERRIDES += \
    ro.pacrom.version=pac_$(BOARD)_$(PACVERSION)_$(shell date +%Y%m%d-%H%M%S) \
    ro.modversion=pac_$(BOARD)_$(PACVERSION)_$(shell date +%Y%m%d-%H%M%S)

# ROMStats Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.pacstats.url=http://stats.pac-rom.com \
    ro.pacstats.name=PAC-man \
    ro.pacstats.version=$(PACVERSION) \
    ro.pacstats.tframe=1

# Disable ADB authentication and set root access to Apps and ADB
ifeq ($(DISABLE_ADB_AUTH),true)
    ADDITIONAL_DEFAULT_PROPERTIES += \
        ro.adb.secure=3 \
        persist.sys.root_access=3
endif

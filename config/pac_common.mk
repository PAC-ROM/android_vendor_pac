# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bin/50-backup-script.sh:system/addon.d/50-backup-script.sh \
    vendor/pac/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pac/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh

# Pac Sounds
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/media/audio/alarms/PAC-Alarm.ogg:system/media/audio/alarms/PAC-Alarm.ogg \
    vendor/pac/prebuilt/common/media/audio/notifications/PAC-Notifications.ogg:system/media/audio/notifications/PAC-Notifications.ogg \
    vendor/pac/prebuilt/common/media/audio/ringtones/PAC-Ringtone.ogg:system/media/audio/ringtones/PAC-Ringtone.ogg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/xbin/zip:system/xbin/zip

# PAC Packages
#PRODUCT_PACKAGES += \
#    InsertCoins \
#    PacConsole \
#    PacPapers \
#    PACPerformance

# PAC Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/common

BOARD := $(subst pac_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# PAC version
PAC_VERSION_MAJOR = LP
PAC_VERSION_MINOR = Alpha
PAC_VERSION_MAINTENANCE := $(shell if [ -s ~/PACname ]; then cat ~/PACname; else echo "0"; fi)
PAC_VERSION := $(PAC_VERSION_MAJOR).$(PAC_VERSION_MINOR).$(PAC_VERSION_MAINTENANCE)

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

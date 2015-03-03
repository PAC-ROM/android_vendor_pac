# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bin/50-backup-script.sh:system/addon.d/50-backup-script.sh \
    vendor/pac/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/pac/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh

# Pac Sounds
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/media/audio/alarms/PAC-Alarm.ogg:system/media/audio/alarms/PAC-Alarm.ogg \
    vendor/pac/prebuilt/common/media/audio/notifications/PAC-Notifications.ogg:system/media/audio/notifications/PAC-Notifications.ogg \
    vendor/pac/prebuilt/common/media/audio/ringtones/PAC-Ringtone.ogg:system/media/audio/ringtones/PAC-Ringtone.ogg

# Bootanimation
PRODUCT_COPY_FILES += vendor/pac/prebuilt/common/media/bootanimation/$(PAC_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip

# PAC Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/common

# PAC version
PACVERSION := $(shell echo $(PAC_VERSION) | sed -e 's/^[ \t]*//;s/[ \t]*$$//;s/ /./g')
BOARD := $(subst pac_,,$(TARGET_PRODUCT))
PAC_BUILD_VERSION := pac_$(BOARD)_$(PACVERSION)_$(shell date +%Y%m%d-%H%M%S)
PRODUCT_NAME := $(TARGET_PRODUCT)

# Set the board version
CM_BUILD := $(BOARD)

# Lower RAM devices
ifeq ($(PAC_LOW_RAM_DEVICE),true)
MALLOC_IMPL := dlmalloc
TARGET_BOOTANIMATION_TEXTURE_CACHE := false

PRODUCT_PROPERTY_OVERRIDES += \
    config.disable_atlas=true \
    dalvik.vm.jit.codecachesize=0 \
    persist.sys.force_highendgfx=true \
    ro.config.low_ram=true \
    ro.config.max_starting_bg=8 \
    ro.sys.fw.bg_apps_limit=16
endif

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

# Add and Remove
ifeq ($(PAC_USE_ADDREMOVE),true)
    GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
    GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))
endif

# Chromium Prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

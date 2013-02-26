# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Copy specific ROM files
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/supersu/app/SuperSU.apk:system/app/SuperSU.apk \
    vendor/pac/prebuilt/supersu/bin/.ext/.su:system/bin/.ext/.su \
    vendor/pac/prebuilt/supersu/xbin/su:system/xbin/su

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pa/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pa/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# T-Mobile theme engine
include vendor/pa/config/themes_common.mk

# PAC Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/common

### AOKP ###
# AOKP Packages
PRODUCT_PACKAGES += \
    PerformanceControl \
    ROMControl

# AOKP Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

### PARANOID ###
# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

# ParanoidAndroid Proprietary
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk \
    vendor/pac/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/pac/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

BOARD := $(subst pac_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# Add PA release version
PA_VERSION_MAJOR = 3
PA_VERSION_MINOR = 0
PA_VERSION_MAINTENANCE = 0
PA_PREF_REVISION = 1
VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := pa_$(BOARD)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)

# PAC version
PAC_VERSION_MAJOR = 20
PAC_VERSION_MINOR = 0
PAC_VERSION_MAINTENANCE = 0
PAC_VERSION := $(PAC_VERSION_MAJOR).$(PAC_VERSION_MINOR).$(PAC_VERSION_MAINTENANCE)

TARGET_CUSTOM_RELEASETOOL := vendor/pac/tools/squisher

PRODUCT_PROPERTY_OVERRIDES += \
    ro.pac.version=$(PAC_VERSION) \
    ro.pacrom.version=$(BOARD)_PAC_JB_4.2.2-v$(PAC_VERSION)_$(shell date +%0d%^b%Y-%H%M%S) \
    ro.modversion=$(PA_VERSION) \
    ro.pa.family=$(PA_CONF_SOURCE) \
    ro.pa.version=$(VERSION) \
    ro.papref.revision=$(PA_PREF_REVISION) \
    ro.aokp.version=$(BOARD)_jb-mr1_build-1

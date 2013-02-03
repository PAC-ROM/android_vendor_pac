# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Replace CM files
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/apk/SuperSU.apk:system/app/SuperSU.apk \
    vendor/pac/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk \
    vendor/pa/prebuilt/common/xbin/su:system/xbin/su

### AOKP ###
# AOKP Packages
PRODUCT_PACKAGES += \
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
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

BOARD := $(subst pac_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

PA_VERSION_MAJOR = 2
PA_VERSION_MINOR = 5
PA_VERSION_MAINTENANCE = 5

TARGET_CUSTOM_RELEASETOOL := vendor/pac/tools/squisher

VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := pa_$(BOARD)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)

PAC_VERSION_MAJOR = 19
PAC_VERSION_MINOR = 3
PAC_VERSION_MAINTENANCE = 0
PAC_VERSION := $(PAC_VERSION_MAJOR).$(PAC_VERSION_MINOR).$(PAC_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.pac.version=$(PAC_VERSION) \
    ro.pacrom.version=$(BOARD)_PAC_JB_4.1.2-v$(PAC_VERSION) \
    ro.modversion=$(PA_VERSION) \
    ro.pa.family=$(PA_CONF_SOURCE) \
    ro.pa.version=$(VERSION) \
    ro.aokp.version=$(BOARD)_jb-Milestone-1

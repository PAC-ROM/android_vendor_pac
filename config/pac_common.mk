# Vendor hack
#   $1 = vendor name
#   $2 = product name
define vendor-replace
  $(shell mkdir -p vendor/$(1); \
          rm -rf vendor/$(1)/$(2); \
          ln -sf ../$(1)-extra/$(2) vendor/$(1)/$(2))
endef

# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Copy specific ROM files
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/apk/PacConsole.apk:system/app/PacConsole.apk

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pac/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pac/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# Using Custom ReleaseRool
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := vendor/pac/overlay/build/tools/releasetools/ota_from_target_files

# T-Mobile theme engine
include vendor/pac/config/themes_common.mk

# init.d support
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check \
    vendor/pac/prebuilt/common/etc/init.d/01zipalign:system/etc/init.d/01zipalign \
    vendor/pac/prebuilt/common/etc/init.d/02sysctl:system/etc/init.d/02sysctl \
    vendor/pac/prebuilt/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    vendor/pac/prebuilt/common/etc/init.d/05freemem:system/etc/init.d/05freemem \
    vendor/pac/prebuilt/common/etc/init.d/06removecache:system/etc/init.d/06removecache \
    vendor/pac/prebuilt/common/etc/init.d/07fixperms:system/etc/init.d/07fixperms \
    vendor/pac/prebuilt/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/pac/prebuilt/common/etc/init.d/10sdboost:system/etc/init.d/10sdboost \
    vendor/pac/prebuilt/common/etc/init.d/98tweaks:system/etc/init.d/98tweaks \
    vendor/pac/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/pac/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf \
    vendor/pac/prebuilt/common/etc/init.d.cfg:system/etc/init.d.cfg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/xbin/zip:system/xbin/zip \
    vendor/pac/prebuilt/common/xbin/zipalign:system/xbin/zipalign

# PAC Packages
PRODUCT_PACKAGES += \
    GooglePacman \
    PacPapers \
    PacStats

# PAC Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/common

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/pac/CHANGELOG.mkdn:system/etc/PAC-CHANGELOG.txt \
    vendor/pac/CONTRIBUTORS.mkdn:system/etc/PAC-CONTRIBUTORS.txt

# AOKP Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

### PARANOID ###
# PARANOID Packages
PRODUCT_PACKAGES += \
    HALO

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

# ParanoidAndroid Images
PA_IMAGE_FILES := $(wildcard vendor/pa/prebuilt/preferences/images/*.png)
PRODUCT_COPY_FILES += \
    $(foreach f,$(PA_IMAGE_FILES),$(f):system/etc/paranoid/preferences/images/$(notdir $(f)))

# ParanoidAndroid Preferences
PA_PREF_FILES := $(wildcard vendor/pac/prebuilt/pa/preferences/$(PA_CONF_SOURCE)/*.xml)
PRODUCT_COPY_FILES += \
    $(foreach f,$(PA_PREF_FILES),$(f):system/etc/paranoid/preferences/$(notdir $(f)))

BOARD := $(subst pac_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# Add PA release version
PA_VERSION_MAJOR = 3
PA_VERSION_MINOR = 9
PA_VERSION_MAINTENANCE = 9-RC2
PA_PREF_REVISION = 1
VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := pa_$(BOARD)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)

# PAC version
PAC_VERSION_MAJOR = 4
PAC_VERSION_MINOR = 3
PAC_VERSION_MAINTENANCE = Build-1
PAC_VERSION := $(PAC_VERSION_MAJOR).$(PAC_VERSION_MINOR).$(PAC_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.pac.version=$(PAC_VERSION) \
    ro.pacrom.version=pac_$(BOARD)_$(PAC_VERSION)_$(shell date +%Y%m%d-%H%M%S) \
    ro.modversion=$(PA_VERSION) \
    ro.pa.family=$(PA_CONF_SOURCE) \
    ro.pa.version=$(VERSION) \
    ro.papref.revision=$(PA_PREF_REVISION) \
    ro.aokp.version=$(BOARD)_jb-mr2

# ROMStats Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.pacstats.url=http://stats.pac-rom.com \
    ro.pacstats.name=PAC-man \
    ro.pacstats.version=$(PAC_VERSION) \
    ro.pacstats.tframe=1

# Disable ADB authentication and set root access to Apps and ADB
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    persist.sys.root_access=3

#
# pac_common.mk: set up our common configuration
# Copyright (C) 2015-2016 The PAC-ROM Project
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

# Bootanimation
PRODUCT_COPY_FILES += vendor/pac/prebuilt/common/media/bootanimation/centre-900-60fps.zip:system/media/bootanimation.zip

# Additonal Packages
PRODUCT_PACKAGES += \
    PACConsole \
    PACSetupWizard

# PAC Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/pac/overlay/common

# PAC version
PACVERSION := $(shell echo $(PAC_VERSION) | sed -e 's/^[ \t]*//;s/[ \t]*$$//;s/ /./g')
BOARD := $(subst pac_,,$(TARGET_PRODUCT))
PAC_BUILD_VERSION := pac_$(BOARD)_$(PACVERSION)_$(shell date +%Y%m%d-%H%M%S)
PRODUCT_NAME := $(TARGET_PRODUCT)

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

# Use pac sounds by default
ifeq ($(USE_PAC_SOUNDS),true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=PAC-Ringtone.ogg \
    ro.config.notification_sound=PAC-Notifications.ogg \
    ro.config.alarm_alert=PAC-Alarm.ogg
endif

# ROMStats Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.pacstats.url=http://www.pac-rom.com/pages/submit.php \
    ro.pacstats.name=PAC-ROM \
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

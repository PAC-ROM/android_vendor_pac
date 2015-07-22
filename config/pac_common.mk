#
# pac_common.mk: set up our common configuration
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

# Kernel Adiutor
PRODUCT_COPY_FILES += vendor/pac/prebuilt/common/app/KernelAdiutor/KernelAdiutor.apk:system/app/KernelAdiutor/KernelAdiutor.apk

# Additonal Packages
PRODUCT_PACKAGES += \
    OmniSwitch \
    PACSetupWizard

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
    ro.pacstats.url=http://www.pac-rom.com/pages/submit.php \
    ro.pacstats.name=PAC-man \
    ro.pacstats.version=$(PACVERSION) \
    ro.pacstats.tframe=1

# TWRP Recovery
ifeq ($(RECOVERY_VARIANT),twrp)
    ifeq ($(PAC_MAKE),recoveryimage)
        BOARD_SEPOLICY_IGNORE += external/sepolicy/domain.te
        BOARD_SEPOLICY_DIRS += vendor/pac/sepolicy/twrp
        BOARD_SEPOLICY_UNION += domain.te init.te recovery.te
    endif
endif

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

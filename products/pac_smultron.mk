# Check for target product
ifeq (pac_smultron,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_mdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/smultron

# PAC device overlay
$(shell cp -f vendor/pac/overlay/pac/sony/mdpi/frameworks/base/core/res/assets/images/android-logo-mask.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/sony-pac_320x480.rle:root/logo.rle

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/smultron/cm.mk)

PRODUCT_NAME := pac_smultron

GET_VENDOR_PROPS := $(shell vendor/pac/tools/getvendorprops.py $(PRODUCT_NAME))

endif


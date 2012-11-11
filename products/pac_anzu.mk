# Check for target product
ifeq (pac_zeusc,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/zeusc

# PAC device overlay
$(shell cp -f vendor/pac/overlay/pac/sony/hdpi/frameworks/base/core/res/assets/images/android-logo-mask.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# PA settings overlay
$(shell cp -f vendor/pac/prebuilt/pa_hdpi.conf vendor/pa/prebuilt/pa_hdpi.conf)

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/sony-pac_480x854.rle:root/logo.rle

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/zeusc/cm.mk)

PRODUCT_NAME := pac_zeusc

GET_VENDOR_PROPS := $(shell vendor/pac/tools/getvendorprops.py $(PRODUCT_NAME))

endif


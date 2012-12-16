# Check for target product
ifeq (pac_jewel,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/galaxys2

# PAC device overlay
$(shell cp -f vendor/pac/overlay/pac/htc/xhdpi/frameworks/base/core/res/assets/images/android-logo-mask.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/jewel/cm.mk)

PRODUCT_NAME := pac_jewel

endif

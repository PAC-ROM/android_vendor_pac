# Check for target product
ifeq (pac_skyrocket,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/skyrocket

# PAC device overlay
$(shell cp -f vendor/pac/overlay/pac/samsung/hdpi/frameworks/base/core/res/assets/images/android-logo-mask.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/skyrocket/cm.mk)

PRODUCT_NAME := pac_skyrocket


endif

# Check for target product
ifeq (pac_m7vzw,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xxhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

# PAC device overlay
#$(shell cp -f vendor/pac/prebuilt/common/bootanimation_framework/android-logo-mask_htc-xhdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# Add bluefa1con bootanim
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/xxhdpi/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/m7vzw/cm.mk)

PRODUCT_NAME := pac_m7vzw

endif

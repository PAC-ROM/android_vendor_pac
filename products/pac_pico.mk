# Check for target product
ifeq (pac_pico,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_mdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/mdpi
#$(shell cp -f vendor/pac/prebuilt/common/bootanimation_framework/android-logo-mask_htc-mdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_320x480.rle:root/PICO.rle
	
# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/mdpi/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/pico/cm.mk)

PRODUCT_NAME := pac_pico

endif

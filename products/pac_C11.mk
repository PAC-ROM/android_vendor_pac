# Check for target product
ifeq (pac_C11,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_C11

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_540x960.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/540x960/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/acer/C11/cm.mk)

PRODUCT_NAME := pac_C11

endif

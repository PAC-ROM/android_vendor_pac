# Check for target product
ifeq (pac_bacon,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xxhdpi

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/1080x1920/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/pac/overlay/pac/device/bacon

# Inherit CM device configuration
$(call inherit-product, device/oneplus/bacon/cm.mk)

PRODUCT_NAME := pac_bacon

endif

# Check for target product
ifeq (pac_w7,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_540x960.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
     vendor/pac/prebuilt/540x960/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/pac/overlay/device/w7 \
    vendor/pac/overlay/pac/hdpi_540x960

# Inherit CM device configuration
$(call inherit-product, device/lge/w7/cm.mk)

PRODUCT_NAME := pac_w7

endif

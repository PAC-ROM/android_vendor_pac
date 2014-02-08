# Check for target product
ifeq (pac_pollux,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_pollux

# AOKP device overlay
#PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/pollux

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/common

# PAC boot logo
#PRODUCT_COPY_FILES += \
#   vendor/pac/prebuilt/common/bootlogo/pac_logo_1080x1920.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/xxhdpi/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/pollux/cm.mk)

PRODUCT_NAME := pac_pollux

endif


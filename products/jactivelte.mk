# Check for target product
ifeq (pac_jactivelte,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_1080x1920.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/1080x1920/bootanimation.zip:system/media/bootanimation.zip

# Copy QuickBoot.apk
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/apk/QuickBoot.apk:system/app/QuickBoot.apk

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/pac/overlay/device/jactivelte

# Inherit CM device configuration
$(call inherit-product, device/samsung/jactivelte/cm.mk)

PRODUCT_NAME := pac_jactivelte

endif

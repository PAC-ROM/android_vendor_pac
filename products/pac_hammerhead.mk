# Check for target product
ifeq (pac_hammerhead,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_1080x1920.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/1080x1920/bootanimation.zip:system/media/bootanimation.zip

# Copy QuickBoot.apk
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/apk/QuickBoot.apk:system/app/QuickBoot.apk

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/hammerhead/cm.mk)

PRODUCT_NAME := pac_hammerhead

endif

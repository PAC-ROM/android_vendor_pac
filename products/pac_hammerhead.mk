# Check for target product
ifeq (pac_hammerhead,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Copy QuickBoot.apk
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/apk/QuickBoot.apk:system/app/QuickBoot.apk

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/hammerhead/cm.mk)

PRODUCT_NAME := pac_hammerhead

endif

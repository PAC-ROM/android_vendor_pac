# Check for target product
ifeq (pac_jactivelte,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

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

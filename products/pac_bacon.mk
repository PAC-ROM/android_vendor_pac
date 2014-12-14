# Check for target product
ifeq (pac_bacon,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Device Overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/pac/overlay/device/bacon

# Inherit CM device configuration
$(call inherit-product, device/oneplus/bacon/cm.mk)

PRODUCT_NAME := pac_bacon

endif

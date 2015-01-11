# Check for target product
ifeq (pac_bacon,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Device Overlays
PAC_USE_OVERLAYS := true

# Include PAC common configuration
PRODUCT_NAME := pac_bacon
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/oneplus/bacon/cm.mk)

endif

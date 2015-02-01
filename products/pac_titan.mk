# Check for target product
ifeq (pac_titan,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
PRODUCT_NAME := pac_titan
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/titan/cm.mk)

endif

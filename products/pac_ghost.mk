# Check for target product
ifeq (pac_ghost,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
PRODUCT_NAME := pac_ghost
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/ghost/cm.mk)

endif

# Check for target product
ifeq (pac_falcon,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/falcon/cm.mk)

PRODUCT_NAME := pac_falcon

endif

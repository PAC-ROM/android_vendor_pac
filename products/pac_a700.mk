# Check for target product
ifeq (pac_a700,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1200

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/acer/a700/cm.mk)

PRODUCT_NAME := pac_a700

endif

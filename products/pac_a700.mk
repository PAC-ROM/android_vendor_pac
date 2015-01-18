# Check for target product
ifeq (pac_a700,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
PRODUCT_NAME := pac_a700
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/acer/a700/cm.mk)

endif

# Check for target product
ifeq (pac_t6,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/t6/cm.mk)

PRODUCT_NAME := pac_t6

endif

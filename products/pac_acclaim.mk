# Check for target product
ifeq (pac_acclaim,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 960

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/bn/acclaim/cm.mk)

PRODUCT_NAME := pac_acclaim

endif

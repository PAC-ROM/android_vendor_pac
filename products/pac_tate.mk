# Check for target product
ifeq (pac_tate,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 800

# Include PAC common configuration
PRODUCT_NAME := pac_tate
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/tate/cm.mk)

endif

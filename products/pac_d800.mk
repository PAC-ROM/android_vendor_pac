# Check for target product
ifeq (pac_d800,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/d800/cm.mk)

PRODUCT_NAME := pac_d800

endif

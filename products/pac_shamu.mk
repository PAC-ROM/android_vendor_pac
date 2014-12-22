# Check for target product
ifeq (pac_shamu,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1920

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/moto/shamu/cm.mk)

PRODUCT_NAME := pac_shamu

endif

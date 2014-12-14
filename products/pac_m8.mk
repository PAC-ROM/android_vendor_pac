# Check for target product
ifeq (pac_m8,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/m8/cm.mk)

PRODUCT_NAME := pac_m8

endif

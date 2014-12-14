# Check for target product
ifeq (pac_d803,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/d803/cm.mk)

PRODUCT_NAME := pac_d803

endif

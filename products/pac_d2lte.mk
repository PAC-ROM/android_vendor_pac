# Check for target product
ifeq (pac_d2lte,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/d2lte/cm.mk)

PRODUCT_NAME := pac_d2lte

endif

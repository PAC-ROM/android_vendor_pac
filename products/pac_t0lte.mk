# Check for target product
ifeq (pac_t0lte,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/t0lte/cm.mk)

PRODUCT_NAME := pac_t0lte

endif

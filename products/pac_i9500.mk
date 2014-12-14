# Check for target product
ifeq (pac_i9500,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/i9500/cm.mk)

PRODUCT_NAME := pac_i9500

endif

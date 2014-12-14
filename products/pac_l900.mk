# Check for target product
ifeq (pac_l900,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/l900/cm.mk)

PRODUCT_NAME := pac_l900

endif

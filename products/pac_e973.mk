# Check for target product
ifeq (pac_e973,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/e973/cm.mk)

PRODUCT_NAME := pac_e973

endif

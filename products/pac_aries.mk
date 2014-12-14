# Check for target product
ifeq (pac_aries,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/xiaomi/aries/cm.mk)

PRODUCT_NAME := pac_aries

endif

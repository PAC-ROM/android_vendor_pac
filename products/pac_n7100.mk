# Check for target product
ifeq (pac_n7100,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/n7100/cm.mk)

PRODUCT_NAME := pac_n7100

endif

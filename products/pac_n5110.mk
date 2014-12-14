# Check for target product
ifeq (pac_n5110,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/n5110/cm.mk)

PRODUCT_NAME := pac_n5110

endif

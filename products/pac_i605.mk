# Check for target product
ifeq (pac_i605,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk


# Inherit CM device configuration
$(call inherit-product, device/samsung/i605/cm.mk)

PRODUCT_NAME := pac_i605

endif

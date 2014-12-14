# Check for target product
ifeq (pac_venturi,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 480

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/venturi/cm.mk)

PRODUCT_NAME := pac_venturi

endif

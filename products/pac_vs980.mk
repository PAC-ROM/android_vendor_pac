# Check for target product
ifeq (pac_vs980,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/vs980/cm.mk)

PRODUCT_NAME := pac_vs980

endif

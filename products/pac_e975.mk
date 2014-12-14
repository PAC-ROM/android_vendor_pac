# Check for target product
ifeq (pac_e975,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/e975/cm.mk)

PRODUCT_NAME := pac_e975

endif

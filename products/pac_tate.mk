# Check for target product
ifeq (pac_tate,$(TARGET_PRODUCT))

# PAC boot logo
PAC_BOOTANIMATION_NAME := 800

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 800

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/tate/cm.mk)

PRODUCT_NAME := pac_tate

endif

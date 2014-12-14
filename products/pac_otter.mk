# Check for target product
ifeq (pac_otter,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 600

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/otter/cm.mk)

PRODUCT_NAME := pac_otter

endif

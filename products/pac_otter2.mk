# Check for target product
ifeq (pac_otter2,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 600

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/otter2/cm.mk)

PRODUCT_NAME := pac_otter2

endif

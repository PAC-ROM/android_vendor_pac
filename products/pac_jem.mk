# Check for target product
ifeq (pac_jem,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/jem/cm.mk)

PRODUCT_NAME := pac_jem

endif

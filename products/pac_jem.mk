# Check for target product
ifeq (pac_jem,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
PRODUCT_NAME := pac_jem
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/jem/cm.mk)

endif

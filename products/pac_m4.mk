# Check for target product
ifeq (pac_m4,$(TARGET_PRODUCT))

# Add boot animimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/m4/cm.mk)

PRODUCT_NAME := pac_m4

endif

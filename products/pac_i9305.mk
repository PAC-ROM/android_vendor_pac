# Check for target product
ifeq (pac_i9305,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/i9305/cm.mk)

PRODUCT_NAME := pac_i9305

endif

# Check for target product
ifeq (pac_d2att,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
PRODUCT_NAME := pac_d2att
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/d2att/cm.mk)

endif

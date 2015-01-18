# Check for target product
ifeq (pac_r950,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
PRODUCT_NAME := pac_r950
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/r950/cm.mk)

endif

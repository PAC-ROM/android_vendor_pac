# Check for target product
ifeq (pac_a510,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 800

# Include PAC common configuration
PRODUCT_NAME := pac_a510
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/acer/a510/cm.mk)

endif

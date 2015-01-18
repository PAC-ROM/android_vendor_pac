# Check for target product
ifeq (pac_pyramid,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 540

# Include PAC common configuration
PRODUCT_NAME := pac_pyramid
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/pyramid/cm.mk)

endif

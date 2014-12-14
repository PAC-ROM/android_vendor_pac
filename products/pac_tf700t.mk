# Check for target product
ifeq (pac_tf700t,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1920

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/tf700t/cm.mk)

PRODUCT_NAME := pac_tf700t

endif

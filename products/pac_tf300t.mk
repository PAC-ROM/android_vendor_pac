# Check for target product
ifeq (pac_tf300t,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 800

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/tf300t/cm.mk)

PRODUCT_NAME := pac_tf300t

endif

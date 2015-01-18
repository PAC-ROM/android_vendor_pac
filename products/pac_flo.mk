# Check for target product
ifeq (pac_flo,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
PRODUCT_NAME := pac_flo
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/flo/cm.mk)

endif

# Check for target product
ifeq (pac_serranodsdd,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 540

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/serranodsdd/cm.mk)

PRODUCT_NAME := pac_serranodsdd

endif

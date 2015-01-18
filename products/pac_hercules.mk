# Check for target product
ifeq (pac_hercules,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Include PAC common configuration
PRODUCT_NAME := pac_hercules
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/hercules/cm.mk)

endif

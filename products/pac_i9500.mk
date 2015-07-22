# Check for target product
ifeq (pac_i9500,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/i9500/cm.mk)

endif

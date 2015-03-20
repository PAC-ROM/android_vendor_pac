# Check for target product
ifeq (pac_flounder,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1536

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/flounder/cm.mk)

endif

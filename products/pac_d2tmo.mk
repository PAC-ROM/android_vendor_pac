# Check for target product
ifeq (pac_d2tmo,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/d2tmo/cm.mk)

endif

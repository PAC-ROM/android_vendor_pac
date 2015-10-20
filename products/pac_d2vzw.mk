# Check for target product
ifeq (pac_d2vzw,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/d2vzw/cm.mk)

endif

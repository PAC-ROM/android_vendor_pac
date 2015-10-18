# Check for target product
ifeq (pac_satsuma,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 320

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/satsuma/cm.mk)

endif

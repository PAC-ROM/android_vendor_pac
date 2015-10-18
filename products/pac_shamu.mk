# Check for target product
ifeq (pac_shamu,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1440

# include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/moto/shamu/cm.mk)

endif

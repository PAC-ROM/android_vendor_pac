# Check for target product
ifeq (pac_manta,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/manta/cm.mk)

PRODUCT_NAME := pac_manta

endif

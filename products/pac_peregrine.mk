# Check for target product
ifeq (pac_peregrine,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/peregrine/cm.mk)

PRODUCT_NAME := pac_peregrine

endif

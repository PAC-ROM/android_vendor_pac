# Check for target product
ifeq (pac_spyder,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 480

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/spyder/cm.mk)

PRODUCT_NAME := pac_spyder

endif

# Check for target product
ifeq (pac_ville,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 540

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/ville/cm.mk)

PRODUCT_NAME := pac_ville

endif

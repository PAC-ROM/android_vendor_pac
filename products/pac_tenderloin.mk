# Check for target product
ifeq (pac_tenderloin,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 768

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/hp/tenderloin/cm.mk)

PRODUCT_NAME := pac_tenderloin

endif

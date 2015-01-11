# Check for target product
ifeq (pac_tenderloin,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 768

# Include PAC common configuration
PRODUCT_NAME := pac_tenderloin
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/hp/tenderloin/cm.mk)

endif

# Check for target product
ifeq (pac_tenderloin,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 768

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/hp/tenderloin/cm.mk)

endif

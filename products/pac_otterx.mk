# Check for target product
ifeq (pac_otterx,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 600

# Include PAC common configuration
PRODUCT_NAME := pac_otterx
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/otterx/cm.mk)

endif

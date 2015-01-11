# Check for target product
ifeq (pac_serrano3gxx,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 540

# Include PAC common configuration
PRODUCT_NAME := pac_serrano3gxx
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/serrano3gxx/cm.mk)

endif

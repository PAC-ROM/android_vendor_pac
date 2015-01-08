# Check for target product
ifeq (pac_serrano3gxx,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 540

# QuickBoot
PAC_USE_QUICKBOOT := true

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/serrano3gxx/cm.mk)

PRODUCT_NAME := pac_serrano3gxx

endif

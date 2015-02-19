# Check for target product
ifeq (pac_vs985,$(TARGET_PRODUCT))

PAC_BOOTANIMATION_NAME := 1080

# include PAC common configuration
PRODUCT_NAME := pac_vs985
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/vs985/cm.mk)



endif
# Check for target product
ifeq (pac_ariesve,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480
 
# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/ariesve/cm.mk)
PRODUCT_NAME := pac_ariesve
endif
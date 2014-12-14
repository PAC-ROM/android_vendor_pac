# Check for target product
ifeq (pac_find5,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1080

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/oppo/find5/cm.mk)

PRODUCT_NAME := pac_find5

endif

# Check for target product
ifeq (pac_huashan,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/huashan/cm.mk)

PRODUCT_NAME := pac_huashan
DEVICE_RESOLUTION := 720x1280

endif

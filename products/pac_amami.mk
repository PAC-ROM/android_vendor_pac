# Check for target product
ifeq (pac_amami,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/amami/cm.mk)

PRODUCT_NAME := pac_amami
DEVICE_RESOLUTION := 1280x720

endif

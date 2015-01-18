# Check for target product
ifeq (pac_taoshan,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Include PAC common configuration
PRODUCT_NAME := pac_taoshan
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/taoshan/cm.mk)

endif

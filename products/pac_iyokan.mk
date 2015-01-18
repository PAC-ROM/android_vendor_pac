# Check for target product
ifeq (pac_iyokan,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Include PAC common configuration
PRODUCT_NAME := pac_iyokan
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/iyokan/cm.mk)

endif

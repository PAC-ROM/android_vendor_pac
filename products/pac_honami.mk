# Check for target product
ifeq (pac_honami,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/honami/cm.mk)

PRODUCT_NAME := pac_honami

endif

# Check for target product
ifeq (pac_skyrocket,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Include PAC common configuration
PRODUCT_NAME := pac_skyrocket
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/skyrocket/cm.mk)

endif

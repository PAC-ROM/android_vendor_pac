# Check for target product
ifeq (pac_v500,$(TARGET_PRODUCT))

# Include PAC Device config
PRODUCT_NAME := pac_v500

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/v500/cm.mk)

endif
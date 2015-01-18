# Check for target product
ifeq (pac_ls990,$(TARGET_PRODUCT))

# Include Device Config
PRODUCT_NAME := pac_ls990

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/ls990/cm.mk)

endif

# Check for target product
ifeq (pac_e610,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 320

# Use Add-Remove
PAC_USE_ADDREMOVE := true

# Include PAC common configuration
PRODUCT_NAME := pac_e610
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/e610/cm.mk)

endif

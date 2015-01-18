# Check for target product
ifeq (pac_p700,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Use Add-Remove
PAC_USE_ADDREMOVE := true

# Include PAC common configuration
PRODUCT_NAME := pac_p700
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/p700/cm.mk)

endif

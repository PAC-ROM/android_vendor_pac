# Check for target product
ifeq (pac_p705,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Use Add-Remove
PAC_USE_ADDREMOVE := true

# Include PAC common configuration
PRODUCT_NAME := pac_p705
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/p705/cm.mk)

endif

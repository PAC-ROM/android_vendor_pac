# Check for target product
ifeq (pac_d855,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 2560

# Use Add-Remove
PAC_USE_ADDREMOVE := false

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/d855/cm.mk)

endif

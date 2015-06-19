# Check for target product
ifeq (pac_d851,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1440

# Use Add-Remove
PAC_USE_ADDREMOVE := true

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/d851/cm.mk)

endif

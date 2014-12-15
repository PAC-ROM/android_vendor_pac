# Check for target product
ifeq (pac_mango,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 320

# Use Add-Remove
PAC_USE_ADDREMOVE := true

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/mango/cm.mk)

PRODUCT_NAME := pac_mango

endif

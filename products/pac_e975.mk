# Check for target product
ifeq (pac_e975,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 768

# Use Add-Remove
PAC_USE_ADDREMOVE := true

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/e975/cm.mk)

endif

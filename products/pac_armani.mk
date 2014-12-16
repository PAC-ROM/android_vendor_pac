# Check for target product
ifeq (pac_armani,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Use Add-Remove
PAC_USE_ADDREMOVE := true

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/xiaomi/armani/cm.mk)

PRODUCT_NAME := pac_armani

endif

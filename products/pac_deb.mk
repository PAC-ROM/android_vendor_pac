# Check for target product
ifeq (pac_deb,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/deb/cm.mk)

endif

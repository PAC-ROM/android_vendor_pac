# Check for target product
ifeq (pac_serranoltexx,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 540

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/serranoltexx/cm.mk)

endif

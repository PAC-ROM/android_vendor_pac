# Check for target product
ifeq (pac_jfltecan,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/jfltecan/cm.mk)

endif

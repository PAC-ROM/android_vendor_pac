# Check for target product
ifeq (pac_umts_spyder,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/umts_spyder/cm.mk)

endif

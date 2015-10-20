# Check for target product
ifeq (pac_otus,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 540

# include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/otus/cm.mk)

endif

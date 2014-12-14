# Check for target product
ifeq (pac_moto_msm8960,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/moto_msm8960/cm.mk)

PRODUCT_NAME := pac_moto_msm8960

endif

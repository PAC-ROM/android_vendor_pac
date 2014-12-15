# Check for target product
ifeq (pac_moto_msm8960_jbbl,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/moto_msm8960_jbbl/cm.mk)

PRODUCT_NAME := pac_moto_msm8960_jbbl

endif

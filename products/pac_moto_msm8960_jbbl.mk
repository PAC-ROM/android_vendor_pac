# Check for target product
ifeq (pac_moto_msm8960_jbbl,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# Include PAC common configuration
PRODUCT_NAME := pac_moto_msm8960_jbbl
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/moto_msm8960_jbbl/cm.mk)

endif

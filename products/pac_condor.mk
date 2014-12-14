# Check for target product
ifeq (pac_condor,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_540x960.rle:root/logo.rle

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 540

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/condor/cm.mk)

PRODUCT_NAME := pac_condor

endif

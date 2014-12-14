# Check for target product
ifeq (pac_tenderloin,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_768x1024.rle:root/logo.rle

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 768

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/hp/tenderloin/cm.mk)

PRODUCT_NAME := pac_tenderloin

endif

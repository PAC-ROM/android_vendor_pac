# Check for target product
ifeq (pac_hercules,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_480x800.rle:root/logo.rle

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 480

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/hercules/cm.mk)

PRODUCT_NAME := pac_hercules

endif

# Check for target product
ifeq (pac_otter2,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_600x1024.rle:root/logo.rle

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 600

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/otter2/cm.mk)

PRODUCT_NAME := pac_otter2

endif

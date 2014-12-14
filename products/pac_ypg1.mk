# Check for target product
ifeq (pac_ypg1,$(TARGET_PRODUCT))

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/hdpi_480x800

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_480x800.rle:root/logo.rle

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 480

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/ypg1/cm.mk)

PRODUCT_NAME := pac_ypg1

endif

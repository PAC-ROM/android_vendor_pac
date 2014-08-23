# Check for target product
ifeq (pac_pyramid,$(TARGET_PRODUCT))

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/540x960/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/pyramid/cm.mk)

PRODUCT_NAME := pac_pyramid

endif

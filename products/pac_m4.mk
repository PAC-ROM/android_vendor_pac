# Check for target product
ifeq (pac_m4,$(TARGET_PRODUCT))

# Add boot animimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/720x1280/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/m4/cm.mk)

PRODUCT_NAME := pac_m4

endif

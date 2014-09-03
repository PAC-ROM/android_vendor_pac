# Check for target product
ifeq (pac_enrc2b,$(TARGET_PRODUCT))

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/720x1280/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/enrc2b/cm.mk)

PRODUCT_NAME := pac_enrc2b

endif

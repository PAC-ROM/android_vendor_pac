# Check for target product
ifeq (pac_tf300t,$(TARGET_PRODUCT))

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/800x1280/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/tf300t/cm.mk)

PRODUCT_NAME := pac_tf300t

endif

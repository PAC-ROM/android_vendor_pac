# Check for target product
ifeq (pac_acclaim,$(TARGET_PRODUCT))

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/960x540/bootanimation.zip:system/media/bootanimation.zip

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/bn/acclaim/cm.mk)

PRODUCT_NAME := pac_acclaim

endif

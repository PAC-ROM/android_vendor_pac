# Check for target product
ifeq (pac_encore,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_nav_hdpi

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/1280x800/bootanimation.zip:system/media/bootanimation.zip

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/bn/encore/cm.mk)

PRODUCT_NAME := pac_encore

endif

# Check for target product
ifeq (pac_tf300t,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_tf300t

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/mdpi

# PA device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/pa_tf300t

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/800x1280/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/tf300t/cm.mk)

PRODUCT_NAME := pac_tf300t

endif

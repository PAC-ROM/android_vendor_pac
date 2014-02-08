# Check for target product
ifeq (pac_n8013,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_n80xx

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common_tablet

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/1280x800/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/n8013/cm.mk)

PRODUCT_NAME := pac_n8013

endif

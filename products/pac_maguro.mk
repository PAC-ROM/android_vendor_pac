# Check for target product
ifeq (pac_maguro,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/tuna

# PAC device overlay
$(shell cp -f vendor/pac/prebuilt/common/bootanimation_framework/android-logo-mask_samsung-xhdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_720x1280.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/xhdpi/bootanimation.zip:system/media/bootanimation.zip

# Hardware info for Settings>About Phone>Hardware info
PRODUCT_PROPERTY_OVERRIDES += \
    ro.device.chipset=Texas Instruments OMAP 4460 \
    ro.device.gpu=PowerVR SGX540 \
    ro.device.front_cam=1.3 MP, 720p video (1280x720 @ 30fps) \
    ro.device.rear_cam=5 MP, 1080p video (1920x1080 @ 34fps) \
    ro.device.screen_res=1280x720 

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/maguro/cm.mk)

PRODUCT_NAME := pac_maguro

endif

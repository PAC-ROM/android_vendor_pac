# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# AOKP device overlay
# PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/codina-common

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_480x800.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/hdpi/8x/bootanimation.zip:system/media/bootanimation.zip

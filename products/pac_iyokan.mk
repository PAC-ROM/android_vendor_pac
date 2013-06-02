# Check for target product
ifeq (pac_iyokan,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# PA Pref Hack for HDPI & MDPI
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/iyokan

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/hdpi_480x854
$(shell cp -f vendor/pac/prebuilt/common/bootanimation_framework/android-logo-mask_sony-hdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/sony-pac_480x854.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/hdpi/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/iyokan/cm.mk)

PRODUCT_NAME := pac_iyokan

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

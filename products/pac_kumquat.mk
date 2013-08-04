# Check for target product
ifeq (pac_kumquat,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# Common device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/common/hdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# vendor hack
$(call vendor-replace,sony,kumquat)

# Inherit CM device configuration
$(call inherit-product, device/sony/kumquat/cm.mk)

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/hdpi/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_NAME := pac_kumquat

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

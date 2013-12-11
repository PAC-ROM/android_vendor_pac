# Check for target product
ifeq (pac_villec2,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

# PAC device overlay
#$(shell cp -f vendor/pac/prebuilt/common/bootanimation_framework/android-logo-mask_htc-hdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# Add bluefa1con bootanim
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/hdpi/bootanimation.zip:system/media/bootanimation.zip

# vendor hack
$(call vendor-replace,htc,villec2)

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/villec2/cm.mk)

PRODUCT_NAME := pac_villec2

# Update local_manifest.xml
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME)) 
endif

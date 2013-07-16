# Check for target product
ifeq (pac_nypon,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# Common device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/common/hdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/nypon/cm.mk)

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/hdpi/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_NAME := pac_nypon

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

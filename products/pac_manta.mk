# Check for target product
ifeq (pac_manta,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_manta

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common_tablet


# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/xhdpi/bootanimation.zip:system/media/bootanimation.zip

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/manta/cm.mk)

PRODUCT_NAME := pac_manta

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

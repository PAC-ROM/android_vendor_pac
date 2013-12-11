# Check for target product
ifeq (pac_i777,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# AOKP device overlay
# This is enabled in the i9100 product make but the overlay doesn't actually
# exist, I'm removing it unless it's determined we actually need said overlay.
#PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/galaxys2

# PAC device overlay
# This is enabled in the i9100 product make but the overlay doesn't actually
# exist, I'm removing it unless it's determined we actually need said overlay.
#PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/hdpi_480x800

#$(shell cp -f vendor/pac/prebuilt/common/bootanimation_framework/android-logo-mask_samsung-hdpi.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_480x800.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/hdpi/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/i777/cm.mk)

PRODUCT_NAME := pac_i777

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

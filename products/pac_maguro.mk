# Check for target product
ifeq (pac_urushi,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/maguro

# PAC device overlay
$(shell cp -f vendor/pac/overlay/pac/samsung/xhdpi/frameworks/base/core/res/assets/images/android-logo-mask.png frameworks/base/core/res/assets/images/android-logo-mask.png)

# include missing proprietaries
PRODUCT_COPY_FILES += \
  vendor/pa/proprietary/maguro/bcm4330.hcd:system/vendor/firmware/bcm4330.hcd

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/maguro/cm.mk)

PRODUCT_NAME := pac_maguro

GET_VENDOR_PROPS := $(shell vendor/pac/tools/getvendorprops.py $(PRODUCT_NAME))

endif


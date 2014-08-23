# Check for target product
ifeq (pac_p930,$(TARGET_PRODUCT))

PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/720x1280/bootanimation.zip:system/media/bootanimation.zip

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/p930/cm.mk)

PRODUCT_NAME := pac_p930

endif

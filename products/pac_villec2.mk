# Check for target product
ifeq (pac_villec2,$(TARGET_PRODUCT))

# Add bluefa1con bootanim
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/540x960/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/villec2/cm.mk)

PRODUCT_NAME := pac_villec2

endif

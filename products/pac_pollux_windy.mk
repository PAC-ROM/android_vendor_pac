# Check for target product
ifeq (pac_pollux_windy,$(TARGET_PRODUCT))

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/1080x1920/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/pollux_windy/cm.mk)

PRODUCT_NAME := pac_pollux_windy

endif


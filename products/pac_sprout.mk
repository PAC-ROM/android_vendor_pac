# Check for target product
ifeq (pac_sprout,$(TARGET_PRODUCT))

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/480x854/bootanimation.zip:system/media/bootanimation.zip

# Inherit some common CM stuff.
$(call inherit-product, device/google/sprout/cm.mk)

# include PAC common configuration
include vendor/pac/config/pac_common.mk

PRODUCT_NAME := pac_sprout

endif

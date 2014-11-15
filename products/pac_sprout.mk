# Check for target product
ifeq (pac_sprout,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
vendor/pac/prebuilt/common/bootlogo/pac_logo_480x854.rle:root/logo.rle

# Inherit some common CM stuff.
$(call inherit-product, device/google/sprout/cm.mk)

# include PAC common configuration
include vendor/pac/config/pac_common.mk

PRODUCT_NAME := pac_sprout

endif

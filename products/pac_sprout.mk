# Check for target product
ifeq (pac_sprout,$(TARGET_PRODUCT))

# Correct bootanimation size for the screen
TARGET_SCREEN_HEIGHT := 854
TARGET_SCREEN_WIDTH := 480

# Inherit some common CM stuff.
$(call inherit-product, device/google/sprout/cm.mk)

# include PAC common configuration
include vendor/pac/config/pac_common.mk

PRODUCT_NAME := pac_sprout

endif

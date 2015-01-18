# Check for target product
ifeq (pac_pollux_windy,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1080

# Include PAC common configuration
PRODUCT_NAME := pac_pollux_windy
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/pollux_windy/cm.mk)

endif

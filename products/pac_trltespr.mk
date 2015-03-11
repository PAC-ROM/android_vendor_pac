# Check for target product
ifeq (pac_trltespr,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1440

# include PAC common configuration
PRODUCT_NAME := pac_trltespr
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/trltespr/cm.mk)

endif

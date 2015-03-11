# Check for target product
ifeq (pac_trltetmo,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1440

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/trltetmo/cm.mk)

endif

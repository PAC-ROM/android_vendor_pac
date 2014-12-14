# Check for target product
ifeq (pac_holiday,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 540

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/holiday/cm.mk)

PRODUCT_NAME := pac_holiday
endif

# Check for target product
ifeq (pac_wx_na_wf,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1200

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/nvidia/wx_na_wf/cm.mk)

PRODUCT_NAME := pac_wx_na_wf

endif

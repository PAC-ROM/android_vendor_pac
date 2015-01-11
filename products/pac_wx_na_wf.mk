# Check for target product
ifeq (pac_wx_na_wf,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
PRODUCT_NAME := pac_wx_na_wf
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/nvidia/wx_na_wf/cm.mk)

endif

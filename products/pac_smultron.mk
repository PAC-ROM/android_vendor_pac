# Check for target product
ifeq (pac_smultron,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 320

# Include PAC common configuration
PRODUCT_NAME := pac_smultron
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/smultron/cm.mk)

endif

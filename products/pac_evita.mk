# Check for target product
ifeq (pac_evita,$(TARGET_PRODUCT))

# PAC boot logo
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/evita/cm.mk)

PRODUCT_NAME := pac_evita

endif

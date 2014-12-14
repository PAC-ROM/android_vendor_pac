# Check for target product
ifeq (pac_t0lteatt,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/t0lteatt/cm.mk)

PRODUCT_NAME := pac_t0lteatt

endif

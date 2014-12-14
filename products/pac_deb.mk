# Check for target product
ifeq (pac_deb,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 1200

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/deb/cm.mk)

PRODUCT_NAME := pac_deb

endif

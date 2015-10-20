# Check for target product
ifeq (pac_castor_windy,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 1200

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/castor_windy/cm.mk)

endif

# Check for target product
ifeq (pac_chagallwifi,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 2560

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/chagallwifi/cm.mk)

endif

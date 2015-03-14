# Check for target product
ifeq (pac_otterx,$(TARGET_PRODUCT))

# Mark as low RAM device
PAC_LOW_RAM_DEVICE := true

# Bootanimation
PAC_BOOTANIMATION_NAME := 600

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/amazon/otterx/cm.mk)

endif

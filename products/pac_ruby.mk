# Check for target product
ifeq (pac_ruby,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 540

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/ruby/cm.mk)

PRODUCT_NAME := pac_ruby

endif

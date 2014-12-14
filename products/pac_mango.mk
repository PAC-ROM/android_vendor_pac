# Check for target product
ifeq (pac_mango,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 320

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/mango/cm.mk)

PRODUCT_NAME := pac_mango

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

# Check for target product
ifeq (pac_haida,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 480

# Include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/haida/cm.mk)

PRODUCT_NAME := pac_haida

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

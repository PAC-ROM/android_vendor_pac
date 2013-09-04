# Check for target product
ifeq (pac_codinaMetroPCS,$(TARGET_PRODUCT))

# include PAC common configuration
include vendor/pac/config/pac_common.mk
include vendor/pac/products/codina-common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/codinaMetroPCS/cm.mk)

PRODUCT_NAME := pac_codinaMetroPCS

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

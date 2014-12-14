# Check for target product
ifeq (pac_ghost,$(TARGET_PRODUCT))

# Copy bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/motorola/ghost/cm.mk)

PRODUCT_NAME := pac_ghost

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

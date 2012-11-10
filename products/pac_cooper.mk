# Check for target product
ifeq (pac_cooper,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_mdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/cooper

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/samsung/mdpi

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/cooper/cm.mk)

PRODUCT_NAME := pac_cooper

GET_VENDOR_PROPS := $(shell vendor/pac/tools/getvendorprops.py $(PRODUCT_NAME))

endif

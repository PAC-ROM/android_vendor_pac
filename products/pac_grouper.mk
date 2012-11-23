# Check for target product
ifeq (pac_grouper,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_tvdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/device/grouper

# PAC device overlay
# not done yet

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/grouper/cm.mk)

PRODUCT_NAME := pac_grouper

endif

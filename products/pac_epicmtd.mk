# Check for target product
ifeq (pac_epicmtd,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/480x800/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/epicmtd/cm.mk)

PRODUCT_NAME := pac_epicmtd

endif

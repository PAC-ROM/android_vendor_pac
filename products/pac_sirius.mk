# Check for target product
ifeq (pac_sirius,$(TARGET_PRODUCT))

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/media/bootanimation/1080.zip:system/media/bootanimation.zip

# Include PAC common configuration
include vendor/pac/config/common.mk

# Inherit CM device configuration
$(call inherit-product, device/sony/sirius/pac.mk)

endif

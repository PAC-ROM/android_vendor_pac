# Check for target product
ifeq (pac_p3100,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_600x1024.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/600x1024/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/p3100/full_p3100.mk)

#Set build fingerprint / ID / Prduct Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=espressorfxx TARGET_DEVICE=espressorf BUILD_FINGERPRINT=samsung/espressorfxx/espressorf:4.0.3/IML74K/P3100XWALE2:user/release-keys PRIVATE_BUILD_DESC="espressorfxx-user 4.0.3 IML74K P3100XWALE2 release-keys"

endif

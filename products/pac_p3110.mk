# Check for target product
ifeq (pac_p3110,$(TARGET_PRODUCT))

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_600x1024.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/600x1024/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/p3110/full_p3110.mk)

#Set build fingerprint / ID / Prduct Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=espressowifixx \
    TARGET_DEVICE=espressowifi \
    BUILD_FINGERPRINT="samsung/espressowifixx/espressowifi:4.2.2/JDQ39/P3110XXDMH1:user/release-keys" \
    PRIVATE_BUILD_DESC="espressowifixx-user 4.2.2 JDQ39 P3110XXDMH1 release-keys"

endif


# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common_full.mk)

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

ifeq ($(PAC_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/pac/prebuilt/common/media/bootanimation/800.zip:system/media/bootanimation.zip
endif

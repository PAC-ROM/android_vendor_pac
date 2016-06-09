# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common.mk)

PRODUCT_SIZE := mini

# Include PAC audio files
include vendor/pac/config/pac_audio.mk

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg


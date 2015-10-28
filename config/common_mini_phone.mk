# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common.mk)

# Include PAC audio files
include vendor/pac/config/pac_audio.mk

# Required PAC packages
PRODUCT_PACKAGES += \
    LatinIME

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

$(call inherit-product, vendor/pac/config/telephony.mk)

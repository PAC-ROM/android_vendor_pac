# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common_full.mk)

# Required PAC packages
PRODUCT_PACKAGES += \
    LatinIME

# Include PAC LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/dictionaries

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

$(call inherit-product, vendor/pac/config/telephony.mk)

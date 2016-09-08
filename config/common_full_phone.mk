# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common_full.mk)

# Required PAC packages
PRODUCT_PACKAGES += \
    LatinIME

# Include PAC LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/dictionaries

$(call inherit-product, vendor/pac/config/telephony.mk)

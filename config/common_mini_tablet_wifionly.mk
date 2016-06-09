# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common_mini.mk)

# Required PAC packages
PRODUCT_PACKAGES += \
    LatinIME

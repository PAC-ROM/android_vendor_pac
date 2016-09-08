# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common.mk)

PRODUCT_SIZE := full

# Optional PAC packages
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    PhotoTable \
    PhotoPhase

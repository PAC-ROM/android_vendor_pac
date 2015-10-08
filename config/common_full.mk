# Inherit common PAC stuff
$(call inherit-product, vendor/pac/config/common.mk)

# Include PAC audio files
include vendor/pac/config/pac_audio.mk

# Optional PAC packages
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    VisualizationWallpapers \
    PhotoTable \
    SoundRecorder \
    PhotoPhase

# Extra tools in PAC
PRODUCT_PACKAGES += \
    vim \
    zip \
    unrar \
    curl

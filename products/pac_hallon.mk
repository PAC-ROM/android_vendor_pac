# Check for target product
ifeq (pac_hallon,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/hdpi_480x854

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bootlogo/pac_logo_480x854.rle:root/logo.rle

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/480x854/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/hallon/cm.mk)

PRODUCT_NAME := pac_hallon

# Additional System Prop
# hardware info
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.device.chipset=Qualcomm-Snapdragon-S2-MSM8255 \
    ro.device.cpu=1-GHz-Scorpion \
    ro.device.gpu=Qualcomm-Adreno-205 \
    ro.device.front_cam=VGA-640x480-pixels \
    ro.device.rear_cam=8.1-MP-3264x2448-pixels-autofocus-LED-flash \
    ro.device.screen_res=FWVGA-480x854-pixels

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif

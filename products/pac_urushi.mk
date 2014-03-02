# Check for target product
ifeq (pac_urushi,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# PAC device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/hdpi_480x854

# PAC boot logo
$(shell rm -rf $(PRODUCT_OUT)/recovery/root/bootlogo)
ifeq ($(BUILD_WITH_STATIC_INITLOGO),true)
    PRODUCT_COPY_FILES += \
        vendor/pac/prebuilt/common/bootlogo/pac_logo_480x854.rle:root/logo.rle
else
    PRODUCT_COPY_FILES += \
        vendor/pac/prebuilt/SE-2011/480/1.rle:root/bootlogo/1.rle \
        vendor/pac/prebuilt/SE-2011/480/2.rle:root/bootlogo/2.rle \
        vendor/pac/prebuilt/SE-2011/480/3.rle:root/bootlogo/3.rle \
        vendor/pac/prebuilt/SE-2011/480/4.rle:root/bootlogo/4.rle \
        vendor/pac/prebuilt/SE-2011/480/5.rle:root/bootlogo/5.rle \
        vendor/pac/prebuilt/SE-2011/480/6.rle:root/bootlogo/6.rle \
        vendor/pac/prebuilt/SE-2011/480/7.rle:root/bootlogo/7.rle \
        vendor/pac/prebuilt/SE-2011/480/8.rle:root/bootlogo/8.rle \
        vendor/pac/prebuilt/SE-2011/480/8.rle:root/bootlogo/9.rle \
        vendor/pac/prebuilt/SE-2011/480/7.rle:root/bootlogo/10.rle \
        vendor/pac/prebuilt/SE-2011/480/6.rle:root/bootlogo/11.rle \
        vendor/pac/prebuilt/SE-2011/480/5.rle:root/bootlogo/12.rle \
        vendor/pac/prebuilt/SE-2011/480/4.rle:root/bootlogo/13.rle \
        vendor/pac/prebuilt/SE-2011/480/3.rle:root/bootlogo/14.rle \
        vendor/pac/prebuilt/SE-2011/480/2.rle:root/bootlogo/15.rle \
        vendor/pac/prebuilt/SE-2011/480/1.rle:root/bootlogo/16.rle \
        vendor/pac/prebuilt/SE-2011/480/1.rle:root/bootlogo/17.rle \
        vendor/pac/prebuilt/SE-2011/480/2.rle:root/bootlogo/18.rle \
        vendor/pac/prebuilt/SE-2011/480/3.rle:root/bootlogo/19.rle \
        vendor/pac/prebuilt/SE-2011/480/4.rle:root/bootlogo/20.rle \
        vendor/pac/prebuilt/SE-2011/480/5.rle:root/bootlogo/21.rle \
        vendor/pac/prebuilt/SE-2011/480/6.rle:root/bootlogo/22.rle \
        vendor/pac/prebuilt/SE-2011/480/7.rle:root/bootlogo/23.rle \
        vendor/pac/prebuilt/SE-2011/480/8.rle:root/bootlogo/24.rle \
        vendor/pac/prebuilt/SE-2011/480/8.rle:root/bootlogo/25.rle \
        vendor/pac/prebuilt/SE-2011/480/7.rle:root/bootlogo/26.rle \
        vendor/pac/prebuilt/SE-2011/480/6.rle:root/bootlogo/27.rle \
        vendor/pac/prebuilt/SE-2011/480/5.rle:root/bootlogo/28.rle \
        vendor/pac/prebuilt/SE-2011/480/4.rle:root/bootlogo/29.rle \
        vendor/pac/prebuilt/SE-2011/480/3.rle:root/bootlogo/30.rle \
        vendor/pac/prebuilt/SE-2011/480/2.rle:root/bootlogo/31.rle \
        vendor/pac/prebuilt/SE-2011/480/1.rle:root/bootlogo/32.rle
endif

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/480x854/bootanimation.zip:system/media/bootanimation.zip

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/urushi/cm.mk)

PRODUCT_NAME := pac_urushi

# Additional System Prop
# hardware info
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.device.chipset=Qualcomm-Snapdragon-S2-MSM8255 \
    ro.device.cpu=1-GHz-Scorpion \
    ro.device.gpu=Qualcomm-Adreno-205 \
    ro.device.front_cam=VGA-640x480-pixels \
    ro.device.rear_cam=8.1-MP-3264x2448-pixels-autofocus-Exmor-R-sensor-LED-flash \
    ro.device.screen_res=FWVGA-480x854-pixels

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif


# Hardware information

ifeq ($(TARGET_DEVICE),evita)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.device.chipset=Qualcomm_MSM8960_Snapdragon_S4 \
        ro.device.cpu=ARMv7_Dual-Core_1.5_GHz_Krait \
        ro.device.gpu=Adreno_225 \
        ro.device.rear_cam=8MP_(3264x2448) \
        ro.device.front_cam=1.3MP_(1280x960) \
        ro.device.screen_res=4.7"_1280x720_pixels_(~312 ppi)
endif

ifeq ($(TARGET_DEVICE),jflte)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.device.chipset=Qualcomm_MSM8960_Snapdragon_600 \
        ro.device.cpu=ARMv7_Quad-Core_1.9_GHz_Krait_300 \
        ro.device.gpu=Adreno_320 \
        ro.device.rear_cam=13MP_(4128x3096) \
        ro.device.front_cam=2MP_(1600x1200) \
        ro.device.screen_res=5"_1920x1080_pixels_(~441 ppi)
endif

ifeq ($(TARGET_DEVICE),ruby)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.device.chipset=Qualcomm_MSM8660_Snapdragon_S3 \
        ro.device.cpu=ARMv7_Dual-Core_1.5_GHz_Scorpion \
        ro.device.gpu=Adreno_220 \
        ro.device.rear_cam=8MP_(3264x2448) \
        ro.device.front_cam=2MP_(1600x1200) \
        ro.device.screen_res=4.3"_960x540_pixels_(~256 ppi)
endif

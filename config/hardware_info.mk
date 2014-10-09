
# Hardware information

# You need to add the following values:
#     ro.device.chipset=value \
#     ro.device.cpu=value \
#     ro.device.gpu=value \
#     ro.device.rear_cam=value \
#     ro.device.front_cam=value \
#     ro.device.screen_res=value
#
# Remember here there can be no spaces after the equal (=) use (_)
#


# Acer
#
# Iconia A510 (a510)
# Iconia A510 (a510)


# Amazon
#
# Kindle Fire (otter)
# Kindle Fire 2 (otter2)
# Kindle Fire HD 7 (tate)
# Kindle Fire HD 8.9 (jem)

# Asus
#
# Nexus 7 (grouper)
# Nexus 7 (2013) (flo)
# Nexus 7 LTE (2013) (deb)
# Transformer Pad (tf300t)
# Transformer Pad Infinity (tf700t)

# Barnes and Noble
#
# Nook (acclaim)
# Nook HD+ (ovation)

# HP
#
# Touchpad (tenderloin)

# HTC
#
# Amaze 4G (ruby)
ifeq ($(TARGET_DEVICE),ruby)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.device.chipset=Qualcomm_MSM8660_Snapdragon_S3 \
        ro.device.cpu=ARMv7_Dual-Core_1.5_GHz_Scorpion \
        ro.device.gpu=Adreno_220 \
        ro.device.rear_cam=8MP_(3264x2448) \
        ro.device.front_cam=2MP_(1600x1200) \
        ro.device.screen_res=4.3"_960x540_pixels_(~256 ppi)
endif
# Droid DNA (dlx)
# MyTouch 4G (glacier)
# One (ATT, GSM, T-Mobile) (m7)
# One (Sprint) (m7spr)
# One (Verizon) (m7vzw)
# One 2014 (m8)
# One Max (GSM) (t6)
# One Max (Sprint) (t6spr)
# One Max (Verizon) (t6vzw)
# One Mini (m4)
# One S (ville)
# One S C2 (villec2)
# One XL (evita)
ifeq ($(TARGET_DEVICE),evita)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.device.chipset=Qualcomm_MSM8960_Snapdragon_S4 \
        ro.device.cpu=ARMv7_Dual-Core_1.5_GHz_Krait \
        ro.device.gpu=Adreno_225 \
        ro.device.rear_cam=8MP_(3264x2448) \
        ro.device.front_cam=1.3MP_(1280x960) \
        ro.device.screen_res=4.7"_1280x720_pixels_(~312 ppi)
endif
# Vivid 4G (holiday)

# Huawei
#
# Ascend G510 (u8951)
# Ascend Y300 (u8833)
# Honor (u8860)
# Ideos X5 PRO (u8800pro)

# LG
#
# G-Pad (v500)
# Nexus 4 (mako)
# Optimus 4X (p880)
# Optimus L5 (e610)
# Optimus L7 (p700)
# Optimus L7 (p705)
# Optimus G (Canadian) (e973)
# Optimus G (International) (e975)
# Optimus G (Pro) (e980)
# Optimus G (Sprint) (ls970)
# Optimus G2 (ATT) (d800)
# Optimus G2 (T-Mobile) (d801)
# Optimus G2 (GSM) (d802)
# Optimus G2 (Canadian) (d803)
# Optimus G2 (Sprint) (ls980" />
# Optimus G2 (Verizon) (vs980)
# Optimus One (p500)

# Motolora
#
# Droid Razr (GSM) (umts_spyder)
# Droid Razr (Verizon) (spyder)
# Moto G (Global GSM, Retail US) (falcon)
# Moto X (GSM, Sprint, T-Mobile, US Celular, Verizon-Developer Edition) (ghost)
# Photon Q (Sprint, GSM), Razr M (Verizon) (moto_msm8960)

# Nvidia
#
# Shield Tablet (wx_na_wf)

# OnePlus
#
# One (bacon)

# Oppo
#
# Find5 (find5)
# N1 (n1)

# Samsung
#
# Epic 4G Touch (Sprint) (d710)
# Galaxy Express (ATT) (expressatt)
# Galaxy Grand Duos (i9082)
# Galaxy Nexus (GSM) (maguro)
# Galaxy Note 2 (ATT) (t0lteatt)
# Galaxy Note 2 (GSM) (n7100)
# Galaxy Note 2 (LTE) (t0lte)
# Galaxy Note 2 (Sprint) (l900)
# Galaxy Note 2 (T-Mobile) (t0ltetmo)
# Galaxy Note 2 (US Cellular) (r950)
# Galaxy Note 2 (Verizon) (i605)
# Galaxy Note 3 (International, Sprint, T-Mobile, Verizon) (hlte)
# Galaxy Note 8.0 (GSM) (N5100)
# Galaxy Note 8.0 (Wi-Fi) (N5110)
# Galaxy Note 8.0 (LTE) (N5120)
# Galaxy Player 4.0 (ypg1)
# Galaxy Player 5.0 (venturi)
# Galaxy S II (i9100)
# Galaxy S II G (i9100G)
# Galaxy S II LTE (skyrocket)
# Galaxy S II (T-Mobile) (hercules)
# Galaxy S II Plus (s2ve)
# Galaxy S II Plus (s2vep)
# Galaxy S III (ATT, C-Spire, Cricket, Metro PCS, Sprint, T-Mobile, US Cellular, Verizon) (d2lte)
# Galaxy S III (GSM) (i9300)
# Galaxy S III (LTE) (i9305)
# Galaxy S III (T-Mobile w/ Keyboard) (apexqtmo)
# Galaxy S IV (GSM) (i9500)
# Galaxy S IV Active (GSM) (jactivelte)
# Galaxy S IV (ATT, C-Spire, Canada, Cricket, LTE, Sprint, T-Mobile, US Cellular, Verizon) (jflte)
ifeq ($(TARGET_DEVICE),jflte)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.device.chipset=Qualcomm_MSM8960_Snapdragon_600 \
        ro.device.cpu=ARMv7_Quad-Core_1.9_GHz_Krait_300 \
        ro.device.gpu=Adreno_320 \
        ro.device.rear_cam=13MP_(4128x3096) \
        ro.device.front_cam=2MP_(1600x1200) \
        ro.device.screen_res=5"_1920x1080_pixels_(~441 ppi)
endif
# Galaxy S Plus (ariesve)
# Galaxy Tab 2 10 (p5100/P5110)
# Galaxy W (i8150)
# Nexus S (crespo)

# Sony
#
# Xperia L (taoshan)
# Xperia SP (huashan)
# Xperia Tablet Z (pollux_windy)
# Xperia Tablet Z LTE (pollux)
# Xperia Z (yuga)
# Xperia Z1 (honami)
# Xperia Z1 Compact (amami)

# Sony (Legacy)
#
# Live With Walkman (coconut)
# Xperia Active (satsuma)
# Xperia Arc (anzu)
# Xperia Mini (smultron)
# Xperia Mini Pro (mango)
# Xperia Neo (hallon)
# Xperia Neo V (haida)
# Xperia Pro (iyokan)
# Xperia Ray (urushi)

# Xiaomi
#
# MI 2 (aries)

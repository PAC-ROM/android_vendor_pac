#!binbash
# Hardware Info

# You need to add the following values:
#
#     echo "ro.device.chipset=value"
#     echo "ro.device.cpu=value"
#     echo "ro.device.gpu=value"
#     echo "ro.device.rear_cam=value"
#     echo "ro.device.front_cam=value"
#     echo "ro.device.screen_res=value"
#

# Acer
# Iconia A510A511" CodeName="a510a511"
# Iconia A700A701" CodeName="a700a701"
#
# Amazon
# Kindle Fire" CodeName="otter"
# Kindle Fire 2" CodeName="otter2"
# Kindle Fire HD 7" CodeName="tate"
# Kindle Fire HD 8.9" CodeName="jem"
#
# Asus
# Nexus 7" CodeName="grouper"
# Nexus 7 (2013)" CodeName="flo"
# Nexus 7 LTE (2013)" CodeName="deb"
# Transformer Pad" CodeName="tf300t"
# Transformer Pad Infinity" CodeName="tf700t"
#
# Barnes and Noble
# Nook" CodeName="acclaim"
# Nook HD+" CodeName="ovation"
#
# HP
# Touchpad" CodeName="tenderloin"
#
# HTC
# Amaze 4G" CodeName="ruby"
if [ "$TARGET_DEVICE" == "ruby" ] ; then
    echo "ro.device.chipset=Qualcomm MSM8660 Snapdragon S3"
    echo "ro.device.cpu=ARMv7 Dual-Core 1.5 GHz Scorpion"
    echo "ro.device.gpu=Adreno 220"
    echo "ro.device.rear_cam=8 MP (3264x2448)"
    echo "ro.device.front_cam=2 MP (1600x1200)"
    echo "ro.device.screen_res=4.3' 960x540 pixels (~256 ppi)"
fi

# Droid DNA" CodeName="dlx"
# One (AT&T, GSM, T-Mobile)" CodeName="m7"
# One (Sprint)" CodeName="m7spr"
# One (Verizon)" CodeName="m7vzw"
# One (2014)" CodeName="m8"
# One Max (GSM)" CodeName="t6"
# One Max (Sprint)" CodeName="t6spr"
# One Max (Verizon)" CodeName="t6vzw"
# One Mini" CodeName="m4"
# One S" CodeName="ville"
# One XL" CodeName="evita"
if [ "$TARGET_DEVICE" == "evita" ] ; then
    echo "ro.device.chipset=Qualcomm MSM8960 Snapdragon S4"
    echo "ro.device.cpu=ARMv7 Dual-Core 1.5 GHz Krait"
    echo "ro.device.gpu=Adreno 225"
    echo "ro.device.rear_cam=8 MP (3264x2448)"
    echo "ro.device.front_cam=1.3 MP (1280x960)"
    echo "ro.device.screen_res=4.7' 1280x720 pixels (~312 ppi)"
fi

# Sensation" CodeName="pyramid"
# Vivid" CodeName="holiday"
#
# LG
# G-Pad" CodeName="v500"
# Nexus 4" CodeName="mako"
# Nexus 5" CodeName="hammerhead"
# Optimus G (Canadian)" CodeName="e973"
# Optimus G (International)" CodeName="e975"
# Optimus G (Sprint)" CodeName="ls970"
# Optimus G Pro" CodeName="e980"
# Optimus G2 (AT&T)" CodeName="d800"
# Optimus G2 (Canadian)" CodeName="d803"
# Optimus G2 (GSM)" CodeName="d802"
# Optimus G2 (T-Mobile)" CodeName="d801"
# Optimus G2 (Sprint)" CodeName="ls980"
# Optimus G2 (Verizon)" CodeName="vs980"
# Optimus L5" CodeName="e610"
# Optimus L7" CodeName="p700"
# Optimus L7" CodeName="p705"
#
# Motorola
# Droid Maxx (Verizon-Developer Edition), Moto X (GSM, Sprint, T-Mobile, US Celular, Verizon-Developer Edition)" CodeName="ghost"
# Droid Razr (GSM)" CodeName="umts_spyder"
# Droid Razr (Verizon)" CodeName="spyder"
# Droid Razr M (Verizon), Photon Q 4G LTE" CodeName="moto_msm8960"
# Moto E (Global GSM, Retail US)" CodeName="condor"
# Moto G (Global GSM, Retail US)" CodeName="falcon"
#
# Nvidia
# Shield Tablet" CodeName="wx_na_wf"
#
# OnePlus
# One" CodeName="bacon"
#
# Oppo
# Find5" CodeName="find5"
# N1" CodeName="n1"
#
# Samsung
# Galaxy Nexus (GSM)" CodeName="maguro"
# Galaxy Note 2 (AT&T)" CodeName="t0lteatt"
# Galaxy Note 2 (GSM)" CodeName="n7100"
# Galaxy Note 2 (LTE)" CodeName="t0lte"
# Galaxy Note 2 (Sprint)" CodeName="l900"
# Galaxy Note 2 (T-Mobile)" CodeName="t0ltetmo"
# Galaxy Note 2 (US Cellular)" CodeName="r950"
# Galaxy Note 2 (Verizon)" CodeName="i605"
# Galaxy Note 3 (International, Sprint, T-Mobile, Verizon)" CodeName="hlte"
# Galaxy Note 8.0 (GSM)" CodeName="N5100"
# Galaxy Note 8.0 (LTE)" CodeName="N5120"
# Galaxy Note 8.0 (Wi-Fi)" CodeName="N5110"
# Galaxy Player 4.0" CodeName="ypg1"
# Galaxy Player 5.0" CodeName="venturi"
# Galaxy S I Captivate" CodeName="captivatemtd"
# Galaxy S II" CodeName="i9100"
# Galaxy S II (AT&T)" CodeName="skyrocket"
# Galaxy S II (T-Mobile)" CodeName="hercules"
# Galaxy S II Plus" CodeName="s2ve"
# Galaxy S II Plus NFC" CodeName="s2vep"
# Galaxy S III (AT&T, C-Spire, Cricket, Metro PCS, Sprint, T-Mobile, US Cellular, Verizon)" CodeName="d2lte"
# Galaxy S III (GSM)" CodeName="i9300"
# Galaxy S III (LTE)" CodeName="i9305"
# Galaxy S IV (AT&T, C-Spire, Canadian, Cricket, LTE, Sprint, T-Mobile, US Cellular, Verizon)" CodeName="jflte"
if [ "$TARGET_DEVICE" == "jflte" ] ; then
    echo "ro.device.chipset=Qualcomm Snapdragon 600"
    echo "ro.device.cpu=ARMv7 Quad-Core 1.9 GHz Krait 300"
    echo "ro.device.gpu=Adreno 320"
    echo "ro.device.rear_cam=13 MP (4128x3096)"
    echo "ro.device.front_cam=2 MP (1280x960))"
    echo "ro.device.screen_res=5' 1920x1080 pixels (~441 ppi)"
fi

# Galaxy S IV (GSM)" CodeName="i9500"
# Galaxy S IV Active (GSM)" CodeName="jactivelte"
#
# Sony
# Xperia L" CodeName="taoshan"
# Xperia SP" CodeName="huashan"
# Xperia Tablet Z" CodeName="pollux_windy"
# Xperia Tablet Z LTE" CodeName="pollux"
# Xperia Z" CodeName="yuga"
# Xperia Z1" CodeName="honami"
# Xperia Z1 Compact" CodeName="amami"
#
# Sony Ericsson
# Live With Walkman" CodeName="coconut"
# Xperia Active" CodeName="satsuma"
# Xperia Arc" CodeName="anzu"
# Xperia Mini" CodeName="smultron"
# Xperia Mini Pro" CodeName="mango"
# Xperia Neo" CodeName="hallon"
# Xperia Neo V" CodeName="haida"
# Xperia Pro" CodeName="iyokan"
# Xperia Ray" CodeName="urushi"
#
# Xiaomi
# MI 2" CodeName="aries"
# Redmi 1S" CodeName="armani"
#

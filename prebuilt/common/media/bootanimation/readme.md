Dear Maintainers!
It's time to get to work. :P

We're updating our boot animations and how we apply them. It's really way easier!

So we all know our devices resolution, and sometimes android HDPI (mdpi, ldpi, hdpi, xhdpi, etc)
doesn't always mean a specific size and there for not a solid experience for boot animations.

With out new system you just select the screen size in accordance to this list:

     240 --> 240x400
     320 --> 320x480
     480 --> 480x800 and 480x854
     540 --> 540x960
     600 --> 600x1024
     720 --> 720x1280
     768 --> 768x1024 and 768x1280
     800 --> 800x1280
     960 --> 960x540
    1080 --> 1080x1920
    1200 --> 1200x1920
    1280 --> 1280x800
    1536 --> 1536x2048
    1600 --> 1600x2560
    1920 --> 1920x1200
    2560 --> 2560x1600

example: for 1080x1920 add

    PAC_BOOTANIMATION_NAME := 1080

in your pac_$device.mk

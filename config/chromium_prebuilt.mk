ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)

LOCAL_PATH := vendor/omni/prebuilt/Chromium

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/framework/webview/paks/am.pak:system/framework/webview/paks/am.pak \
    $(LOCAL_PATH)/framework/webview/paks/ar.pak:system/framework/webview/paks/ar.pak \
    $(LOCAL_PATH)/framework/webview/paks/bg.pak:system/framework/webview/paks/bg.pak \
    $(LOCAL_PATH)/framework/webview/paks/bn.pak:system/framework/webview/paks/bn.pak \
    $(LOCAL_PATH)/framework/webview/paks/ca.pak:system/framework/webview/paks/ca.pak \
    $(LOCAL_PATH)/framework/webview/paks/cs.pak:system/framework/webview/paks/cs.pak \
    $(LOCAL_PATH)/framework/webview/paks/da.pak:system/framework/webview/paks/da.pak \
    $(LOCAL_PATH)/framework/webview/paks/de.pak:system/framework/webview/paks/de.pak \
    $(LOCAL_PATH)/framework/webview/paks/el.pak:system/framework/webview/paks/el.pak \
    $(LOCAL_PATH)/framework/webview/paks/en-GB.pak:system/framework/webview/paks/en-GB.pak \
    $(LOCAL_PATH)/framework/webview/paks/en-US.pak:system/framework/webview/paks/en-US.pak \
    $(LOCAL_PATH)/framework/webview/paks/es.pak:system/framework/webview/paks/es.pak \
    $(LOCAL_PATH)/framework/webview/paks/es-419.pak:system/framework/webview/paks/es-419.pak \
    $(LOCAL_PATH)/framework/webview/paks/et.pak:system/framework/webview/paks/et.pak \
    $(LOCAL_PATH)/framework/webview/paks/fa.pak:system/framework/webview/paks/fa.pak \
    $(LOCAL_PATH)/framework/webview/paks/fi.pak:system/framework/webview/paks/fi.pak \
    $(LOCAL_PATH)/framework/webview/paks/fil.pak:system/framework/webview/paks/fil.pak \
    $(LOCAL_PATH)/framework/webview/paks/fr.pak:system/framework/webview/paks/fr.pak \
    $(LOCAL_PATH)/framework/webview/paks/gu.pak:system/framework/webview/paks/gu.pak \
    $(LOCAL_PATH)/framework/webview/paks/he.pak:system/framework/webview/paks/he.pak \
    $(LOCAL_PATH)/framework/webview/paks/hi.pak:system/framework/webview/paks/hi.pak \
    $(LOCAL_PATH)/framework/webview/paks/hr.pak:system/framework/webview/paks/hr.pak \
    $(LOCAL_PATH)/framework/webview/paks/hu.pak:system/framework/webview/paks/hu.pak \
    $(LOCAL_PATH)/framework/webview/paks/id.pak:system/framework/webview/paks/id.pak \
    $(LOCAL_PATH)/framework/webview/paks/it.pak:system/framework/webview/paks/it.pak \
    $(LOCAL_PATH)/framework/webview/paks/ja.pak:system/framework/webview/paks/ja.pak \
    $(LOCAL_PATH)/framework/webview/paks/kn.pak:system/framework/webview/paks/kn.pak \
    $(LOCAL_PATH)/framework/webview/paks/ko.pak:system/framework/webview/paks/ko.pak \
    $(LOCAL_PATH)/framework/webview/paks/lt.pak:system/framework/webview/paks/lt.pak \
    $(LOCAL_PATH)/framework/webview/paks/lv.pak:system/framework/webview/paks/lv.pak \
    $(LOCAL_PATH)/framework/webview/paks/ml.pak:system/framework/webview/paks/ml.pak \
    $(LOCAL_PATH)/framework/webview/paks/mr.pak:system/framework/webview/paks/mr.pak \
    $(LOCAL_PATH)/framework/webview/paks/ms.pak:system/framework/webview/paks/ms.pak \
    $(LOCAL_PATH)/framework/webview/paks/nb.pak:system/framework/webview/paks/nb.pak \
    $(LOCAL_PATH)/framework/webview/paks/nl.pak:system/framework/webview/paks/nl.pak \
    $(LOCAL_PATH)/framework/webview/paks/pl.pak:system/framework/webview/paks/pl.pak \
    $(LOCAL_PATH)/framework/webview/paks/pt-BR.pak:system/framework/webview/paks/pt-BR.pak \
    $(LOCAL_PATH)/framework/webview/paks/pt-PT.pak:system/framework/webview/paks/pt-PT.pak \
    $(LOCAL_PATH)/framework/webview/paks/ro.pak:system/framework/webview/paks/ro.pak \
    $(LOCAL_PATH)/framework/webview/paks/ru.pak:system/framework/webview/paks/ru.pak \
    $(LOCAL_PATH)/framework/webview/paks/sk.pak:system/framework/webview/paks/sk.pak \
    $(LOCAL_PATH)/framework/webview/paks/sl.pak:system/framework/webview/paks/sl.pak \
    $(LOCAL_PATH)/framework/webview/paks/sr.pak:system/framework/webview/paks/sr.pak \
    $(LOCAL_PATH)/framework/webview/paks/sv.pak:system/framework/webview/paks/sv.pak \
    $(LOCAL_PATH)/framework/webview/paks/sw.pak:system/framework/webview/paks/sw.pak \
    $(LOCAL_PATH)/framework/webview/paks/ta.pak:system/framework/webview/paks/ta.pak \
    $(LOCAL_PATH)/framework/webview/paks/te.pak:system/framework/webview/paks/te.pak \
    $(LOCAL_PATH)/framework/webview/paks/th.pak:system/framework/webview/paks/th.pak \
    $(LOCAL_PATH)/framework/webview/paks/tr.pak:system/framework/webview/paks/tr.pak \
    $(LOCAL_PATH)/framework/webview/paks/uk.pak:system/framework/webview/paks/uk.pak \
    $(LOCAL_PATH)/framework/webview/paks/vi.pak:system/framework/webview/paks/vi.pak \
    $(LOCAL_PATH)/framework/webview/paks/webviewchromium.pak:system/framework/webview/paks/webviewchromium.pak \
    $(LOCAL_PATH)/framework/webview/paks/zh-CN.pak:system/framework/webview/paks/zh-CN.pak \
    $(LOCAL_PATH)/framework/webview/paks/zh-TW.pak:system/framework/webview/paks/zh-TW.pak \
    $(LOCAL_PATH)/lib/libwebviewchromium.so:system/lib/libwebviewchromium.so

endif

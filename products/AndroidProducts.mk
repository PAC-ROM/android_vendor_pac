ifeq (pac_mango,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_mango.mk
endif
ifeq (pac_urushi,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_urushi.mk
endif
ifeq (pac_urushi,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_haida.mk
endif
ifeq (pac_jewel,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_jewel.mk
endif
ifeq (pac_gio,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_gio.mk
endif
ifeq (pac_vigor,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_vigor.mk
endif
ifeq (pac_cooper,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_cooper.mk
endif
ifeq (pac_p500,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_p500.mk
endif

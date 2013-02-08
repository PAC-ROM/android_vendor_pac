ifeq (pac_mango,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_mango.mk
endif
ifeq (pac_urushi,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_urushi.mk
endif
ifeq (pac_urushi,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pac_haida.mk
endif

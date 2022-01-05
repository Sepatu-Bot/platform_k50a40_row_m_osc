LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libexfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
	libexfat/cluster.c \
	libexfat/io.c \
	libexfat/log.c \
	libexfat/lookup.c \
	libexfat/mount.c \
	libexfat/node.c \
	libexfat/time.c \
	libexfat/utf.c \
	libexfat/utils.c
LOCAL_CFLAGS = -D_FILE_OFFSET_BITS=64
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libexfat
LOCAL_SHARED_LIBRARIES := libc

include $(BUILD_STATIC_LIBRARY)


include $(CLEAR_VARS)

LOCAL_MODULE := fsck.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := utils/fsck/main.c
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/libexfat \
	$(LOCAL_PATH)/utils/fsck
LOCAL_STATIC_LIBRARIES := libexfat libc
LOCAL_FORCE_STATIC_EXECUTABLE := true

include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)

LOCAL_MODULE := mkfs.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
	utils/mkfs/cbm.c \
	utils/mkfs/fat.c \
	utils/mkfs/main.c \
	utils/mkfs/mkexfat.c \
	utils/mkfs/rootdir.c \
	utils/mkfs/uct.c \
	utils/mkfs/uctc.c \
	utils/mkfs/vbr.c
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/libexfat \
	$(LOCAL_PATH)/utils/mkfs
LOCAL_STATIC_LIBRARIES := libexfat libc
LOCAL_FORCE_STATIC_EXECUTABLE := true

include $(BUILD_EXECUTABLE)


# FIXME: needs libfuse
ifeq ($(BOARD_USES_EXFAT_FUSE), true)
include $(CLEAR_VARS)

LOCAL_MODULE := mount.exfat-fuse
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := fuse/main.c
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libexfat
LOCAL_STATIC_LIBRARIES := libexfat libfuse libz libc
LOCAL_FORCE_STATIC_EXECUTABLE := true

include $(BUILD_EXECUTABLE)
endif

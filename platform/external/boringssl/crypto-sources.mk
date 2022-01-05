LOCAL_ADDITIONAL_DEPENDENCIES += $(LOCAL_PATH)/sources.mk
include $(LOCAL_PATH)/sources.mk

LOCAL_CFLAGS += -I$(LOCAL_PATH)/src/include -I$(LOCAL_PATH)/src/crypto -Wno-unused-parameter
# Do not add in the architecture-specific files if we don't want to build assembly
ifeq (,$(filter -DOPENSSL_NO_ASM,$(LOCAL_CFLAGS)))
LOCAL_SRC_FILES_x86 = $(filter-out $(x86_exclude_files),$(crypto_sources) $(linux_x86_sources))
LOCAL_SRC_FILES_x86_64 = $(filter-out $(x86_64_exclude_files),$(crypto_sources) $(linux_x86_64_sources))
ifdef TARGET_2ND_ARCH
ifeq (armv7-a-neon, $(TARGET_2ND_ARCH_VARIANT))
ifeq (cortex-a53,$(TARGET_2ND_CPU_VARIANT))
LOCAL_SRC_FILES_arm = $(filter-out $(arm32_exclude_files),$(crypto_sources) $(linux_arm32_sources))
LOCAL_ASFLAGS_arm += -mfpu=crypto-neon-fp-armv8 
else
LOCAL_SRC_FILES_arm = $(filter-out $(arm_exclude_files),$(crypto_sources) $(linux_arm_sources))
endif
else
LOCAL_SRC_FILES_arm = $(filter-out $(arm32_exclude_files),$(crypto_sources) $(linux_arm32_sources))
LOCAL_ASFLAGS_arm += -mfpu=crypto-neon-fp-armv8
endif
else
ifeq (armv7-a-neon, $(TARGET_ARCH_VARIANT))
ifeq (cortex-a53,$(TARGET_CPU_VARIANT))
LOCAL_SRC_FILES_arm = $(filter-out $(arm32_exclude_files),$(crypto_sources) $(linux_arm32_sources))
LOCAL_ASFLAGS_arm += -mfpu=crypto-neon-fp-armv8 
else 
ifeq (cortex-a53,$(TARGET_2ND_CPU_VARIANT))
LOCAL_SRC_FILES_arm = $(filter-out $(arm32_exclude_files),$(crypto_sources) $(linux_arm32_sources))
LOCAL_ASFLAGS_arm += -mfpu=crypto-neon-fp-armv8  
else   
LOCAL_SRC_FILES_arm = $(filter-out $(arm_exclude_files),$(crypto_sources) $(linux_arm_sources))
endif
endif
else
ifeq  (arm, $(TARGET_ARCH))
LOCAL_SRC_FILES_arm = $(filter-out $(arm32_exclude_files),$(crypto_sources) $(linux_arm32_sources))
LOCAL_ASFLAGS_arm += -mfpu=crypto-neon-fp-armv8
else
LOCAL_SRC_FILES_arm = $(filter-out $(arm_exclude_files),$(crypto_sources) $(linux_arm_sources))
endif
endif
endif
LOCAL_SRC_FILES_arm64 = $(filter-out $(arm64_exclude_files),$(crypto_sources) $(linux_aarch64_sources))

else
LOCAL_SRC_FILES += $(crypto_sources)
endif

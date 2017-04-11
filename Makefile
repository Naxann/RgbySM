# TARGET #

TARGET := 3DS
LIBRARY := 0

ifeq ($(TARGET),$(filter $(TARGET),3DS WIIU))
    ifeq ($(strip $(DEVKITPRO)),)
        $(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>devkitPro")
    endif
endif

# COMMON CONFIGURATION #

NAME := RgbySM

BUILD_DIR := build
OUTPUT_DIR := output
INCLUDE_DIRS := 
SOURCE_DIRS := source/memecrypto/source source

EXTRA_OUTPUT_FILES :=

PORTLIBS_PATH := $(DEVKITPRO)/portlibs
PORTLIBS := $(PORTLIBS_PATH)/armv6k $(PORTLIBS_PATH)/3ds
CTRULIB ?= $(DEVKITPRO)/libctru

LIBRARY_DIRS := $(PORTLIBS) $(CTRULIB)
LIBRARIES := sfil freetype png z citro3d ctru m

BUILD_FLAGS := -march=armv6k -mtune=mpcore -mfloat-abi=hard
BUILD_FLAGS_CC := -g -Wall -O2 -mword-relocations \
			-fomit-frame-pointer -ffast-math \
			$(BUILD_FLAGS) $(INCLUDE) -DARM11 -D_3DS
BUILD_FLAGS_CXX := $(BUILD_FLAGS_CC) -fno-rtti -fno-exceptions -std=gnu++11
RUN_FLAGS :=

VERSION_MAJOR := 0
VERSION_MINOR := 0
VERSION_MICRO := 1

REMOTE_IP := 192.168.1.33

# 3DS/Wii U CONFIGURATION #

ifeq ($(TARGET),$(filter $(TARGET),3DS WIIU))
    TITLE := $(NAME)
    DESCRIPTION := Import Pokemon from VC RGB to Sun / Moon / PKSM
    AUTHOR := Naxann
endif

# 3DS CONFIGURATION #

ifeq ($(TARGET),3DS)
    LIBRARY_DIRS +=
    LIBRARIES +=

    PRODUCT_CODE := CTR-HB-RYSM
    UNIQUE_ID := 0xEC117

    CATEGORY := Application
    USE_ON_SD := true

    MEMORY_TYPE := Application
    SYSTEM_MODE := 64MB
    SYSTEM_MODE_EXT := Legacy
    CPU_SPEED := 268MHz
    ENABLE_L2_CACHE := true

    ICON_FLAGS := --flags visible,ratingrequired,recordusage --cero 153 --esrb 153 --usk 153 --pegigen 153 --pegiptr 153 --pegibbfc 153 --cob 153 --grb 153 --cgsrr 153

    ROMFS_DIR := assets/romfs
    BANNER_AUDIO := assets/audio.wav
    BANNER_IMAGE := assets/banner.png
    ICON := assets/icon.png
	LOGO :=
endif

# INTERNAL #

include buildtools/make_base
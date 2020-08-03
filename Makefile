SRC_DIRS = vendor/cores/usb_midi vendor/cores/teensy vendor/Bounce2/src

MCU = atmega32u4
BOARD = TEENSY2

DEFINES  = -DTEENSYDUINO=153
DEFINES += -DARDUINO_ARCH_AVR
DEFINES += -DARDUINO=10813
DEFINES += -DARDUINO_TEENSY2
DEFINES += -DF_CPU=16000000L
DEFINES += -DUSB_MIDI
DEFINES += -DLAYOUT_US_ENGLISH

CC  = avr-gcc
CXX = avr-g++
AR  = avr-ar rcs
OBJCOPY = avr-objcopy

CXX_SRC = $(wildcard *.cpp) $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.cpp))
C_SRC   = $(wildcard *.c)   $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.c))
OBJ = $(C_SRC:.c=.o) $(CXX_SRC:.cpp=.o)

INCLUDES = $(foreach dir, $(SRC_DIRS), -I$(dir))
CPPFLAGS = $(INCLUDES) $(DEFINES)
CFLAGS = -c -Os -g -Wall -ffunction-sections -fdata-sections -MMD -mmcu=$(MCU)
CXXFLAGS = $(CFLAGS) -fno-exceptions -fpermissive -felide-constructors -std=gnu++11

default : payload.hex payload.eep

core.a : $(OBJ)
	$(AR) $@ $^

payload.elf : core.a
	$(CC) -Os -Wl,--gc-sections,--relax -mmcu=$(MCU) -o $@ $< -L. -lm

payload.eep : payload.elf
	$(OBJCOPY) -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0 $< $@

payload.hex : payload.elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

program : payload.hex
	teensy_loader_cli -mmcu=$(BOARD) -w -v $<

%.stl : %.scad
	openscad -o $@ $<

3d : hardware/teensy-2.0-holder.stl hardware/footswitch-washer.stl

clean :
	rm -f *.elf *.eep *.hex $(OBJ) $(OBJ:.o=.d) hardware/*.stl

.PHONY : clean default program 3d

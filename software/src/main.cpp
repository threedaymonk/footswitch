#include <Arduino.h>
#include <Adafruit_TinyUSB.h>
#include <MIDI.h>
#include "Button.h"

#define BUTTON_1 0
#define BUTTON_2 1
#define BUTTON_3 2
#define BUTTON_4 3
#define BOARD_LED 25

Button *buttons[4];

Adafruit_USBD_MIDI usb_midi;
MIDI_CREATE_INSTANCE(Adafruit_USBD_MIDI, usb_midi, MIDI);

void setup() {
  TinyUSBDevice.setProductDescriptor("MPC Foot Controller");
  MIDI.begin(MIDI_CHANNEL_OMNI);

  buttons[0] = new Button(BUTTON_1);
  buttons[1] = new Button(BUTTON_2);
  buttons[2] = new Button(BUTTON_3);
  buttons[3] = new Button(BUTTON_4);
}

void sendMMC(uint16_t length, uint8_t* msg) {
  static uint8_t buffer[20] = { 0xf0, 0x7f, 0x7f, 0x06 };
  memcpy(buffer + 4, msg, length);
  buffer[length + 4] = 0xf7;
  MIDI.sendSysEx(length + 5, buffer, true);
}

void loop() {
  MIDI.read();

  // REC
  if (buttons[0]->update()) {
    if (buttons[0]->wasPressed()) {
      sendMMC(1, (uint8_t*)"\x06"); // Record
    }
  }

  // PLAY START
  if (buttons[1]->update()) {
    if (buttons[1]->wasPressed()) {
      sendMMC(1, (uint8_t*)"\x01"); // Stop
      sendMMC(8, (uint8_t*)"\x44\x06\x01\x00\x00\x00\x00\x00"); // Locate zero
      sendMMC(1, (uint8_t*)"\x02"); // Play
    }
  }

  // STOP
  if (buttons[2]->update()) {
    if (buttons[2]->wasPressed()) {
      sendMMC(1, (uint8_t*)"\x01"); // Stop
    }
    if (buttons[2]->wasLongPressed()) {
      sendMMC(8, (uint8_t*)"\x44\x06\x01\x00\x00\x00\x00\x00"); // Locate zero
    }
  }

  // PLAY
  if (buttons[3]->update()) {
    if (buttons[3]->wasPressed()) {
      sendMMC(1, (uint8_t*)"\x02"); // Play
    }
  }
}

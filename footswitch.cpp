#include <Arduino.h>
#include "Button.h"

#define BUTTON_1 PIN_B0
#define BUTTON_2 PIN_B1
#define BUTTON_3 PIN_B2
#define BUTTON_4 PIN_B3
#define BOARD_LED PIN_D6

Button *buttons[4];

void setup() {
  buttons[0] = new Button(BUTTON_1);
  buttons[1] = new Button(BUTTON_2);
  buttons[2] = new Button(BUTTON_3);
  buttons[3] = new Button(BUTTON_4);

  pinMode(BOARD_LED, OUTPUT);
  digitalWrite(BOARD_LED, HIGH); delay(400);
  digitalWrite(BOARD_LED, LOW);  delay(200);
  digitalWrite(BOARD_LED, HIGH); delay(400);
  digitalWrite(BOARD_LED, LOW);
}

void sendMMC(uint16_t length, uint8_t* msg) {
  static uint8_t buffer[20] = { 0xf0, 0x7f, 0x7f, 0x06 };
  memcpy(buffer + 4, msg, length);
  buffer[length + 4] = 0xf7;
  usbMIDI.sendSysEx(length + 5, buffer, true);
}

void loop() {
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
      sendMMC(7, (uint8_t*)"\x44\x06\x01\x00\x00\x00\x00"); // Locate zero
      sendMMC(1, (uint8_t*)"\x02"); // Play
    }
  }

  // STOP
  if (buttons[2]->update()) {
    if (buttons[2]->wasPressed()) {
      sendMMC(1, (uint8_t*)"\x01"); // Stop
    }
    if (buttons[2]->wasLongPressed()) {
      sendMMC(7, (uint8_t*)"\x44\x06\x01\x00\x00\x00\x00"); // Locate zero
    }
  }

  // PLAY
  if (buttons[3]->update()) {
    if (buttons[3]->wasPressed()) {
      sendMMC(1, (uint8_t*)"\x02"); // Play
    }
  }

  while (usbMIDI.read()) {} // ignore incoming messages
}

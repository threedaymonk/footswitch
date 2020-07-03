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

void loop() {
  if (buttons[0]->update()) {
    if (buttons[0]->wasPressed()) {
      usbMIDI.sendSysEx(4, (uint8_t*)"\x7f\x7f\x06\x06", true); // Record
    }
  }

  if (buttons[1]->update()) {
    if (buttons[1]->wasPressed()) {
      usbMIDI.sendSysEx(4, (uint8_t*)"\x7f\x7f\x06\x03", true); // Deferred play
    }
  }

  if (buttons[2]->update()) {
    if (buttons[2]->wasPressed()) {
      usbMIDI.sendSysEx(4, (uint8_t*)"\x7f\x7f\x06\x01", true); // Stop
    }
    if (buttons[2]->wasLongPressed()) {
      usbMIDI.sendSysEx(11, (uint8_t*)"\x7f\x00\x06\x44\x06\x01\x00\x00\x00\x00\x00", true); // Reset
    }
  }

  if (buttons[3]->update()) {
    if (buttons[3]->wasPressed()) {
      usbMIDI.sendSysEx(4, (uint8_t*)"\x7f\x7f\x06\x02", true); // Play
    }
  }

  while (usbMIDI.read()) {} // ignore incoming messages
}
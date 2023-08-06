#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "pico/binary_info.h"
#include "Button.h"

#include "bsp/board.h"
#include "tusb.h"


const uint BUTTON_1 = 0;
const uint BUTTON_2 = 1;
const uint BUTTON_3 = 2;
const uint BUTTON_4 = 3;

const uint POLL_INTERVAL_MS = 1;

Button *buttons[4];

void poll_buttons(void);

int main() {
  board_init();
  tusb_init();

  buttons[0] = new Button(BUTTON_1);
  buttons[1] = new Button(BUTTON_2);
  buttons[2] = new Button(BUTTON_3);
  buttons[3] = new Button(BUTTON_4);

  while (1) {
    tud_task(); // tinyusb device task
    poll_buttons();
  }
}

void sendMMC(uint16_t length, uint8_t* msg) {
  static uint8_t buffer[20] = { 0xf0, 0x7f, 0x7f, 0x06 };

  memcpy(buffer + 4, msg, length);
  buffer[length + 4] = 0xf7;
  tud_midi_n_stream_write(0, 0, buffer, length + 5);
}

void poll_buttons() {
  static uint32_t last_polled_at = 0;

  if (board_millis() - last_polled_at < POLL_INTERVAL_MS) return;

  last_polled_at = board_millis();

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

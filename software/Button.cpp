#include "Button.h"

Button::Button(uint pin) {
  gpio = pin;
  gpio_set_pulls(gpio, 1, 0); // pull up
  debouncer = new Debouncer(BUTTON_PIN_0);
  pressedAt = 0;
  isActive = false;
  isLongPress = false;
}

bool Button::update() {
  bool didChange = false;
  isLongPress = false;

  debouncer->ButtonProcess(gpio_get(gpio));

  if (debouncer->ButtonPressed(BUTTON_PIN_0)) {
    pressedAt = board_millis();
    isActive = true;
    didChange = true;
  }

  if (debouncer->ButtonReleased(BUTTON_PIN_0)) {
    isActive = false;
    didChange = true;
  }

  if (isActive && (board_millis() - pressedAt) > LONG_PRESS) {
    isActive = false;
    isLongPress = true;
    didChange = true;
  }

  return didChange;
}

bool Button::wasPressed() {
  return debouncer->ButtonPressed(BUTTON_PIN_0);
}

bool Button::wasLongPressed() {
  return isLongPress;
}

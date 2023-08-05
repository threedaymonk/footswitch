#include "Button.h"

Button::Button(int pin) {
  pinMode(pin, INPUT_PULLUP);
  debouncer = new Bounce(pin, DEBOUNCE_DELAY);
  pressedAt = 0;
  isActive = false;
  isLongPress = false;
}

bool Button::update() {
  bool didChange;
  isLongPress = false;
  didChange = debouncer->update();
  if (debouncer->fell()) {
    pressedAt = millis();
    isActive = true;
  }
  if (debouncer->rose()) {
    isActive = false;
  }
  if (isActive && (millis() - pressedAt) > LONG_PRESS) {
    isActive = false;
    isLongPress = true;
    didChange = true;
  }
  return didChange;
}

bool Button::wasPressed() {
  return debouncer->fell();
}

bool Button::wasLongPressed() {
  return isLongPress;
}
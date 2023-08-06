#include "button_debounce.h"
#include "hardware/gpio.h"
#include "bsp/board.h"

#ifndef Button_h
#define Button_h

class Button {
public:
  Button(uint pin);
  bool update();
  bool wasPressed();
  bool wasLongPressed();

private:
  Debouncer *debouncer;
  long pressedAt;
  bool isActive;
  bool isLongPress;
  uint gpio;
  const uint LONG_PRESS = 250;
};

#endif

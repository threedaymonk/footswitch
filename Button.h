#include <Arduino.h>
#include <Bounce2.h>

#ifndef Button_h
#define Button_h

#define DEBOUNCE_DELAY 10
#define LONG_PRESS 250

class Button {
public:
  Button(int pin);
  bool update();
  bool wasPressed();
  bool wasLongPressed();

private:
  Bounce *debouncer;
  long pressedAt;
  bool isActive;
  bool isLongPress;
};

#endif
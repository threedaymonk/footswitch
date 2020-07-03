# MIDI footswitch

This implements a USB MIDI footswitch on a Teensy 2.0. It is configured to
control an AKAI MPC X/Live/Live II/One/Touch.

## Features

- Presses are debounced
- Each button can be configured to send an additional command when held down.
  For example, the stop button will send the reset command when held for longer
  than 1/4 second.

## Prerequisites

- avr-gcc
- [teensy_loader_cli](https://github.com/PaulStoffregen/teensy_loader_cli)

## Build

To build the code

    make

To program the device

    make program

## Physical design

Four footswitches share a common connection to ground (pin 0). The other
terminal of each is connected to pins 0-3 respectively. The code can be adjusted
for more or fewer switches.

## Customisation

The USB MIDI device ID can be set by redefining `STR_PRODUCT` in the Makefile.
Run `make clean` followed by `make` after changing this.
# MIDI footswitch

This implements a USB MIDI footswitch on a Teensy 2.0. It is configured to
control an AKAI MPC X/Live/Live II/One/Touch.

For pictures and details, see the [corresponding blog
post](https://po-ru.com/2020/08/03/diy-usb-midi-footswitch).

## Features

- Presses are debounced
- Each button can be configured to send an additional command when held down.
  For example, the stop button will send the reset command when held for longer
  than 1/4 second.

## Software

### Compiling and uploading with Make

#### Prerequisites

- avr-gcc
- [teensy_loader_cli](https://github.com/PaulStoffregen/teensy_loader_cli)
- OpenSCAD (if 3D printing the hardware)

#### Build

To build the code

    make

To program the device

    make program

### Compiling and uploading with the Arduino IDE

#### Prerequisites

- [Arduino IDE](https://www.arduino.cc/en/software)
- [Teensyduino](https://www.pjrc.com/teensy/td_download.html)

#### Build

Open `footswitch.ino`. Don't worry that it's empty: the Arduino IDE just
compiles everything.

Set the board type to "Teensy 2.0" and the USB type to MIDI.

Attach the Teensy via USB and click the upload button.

## Hardware

Four footswitches share a common connection to ground (pin 1). The other
terminal of each is connected to B0-B3 (pins 2-5) respectively. The code can be adjusted
for more or fewer switches.

### BOM

- Hammond 1590XX enclosure
- 4 momentary push-to make footswitches
- Teensy 2.0
- Panel-mount USB B socket to USB A socket
- Short USB A to micro USB cable

You'll also need wire, and if you use the 3D-printed bracket below, sticky
fixers and a thin cable tie. If you're not using the bracket, you'll have to
figure out your own method of mounting the Teensy.

It's possible to skip the micro USB cable and solder the USB connection
directly to the Teensy.

### Switch connections

<img src="./hardware/footswitch.svg" alt="Switch wiring schematic" width=500>

### 3D-printed components

OpenSCAD models for washers and a bracket to hold the microcontroller are
included in the `hardware` directory. To build the STL files:

    make 3d

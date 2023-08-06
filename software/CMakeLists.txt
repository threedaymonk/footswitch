cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(test_project C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()

add_executable(mpc-footswitch
  main.cpp
  Button.cpp
  button_debounce.cpp
  usb_descriptors.c
)

pico_enable_stdio_usb(mpc-footswitch 0)
pico_enable_stdio_uart(mpc-footswitch 1)

target_include_directories(mpc-footswitch PRIVATE ${CMAKE_CURRENT_LIST_DIR})

pico_add_extra_outputs(mpc-footswitch)
target_link_libraries(mpc-footswitch PRIVATE
  pico_stdlib
  pico_unique_id
  tinyusb_device
  tinyusb_board
)

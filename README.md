# STM32F4/7 Base Project

This base project is designed to provide a quick and platform independent method of building projects for STMicro STM32F4 and STM32F7 family processors.  
Based on [ryankurte/efm32-base](https://github.com/ryankurte/efm32-base).

[![Build Status](https://travis-ci.org/ryankurte/stm32f4-base.svg)](https://travis-ci.org/ryankurte/stm32f4-base)

## Motivation
 - Getting started with Microcontrollers is hard (and time consuming)
 - Vendor IDEs are ultimately useless when approaching testing and build-automation

This project addresses this by providing a common base for for projects using STM32F4/7 processors.  
You may also wish to look at [stm32plus](https://github.com/andysworkshop/stm32plus), [platformio](platformio.org) or [Arm Yotta](yotta.mbed.com).

## Dependencies
 - cmake
 - make
 - [arm-none-eabi-gcc](https://launchpad.net/gcc-arm-embedded/+download) - Embedded ARM Compiler/Toolchain 
 - [texane/stlink](https://github.com/texane/stlink) - STLink programmer application

## Usage

This project can either be used directly or as a submodule in a larger project.  
Note that submodule use will allow updates to this project for fixes or further device support.  
For an example project using this method, see [TODO].

### To use the project directly:

1. Download this repository
2. Change the project name and device in the CMakeLists.txt file
3. Move your source  and include files into the source and include directories
4. Add your source files to the CMakeLists.txt file
5. Make something awesome!

### To use this project as a submodule:

1. Add the submodule to your (already git controlled) project using:  
   `git submodule add https://github.com/ryankurte/stm32f4-base.git`  
   `git submodule update`  
2. Copy the CMakeLists.txt file from this project (stm32f4-base) to the top level of your project
3. Update the project name and BASE_LOCATION variables in the new CMakeLists.txt
4. Add your source files (and cmake libraries) to the CMakeLists.txt file
5. Make something even more awesome!

## Building

Once you have integrated this project with your project, you can build in the standard cmake manner.  

1. `mkdir build`
2. `cd build`
3. `cmake ..`
4. `make`
5. `make flash` (to program the attached device)

## Examples

A couple of ST Examples ported to this framework are included in the examples directory. To use, change to the `examples/EXAMPLE` directory and run the build steps above.  

## Notes

* As of 2016-06-01 the latest version of stlink in the homebrew repositories does not support STM32F7 devices. To use the flash command you will need to compile the latest tools from the github link above.

If you have any issues, suggestions or alterations, feel free to open an issue or a pull request.  

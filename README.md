# cmake-config

## Features
This configuration adds some basic build option handling and default build flags to a CMake project. It supports ```gcc```, ```clang``` and ```msvc``` compilers.
- Sets the default build type to ```Debug``` if a ```.git``` directory is present in the project source directory, otherwise sets it to ```Release```.

- Adds ```CMAKE_BUILD_TYPE``` property in ```ccmake``` menu with four possible options: ```Debug```, ```Release```, ```MinSizeRel```, ```RelWithDebInfo```.

- For ```msvc``` it turns on maximum warnings (```/W4```) for all build types and sets optimization level to ```/O2``` when ```Release``` build type is selected.

- For ```gcc``` and ```clang``` it turns on the following flags:

  > -Wall -Wextra -Werror -Wpedantic -Wconversion -Wshadow
  
  When in ```Release``` mode it sets optimization level to ```O2```.
  
- Additionally if the compiler is Clang it sets the standard library to ```libc++```.
  
- It adds boolean ```ADDRESS_SANITIZER``` and ```UNDEFINED_SANITIZER``` options to ```ccmake``` menu. They are on by default if the build type is ```Debug```, otherwise they're off. When on they add the ```fsanitize=address``` and ```fsanitize=undefined``` flags respectively.

- It sets the default C++ standard to ```c++20``` without the GNU extensions.

- It turns on CMake option to export ```compile_commands.json``` file for use with IDEs and linters.

## Usage
Include this CMake file by adding ```include(${CMAKE_SOURCE_DIR}/<path_to_directory_in_project>/config.cmake)``` to your ```CMakeLists.txt```.

# Set a default build type if none was specified
set(default_build_type "Release")
if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
    set(default_build_type "Debug")
endif()
 
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
      STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
      "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Set default compiler options
if(MSVC)
    add_compile_options("/W4" "/WX" "$<$<CONFIG:RELEASE>:/O2>")
else()
    # Adds the options to turn on address and undefined sanitizers
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        option(ADDRESS_SANITIZER "Turn address sanitizer on." ON)
        option(UNDEFINED_SANITIZER "Turn undefined sanitizer on." ON)
    else()
        option(ADDRESS_SANITIZER "Turn address sanitizer on." OFF)
        option(UNDEFINED_SANITIZER "Turn undefined sanitizer on." OFF)
    endif()

    add_compile_options("-Wall" "-Wextra" "-Werror" "-Wpedantic" "-Wconversion" "-Wshadow" "$<$<CONFIG:RELEASE>:-O2>")
    add_link_options("$<$<CONFIG:RELEASE>:-O2>")

    if(${ADDRESS_SANITIZER})
        add_compile_options("-fsanitize=address")
        add_link_options("-fsanitize=address")
    endif()

    if(${UNDEFINED_SANITIZER})
        add_compile_options("-fsanitize=undefined")
        add_link_options("-fsanitize=undefined")
    endif()

    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        add_compile_options("-stdlib=libc++")
        add_link_options("-stdlib=libc++" "-lc++abi")
    endif()
endif()

# Set default CXX standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)

# Export compile_commands.json for linters
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

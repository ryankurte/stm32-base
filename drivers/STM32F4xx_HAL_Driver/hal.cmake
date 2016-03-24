# CMSIS cmake inclusion file
# Adds CMSIS headers to the build

# Add the hal headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/Inc)

# Find hal source files
file(GLOB HAL_SOURCES ${CMAKE_CURRENT_LIST_DIR}/Src/*.c)

# Create hal library
add_library(hal ${HAL_SOURCES})

# Add library to the build
set(LIBS ${LIBS} hal)

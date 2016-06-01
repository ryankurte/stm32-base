# CMSIS cmake inclusion file
# Adds CMSIS headers to the build

set(HAL_LOCATION ${CMAKE_CURRENT_LIST_DIR}/${CPU_FAMILY_U}xx_HAL_Driver)

# Add the hal headers
include_directories(${HAL_LOCATION}/Inc)

# Find hal source files
file(GLOB HAL_SOURCES ${HAL_LOCATION}/Src/*.c)

# Create hal library
add_library(hal ${HAL_SOURCES})

# Add library to the build
set(LIBS ${LIBS} hal)

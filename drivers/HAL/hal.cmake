# CMSIS cmake inclusion file
# Adds CMSIS headers to the build

set(HAL_LOCATION ${CMAKE_CURRENT_LIST_DIR}/${CPU_FAMILY_U}xx_HAL_Driver)

# Add the hal headers
include_directories(${HAL_LOCATION}/Inc)

# Find hal source files
file(GLOB HAL_SOURCES ${HAL_LOCATION}/Src/*.c)
file(GLOB HAL_TEMPLATE_SOURCES ${HAL_LOCATION}/Src/*_template.c)

# Remove _template files from standard sources
foreach(TEMPLATE ${HAL_TEMPLATE_SOURCES})
list(REMOVE_ITEM HAL_SOURCES ${TEMPLATE})
endforeach(TEMPLATE)

# Create hal library
add_library(hal ${HAL_SOURCES})

# Add library to the build
set(LIBS ${LIBS} hal)

# CMSIS cmake inclusion file
# Adds CMSIS headers to the build

# Add the CMSIS headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/Inc)

set(DEVICE_BASE "${CMAKE_CURRENT_LIST_DIR}/Device/ST/${CPU_FAMILY_U}xx")

# Find startup file
file(GLOB STARTUP_FILE "${DEVICE_BASE}/Source/Templates/gcc/" startup_${CPU_FAMILY_L}*.s)
message("Startup file: ${STARTUP_FILE}")

# Set system file name
set(SYSTEM_FILE ${DEVICE_BASE}/Source/Templates/system_${CPU_FAMILY_L}xx.c)

message("System file: ${SYSTEM_FILE}")

# Create device library
add_library(device ${STARTUP_FILE} ${SYSTEM_FILE})

# Add library to the build
set(LIBS ${LIBS} device)

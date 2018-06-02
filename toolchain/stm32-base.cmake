# STM32F4 Base CMake file
#
# Configures the project files and environment for any STM32 project

if(NOT DEFINED DEVICE)
message(FATAL_ERROR "No processor defined")
endif(NOT DEFINED DEVICE)
message("Device: ${DEVICE}")
string(TOUPPER ${DEVICE} DEVICE_U)
string(TOLOWER ${DEVICE} DEVICE_L)

# Determine device family
string(REGEX MATCH "^(STM32[FL][0-9])" CPU_FAMILY_U "${DEVICE_U}")
string(TOLOWER ${CPU_FAMILY_U} CPU_FAMILY_L)
message("Family: ${CPU_FAMILY_U}")

# Generic families
string(REGEX MATCH "^(STM32[FL][0-9][0-9][0-9])([A-Z])([A-Z])" CPU_FAMILY_MATCH "${DEVICE_U}")
set(CPU_FAMILY_A "${CMAKE_MATCH_1}x${CMAKE_MATCH_3}")
message("Family Match: ${CPU_FAMILY_A}")

# Determine short device type
string(REGEX MATCH "^(STM32[FL][0-9][0-9][0-9])" CPU_TYPE_U "${DEVICE_U}")
string(TOLOWER ${CPU_TYPE_U} CPU_TYPE_L)
message("Type: ${CPU_TYPE_U}")

# Check for required processor info
# TODO: wonder if I could parse (most of) this from the config files
if(NOT DEFINED FLASH_START)
set(FLASH_START 0x08000000)
message("No FLASH_START defined. Using default: ${FLASH_START}")
endif(NOT DEFINED FLASH_START)

if(NOT DEFINED FLASH_LENGTH)
set(FLASH_LENGTH 1024k)
message("No FLASH_LENGTH defined. Using default: ${FLASH_LENGTH}")
endif(NOT DEFINED FLASH_LENGTH)

if(NOT DEFINED RAM_LENGTH)
set(RAM_LENGTH 128k)
message("No RAM_LENGTH defined. Using default: ${RAM_LENGTH}")
endif(NOT DEFINED RAM_LENGTH)

if(NOT DEFINED CCRAM_LENGTH)
set(CCRAM_LENGTH 0k)
message("No CCRAM_LENGTH defined. Using default: ${CCRAM_LENGTH}")
endif(NOT DEFINED CCRAM_LENGTH)

# Set CPU type for compiler
if(${CPU_FAMILY_U} STREQUAL "STM32F1")
set(CPU_TYPE "m3")
elseif(${CPU_FAMILY_U} STREQUAL "STM32F4")
set(CPU_TYPE "m4")
elseif(${CPU_FAMILY_U} STREQUAL "STM32F7")
set(CPU_TYPE "m7")
elseif(${CPU_FAMILY_U} STREQUAL "STM32L0")
set(CPU_TYPE "m0+")
elseif(${CPU_FAMILY_U} STREQUAL "STM32L1")
set(CPU_TYPE "m3")
else()
message(FATAL_ERROR "Unrecognised device family: ${CPU_FAMILY_U}")
endif()

# Include libraries
include(${CMAKE_CURRENT_LIST_DIR}/../drivers/CMSIS/cmsis.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../drivers/BSP/bsp.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../drivers/HAL/hal.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../middlewares/middlewares.cmake)

# Generate linker script (if not externally defined)
if(NOT DEFINED LINKER_SCRIPT)
set(LINKER_SCRIPT stm32.ld)
configure_file(${CMAKE_CURRENT_LIST_DIR}/../stm32.ld.in
	${PROJECT_BINARY_DIR}/${LINKER_SCRIPT})
endif(NOT DEFINED LINKER_SCRIPT)

# Set compiler flags
# Common arguments
add_definitions("-D${DEVICE} -D${CPU_TYPE_U}xx -D${CPU_FAMILY_U} -D${CPU_FAMILY_A} ${OPTIONAL_DEBUG_SYMBOLS}")
set(COMMON_DEFINITIONS "-Wextra -Wall -Wno-unused-parameter -mcpu=cortex-${CPU_TYPE} -mthumb -fno-builtin -ffunction-sections -fdata-sections -fomit-frame-pointer ${OPTIONAL_DEBUG_SYMBOLS}")
set(DEPFLAGS "-MMD -MP")

# Enable FLTO optimization if required
if(USE_FLTO)
	set(OPTFLAGS "-Os -flto")
else()
	set(OPTFLAGS "-Os")
endif()

# Build flags
set(CMAKE_C_FLAGS "-std=gnu99 ${COMMON_DEFINITIONS} ${CPU_FIX} --specs=nano.specs ${DEPFLAGS}")
set(CMAKE_CXX_FLAGS "${COMMON_DEFINITIONS} ${CPU_FIX} --specs=nano.specs ${DEPFLAGS}")
set(CMAKE_ASM_FLAGS "${COMMON_DEFINITIONS} --specs=nano.specs -x assembler-with-cpp")
set(CMAKE_EXE_LINKER_FLAGS "${COMMON_DEFINITIONS} -Xlinker -T${LINKER_SCRIPT} -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections")

# Set default inclusions
set(LIBS ${LIBS} -lgcc -lc -lnosys -lgcc -lc -lnosys)

# Debug Flags
set(COMMON_DEBUG_FLAGS "-O0 -g -gdwarf-2")
set(CMAKE_C_FLAGS_DEBUG   "${COMMON_DEBUG_FLAGS}")
set(CMAKE_CXX_FLAGS_DEBUG "${COMMON_DEBUG_FLAGS}")
set(CMAKE_ASM_FLAGS_DEBUG "${COMMON_DEBUG_FLAGS}")

# Release Flags
set(COMMON_RELEASE_FLAGS "${OPTFLAGS} -DNDEBUG=1 -DRELEASE=1")
set(CMAKE_C_FLAGS_RELEASE 	"${COMMON_RELEASE_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE "${COMMON_RELEASE_FLAGS}")
set(CMAKE_ASM_FLAGS_RELEASE "${COMMON_RELEASE_FLAGS}")


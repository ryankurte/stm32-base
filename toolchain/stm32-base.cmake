# STM32F4 Base CMake file
#
# Configures the project files and environment for any STM32 project

if(NOT DEFINED DEVICE)
message(FATAL_ERROR "No processor defined")
endif(NOT DEFINED DEVICE)
message("Device: ${DEVICE}")
string(TOUPPER ${DEVICE} DEVICE_U)

# Determine device family
string(REGEX MATCH "^(STM32F[0-9])" CPU_FAMILY_U "${DEVICE_U}")
string(TOLOWER ${CPU_FAMILY_U} CPU_FAMILY_L)
message("Family: ${CPU_FAMILY_U}")

# Determine short device type
string(REGEX MATCH "^(STM32F[0-9][0-9][0-9])" CPU_TYPE_U "${DEVICE_U}")
string(TOLOWER ${CPU_TYPE_U} CPU_TYPE_L)
message("Type: ${CPU_TYPE_U}")

# Check for required processor info
# TODO: wonder if I could parse (most of) this from the config files
if(NOT DEFINED FLASH_START)
set(FLASH_START 0x00000000)
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
set(CCRAM_LENGTH 64k)
message("No CCRAM_LENGTH defined. Using default: ${CCRAM_LENGTH}")
endif(NOT DEFINED CCRAM_LENGTH)

# Set CPU type for compiler
set(CPU_TYPE "m4")

# Include libraries
include(${CMAKE_CURRENT_LIST_DIR}/../drivers/CMSIS/cmsis.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../drivers/STM32F4xx_HAL_Driver/hal.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../drivers/BSP/bsp.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../middlewares/middlewares.cmake)

# Generate linker script
set(LINKER_SCRIPT stm32f4.ld)
configure_file(${CMAKE_CURRENT_LIST_DIR}/../stm32f4.ld.in
	${PROJECT_BINARY_DIR}/${LINKER_SCRIPT})

# Set compiler flags
# Common arguments
add_definitions("-Wextra -Wall -Wno-unused-parameter")
add_definitions("-mcpu=cortex-${CPU_TYPE} -mthumb")
add_definitions("-fno-builtin -ffunction-sections -fdata-sections -fomit-frame-pointer")
add_definitions("-D${DEVICE} -D${CPU_TYPE_U}xx -D${CPU_FAMILY_U} ${OPTIONAL_DEBUG_SYMBOLS}")
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
set(CMAKE_ASM_FLAGS "${COMMON_DEFINITIONS} -x assembler-with-cpp -DLOOP_ADDR=0x8000")
set(CMAKE_EXE_LINKER_FLAGS "${COMMON_DEFINITIONS} -Xlinker -T${LINKER_SCRIPT} -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections")

# Set default inclusions
set(LIBS -lgcc -lc -lnosys ${LIBS})

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



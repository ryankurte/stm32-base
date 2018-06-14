#ARM none eabi gcc toolchain configuration

# We are cross compiling so we don't want compiler tests to run, as they will fail
include(CMakeForceCompiler)

# Indicate we aren't compiling for an OS
set(CMAKE_SYSTEM_NAME Generic)

# Set processor type
set(CMAKE_SYSTEM_PROCESSOR arm)

# Override compiler
SET(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)

# Set other tools
set(OBJSIZE ${COMPILER_PREFIX}arm-none-eabi-size)
set(OBJCOPY ${COMPILER_PREFIX}arm-none-eabi-objcopy)
set(OBJDUMP ${COMPILER_PREFIX}arm-none-eabi-objdump)
set(DEBUGGER ${COMPILER_PREFIX}arm-none-eabi-gdb)

# Remove preset linker flags
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "") 
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "") 
set(CMAKE_SHARED_LIBRARY_LINK_ASM_FLAGS "")

# Set library options
set(SHARED_LIBS OFF)
set(STATIC_LIBS ON)

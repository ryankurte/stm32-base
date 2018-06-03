# CMSIS cmake inclusion file
# Adds CMSIS headers to the build


set(DEVICE_BASE "${CMAKE_CURRENT_LIST_DIR}/Device/ST/${CPU_FAMILY_U}xx")

# Add the CMSIS headers
include_directories(
	${CMAKE_CURRENT_LIST_DIR}/Include
	${DEVICE_BASE}/Include
	)

set(STARTUP_BASE ${DEVICE_BASE}/Source/Templates/gcc)
set(CURRENT_LEN 0)

message("Startup dir: ${DEVICE_BASE}/Source/Templates/gcc/")

# Find startup file
if(DEFINED STARTUP_OVERRIDE)
    set(STARTUP_FILE ${DEVICE_BASE}/Source/Templates/gcc/${STARTUP_OVERRIDE})
    message("Startup file override: ${STARTUP_OVERRIDE}")
elseif(EXISTS ${DEVICE_BASE}/Source/Templates/gcc/startup_${DEVICE_L}.s)
    # Simple solution (direct match)
    set(STARTUP_FILE ${DEVICE_BASE}/Source/Templates/gcc/startup_${DEVICE_L}.s)
else()
    # Complicated solution, match family and chip revision
    file(GLOB STARTUP_FILES RELATIVE ${STARTUP_BASE} ${STARTUP_BASE}/startup_${CPU_TYPE_L}*.s)

    foreach(FILE ${STARTUP_FILES})
        string(REGEX REPLACE "\\.[^.]*$" "" TEST_FILE ${FILE})
        string(REGEX REPLACE "x" "[a-zA-Z]" TEST_FILE ${TEST_FILE})
        set(TEST_MATCH false)
        message("TEST: ${TEST_FILE} FILE: ${FILE} AGAINST: startup_${DEVICE_L}.s")
        string(REGEX MATCH "^(${TEST_FILE})" TEST_MATCH "startup_${DEVICE_L}.s")
        if(TEST_MATCH) 
            string(LENGTH ${FILE} FILE_LEN)
            if(${FILE_LEN} GREATER ${CURRENT_LEN}})
                set(STARTUP_FILE ${STARTUP_BASE}/${FILE})
                string(LENGTH ${FILE} CURRENT_LEN)
            endif()
        endif()
    endforeach(FILE)

endif()

if(EXISTS "${STARTUP_FILE}")
    message("Startup file: ${STARTUP_FILE}")
else()
    message(FATAL_ERROR "Startup file ${STARTUP_FILE} not found")
endif()

# Set system file name
set(SYSTEM_FILE ${DEVICE_BASE}/Source/Templates/system_${CPU_FAMILY_L}xx.c)

#message("System file: ${SYSTEM_FILE}")

# Create device library
add_library(device ${STARTUP_FILE} ${SYSTEM_FILE})

# Add library to the build
set(LIBS ${LIBS} device)

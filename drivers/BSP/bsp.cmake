# BSP discovery
# Only works with BSP files located in the stm32f4 cube release

if(DEFINED BSP)

include_directories(${CMAKE_CURRENT_LIST_DIR}/${BSP})

# Locate sources
file(GLOB BSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/${BSP} *.c)

# Add components
# BSP_COMPONENTS should be a list of components to be included
foreach(COMPONENT ${BSP_COMPONENTS})
file(GLOB_RECURSE COMPONENT_SOURCES ${CMAKE_CURRENT_LIST_DIR}/${COMPONENT} *.c)
set(BSP_COMPONENT_SOURCES ${BSP_COMPONENT_SOURCES} ${COMPONENT_SOURCES})
endforeach(COMPONENT)

# Create bsp library
add_library(bsp ${BSP_SOURCES} ${BSP_COMPONENT_SOURCES})

# Add library to the build
set(LIBS ${LIBS} bsp)

endif(DEFINED BSP)




# Add the CMSIS headers
include_directories(${CMAKE_CURRENT_LIST_DIR}/include)

# Find startup file
file(GLOB PROJECT_SOURCES ${CMAKE_CURRENT_LIST_DIR}/source *.c)

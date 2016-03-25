# Third party middleware libraries
# Middleware inclusion is designed to be as sane / automated as possible
# Because of this it's a pain to add, so, will be added as required

# Enable FatFs by spefying the driver to use
if(DEFINED FATFS_DRIVER)
	message("Using FatFS (driver: ${FATFS_DRIVER})")
	include_directories(
		${CMAKE_CURRENT_LIST_DIR}/Third_Party/FatFs/src
		${CMAKE_CURRENT_LIST_DIR}/Third_Party/FatFs/src/drivers
		)	
	file(GLOB FATFS_SOURCES ${CMAKE_CURRENT_LIST_DIR}/Third_Party/FatFs/src/*.c)
	file(GLOB FATFS_DRIVER_SOURCES ${CMAKE_CURRENT_LIST_DIR}/Third_Party/FatFs/src/drivers/${FATFS_DRIVER}.c)
	add_library(fatfs ${FATFS_SOURCES} ${FATFS_DRIVER_SOURCES})
	set(LIBS ${LIBS} fatfs)
endif()

# Enable USB host mode by specifying the mode to use
if(DEFINED USB_HOST_CLASS)
	message("Using USB Host mode library (class: ${USB_HOST_CLASS})")

	include_directories(${CMAKE_CURRENT_LIST_DIR}/ST/STM32_USB_Host_Library/Core/Inc)	
	file(GLOB_RECURSE USB_HOST_CORE_SOURCE ${CMAKE_CURRENT_LIST_DIR}/ST/STM32_USB_Host_Library/Core/Src/*.c)

	include_directories(${CMAKE_CURRENT_LIST_DIR}/ST/STM32_USB_Host_Library/Class/${USB_HOST_CLASS}/Inc)	
	file(GLOB_RECURSE USB_HOST_CLASS_SOURCE ${CMAKE_CURRENT_LIST_DIR}/ST/STM32_USB_Host_Library/Class/${USB_HOST_CLASS}/Src/*.c)

	add_library(usbhost ${USB_HOST_CORE_SOURCE} ${USB_HOST_CLASS_SOURCE})
	set(LIBS ${LIBS} usbhost)
endif()



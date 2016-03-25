# ST_Link functions
# Adds targets for ST-Link programmers and emulators

# Configure flasher script for the project
set(BINARY ${TARGET}.bin)

#Add JLink commands
add_custom_target(debug 
	COMMAND ${DEBUGGER} -tui -command ${CMAKE_CURRENT_LIST_DIR}/remote.gdbconf ${CMAKE_CURRENT_BINARY_DIR}/${TARGET} 
	DEPENDS ${TARGET}
	)

add_custom_target(debug-server 
	COMMAND st-util --listen_port 2331
	DEPENDS ${TARGET}
	)

add_custom_target(flash 
	COMMAND st-flash --reset write ${BINARY} ${FLASH_START}
	DEPENDS ${TARGET}
	)

add_custom_target(erase 
	COMMAND st-flash erase
	)


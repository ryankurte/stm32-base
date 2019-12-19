# ARM post build commands

# Create binary file
add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJCOPY} -O binary ${TARGET}.elf ${TARGET}.bin)

add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJCOPY} -O ihex ${TARGET}.elf ${TARGET}.hex)

add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJDUMP} -d -S ${TARGET}.elf > ${TARGET}.dmp)

add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJSIZE} ${TARGET}.elf)

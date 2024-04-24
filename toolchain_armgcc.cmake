set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)
if(${CMAKE_VERSION} VERSION_LESS "3.16.0")
    message(WARNING "Current CMake version is ${CMAKE_VERSION}. KL25Z-cmake requires CMake 3.16 or greater")

endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")


set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(SIZE arm-none-eabi-size)
set(MCPU cortex-m23)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

add_compile_options(-mcpu=${MCPU} -mthumb -mthumb-interwork)

add_definitions(-fmessage-length=0 
				-fsigned-char 
				-ffunction-sections 
				-fdata-sections 
				-fno-strict-aliasing 
                -ffunction-sections 
                -fdata-sections 
                -fmerge-constants
                -mapcs)

set(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/linker_scripts/gcc/fsp.ld)
add_link_options(-T ${LINKER_SCRIPT}
                -mthumb
                -mcpu=${MCPU}
                -specs=nano.specs 
                -Wl,--gc-sections
                -Wl,--print-memory-usage
                -Wl,--no-warn-rwx-segments
                -lm
                -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map
                )

include_directories(${CMAKE_CURRENT_LIST_DIR}/inc ${CMAKE_CURRENT_LIST_DIR}/inc/CMSIS/Core/Include/)

set(STARTUP_SCRIPT_SOURCES "${CMAKE_CURRENT_LIST_DIR}/src/system.c" "${CMAKE_CURRENT_LIST_DIR}/src/gcc/startup.c")



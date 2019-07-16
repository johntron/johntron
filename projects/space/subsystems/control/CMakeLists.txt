cmake_minimum_required(VERSION 3.2)
#project(control)
#
#include(CMakeListsPrivate.txt)
#
#add_custom_target(
#    PLATFORMIO_BUILD ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion run
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_BUILD_VERBOSE ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion run --verbose
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_UPLOAD ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion run --target upload
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_CLEAN ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion run --target clean
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_MONITOR ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion device monitor
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_TEST ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion test
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_PROGRAM ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion run --target program
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_UPLOADFS ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion run --target uploadfs
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_UPDATE_ALL ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion update
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_custom_target(
#    PLATFORMIO_REBUILD_PROJECT_INDEX ALL
#    COMMAND ${PLATFORMIO_CMD} -f -c clion init --ide clion
#    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#)
#
#add_executable(${PROJECT_NAME} ${SRC_LIST})


# Tests
add_executable(my_test test/motor.cpp)
enable_testing()
add_test(NAME Test COMMAND my_test)

include_directories(lib)

add_library(Catch2 INTERFACE)
target_include_directories(Catch2 INTERFACE lib/Catch2)
target_link_libraries(my_test Catch2)

add_library(fakeit INTERFACE)
target_include_directories(fakeit INTERFACE lib/fakeit)
target_link_libraries(my_test fakeit)

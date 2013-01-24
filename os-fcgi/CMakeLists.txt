cmake_minimum_required (VERSION 2.8)

set(target "os-fcgi")
project(${target})

list(APPEND SOURCES os-fcgi.cpp)
list(APPEND SOURCES os/objectscript.cpp)
list(APPEND SOURCES fcgi-2.4.1/libfcgi/os_unix.c)
list(APPEND SOURCES fcgi-2.4.1/libfcgi/fcgiapp.c)
list(APPEND SOURCES MPFDParser-1.0/Parser.cpp)
list(APPEND SOURCES MPFDParser-1.0/Field.cpp)
list(APPEND SOURCES MPFDParser-1.0/Exception.cpp)

include_directories(os)
include_directories(fcgi-2.4.1)
include_directories(fcgi-2.4.1/include)
include_directories(MPFDParser-1.0)

if(NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  add_custom_target(strip_${target} ALL COMMAND ${CMAKE_STRIP} ${CMAKE_CURRENT_BINARY_DIR}/${target})
endif()

add_executable(${target} ${SOURCES} ${HEADERS})
target_link_libraries(${target} ${FCGI_LIBRARY} "pthread")

install(TARGETS ${target} RUNTIME DESTINATION usr/sbin)
install(DIRECTORY ../conf/etc/init.d DESTINATION etc/init.d)
install(DIRECTORY ../conf/etc/os-fcgi DESTINATION etc/os-fcgi)

cmake_minimum_required (VERSION 3.0)

project( MulleObjCExpatFoundation)


set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/mulle-configuration/cmake)
message(STATUS "CMAKE_MODULE_PATH is ${CMAKE_MODULE_PATH}")
message(STATUS "CMAKE_BUILD_TYPE is ${CMAKE_BUILD_TYPE}")

set( MULLE_LANGUAGE "ObjC")

if( "${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  include( Debug)
else()
  include( Release)
endif()

set( CMAKE_FIND_ROOT_PATH ${DEPENDENCIES_DIR})
message( STATUS "CMAKE_FIND_ROOT_PATH is ${CMAKE_FIND_ROOT_PATH}")


include( CMakeSourcesAndHeaders.txt)
include( CMakeDependencies.txt)


add_library( MulleObjCExpatFoundation STATIC
${SOURCES}
${PUBLIC_HEADERS}
${PRIVATE_HEADERS}
CMakeDependencies.txt
CMakeSourcesAndHeaders.txt
)

target_link_libraries( MulleObjCExpatFoundation
)


add_library( MulleObjCExpatFoundationStandalone SHARED
src/MulleObjCExpatFoundationStandalone.m
${PUBLIC_HEADERS}
)

add_dependencies( MulleObjCExpatFoundationStandalone MulleObjCExpatFoundation)

target_link_libraries( MulleObjCExpatFoundationStandalone
${BEGIN_ALL_LOAD}
MulleObjCExpatFoundation
${C_DEPENDENCY_LIBRARIES}
${OBJC_DEPENDENCY_LIBRARIES}
${END_ALL_LOAD}
${OS_SPECIFIC_LIBRARIES}
)

message( STATUS "OBJC_DEPENDENCY_NAMES is ${OBJC_DEPENDENCY_NAMES}")

# runs in build dir
add_custom_command( TARGET MulleObjCExpatFoundationStandalone
   POST_BUILD
   COMMAND ${DEPENDENCIES_DIR}/bin/mulle-objc-create-dependencies-inc -v -o ${CMAKE_SOURCE_DIR}/src/dependencies.inc MulleObjCExpatFoundation ${OBJC_DEPENDENCY_NAMES}
)

set( PUBLIC_HEADERS
${PUBLIC_HEADERS}
"CMakeDependencies.txt"
"src/dependencies.inc"
)


install( TARGETS MulleObjCExpatFoundation MulleObjCExpatFoundationStandalone DESTINATION "lib")
install( FILES ${PUBLIC_HEADERS} DESTINATION "include/MulleObjCExpatFoundation")
install( FILES ${PRIVATE_HEADERS} DESTINATION "include/MulleObjCExpatFoundation/private")

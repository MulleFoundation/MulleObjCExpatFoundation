cmake_minimum_required (VERSION 3.0)

project( MulleObjCExpatFoundation C)


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

set( MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY ON)

include( CMakeDependencies.txt)
include( CMakeSourcesAndHeaders.txt)

include_directories( ${INCLUDE_DIRS})


set( PUBLIC_HEADERS
${PUBLIC_HEADERS}
"CMakeDependencies.txt"
"src/dependencies.inc"
)


add_library( MulleObjCExpatFoundation STATIC
${SOURCES}
${PUBLIC_HEADERS}
${PRIVATE_HEADERS}
CMakeSourcesAndHeaders.txt
)

set( OBJC_LIBRARY_NAME "MulleObjCExpatFoundation")

include( DependenciesIncObjC)


#
# produce a standalone dll/dylib/so for testing mainly
# though testing could go static at some point in time
# (shared is more frugal though)
#
set( STANDALONE_BASE_NAME "MulleObjCExpatFoundation")
set( STANDALONE_NAME "MulleObjCExpatFoundationStandalone")
set( STANDALONE_DEFINITIONS ${MULLE_OBJC_EXPAT_FOUNDATION_DEFINITIONS})
set( STANDALONE_ALL_LOAD_LIBRARIES
    $<TARGET_FILE:${STANDALONE_BASE_NAME}>
    ${OBJC_DEPENDENCY_LIBRARIES}
    ${OBJC_STARTUP_LIBRARY}
    ${C_DEPENDENCY_LIBRARIES}
)

include( Standalone)

install( TARGETS MulleObjCExpatFoundation MulleObjCExpatFoundationStandalone DESTINATION "lib")
install( FILES ${PUBLIC_HEADERS} DESTINATION "include/MulleObjCExpatFoundation")
install( FILES ${PRIVATE_HEADERS} DESTINATION "include/MulleObjCExpatFoundation/private")

include( MulleTest)

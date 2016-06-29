cmake_minimum_required (VERSION 3.0)

project (MulleObjCExpatFoundation)


set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/mulle-configuration)
message(STATUS "CMAKE_MODULE_PATH is ${CMAKE_MODULE_PATH}")
message(STATUS "CMAKE_BUILD_TYPE is ${CMAKE_BUILD_TYPE}")
if( "${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  include( Debug)
else()
  include( Release)
endif()

include( FindEXPAT)
find_package(EXPAT 2.0 REQUIRED)

include_directories(
src
${EXPAT_INCLUDE_DIRS}
)


set( HEADERS
src/MulleObjCExpatFoundation.h
)


set( SOURCES
src/MulleObjCExpatFoundation.c
src/NSPropertyListSerialization+Expat.m
)


add_library( MulleObjCExpatFoundation STATIC
src/MulleObjCExpatFoundation.c
src/NSPropertyListSerialization+Expat.m
)

add_library( MulleStandaloneObjCExpatFoundation SHARED
src/MulleStandaloneObjCExpatFoundation.m
)

add_dependencies( MulleStandaloneObjCExpatFoundation MulleObjCExpatFoundation)

TARGET_LINK_LIBRARIES( MulleStandaloneObjCExpatFoundation
${BEGIN_ALL_LOAD}
MulleObjCExpatFoundation
MulleObjCFoundation
MulleObjC
mulle_utf
mulle_sprintf
mulle_objc_runtime
mulle_container
mulle_concurrent
mulle_aba
mulle_allocator
mulle_test_allocator
${END_ALL_LOAD}
)


INSTALL( TARGETS MulleObjCExpatFoundation MulleStandaloneObjCExpatFoundation DESTINATION "lib")
INSTALL( FILES src/MulleStandaloneObjCExpatFoundation.h DESTINATION "include/MulleStandaloneObjCExpatFoundation")
INSTALL( FILES ${HEADERS} DESTINATION "include/MulleObjCExpatFoundation")

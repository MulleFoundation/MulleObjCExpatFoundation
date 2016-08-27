cmake_minimum_required (VERSION 3.4)

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

add_library( MulleObjCExpatFoundationStandalone SHARED
src/MulleObjCExpatFoundationStandalone.m
)

add_dependencies( MulleObjCExpatFoundationStandalone MulleObjCExpatFoundation)

TARGET_LINK_LIBRARIES( MulleObjCExpatFoundationStandalone
${BEGIN_ALL_LOAD}
MulleObjCExpatFoundation
MulleObjCFoundation
MulleObjC
mulle_utf
mulle_sprintf
mulle_objc
mulle_container
mulle_concurrent
mulle_aba
mulle_allocator
mulle_test_allocator
${END_ALL_LOAD}
-lexpat
)


INSTALL( TARGETS MulleObjCExpatFoundation MulleObjCExpatFoundationStandalone DESTINATION "lib")
INSTALL( FILES ${HEADERS} DESTINATION "include/MulleObjCExpatFoundation")

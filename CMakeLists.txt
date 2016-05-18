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


add_library( MulleObjCExpatFoundation STATIC
src/MulleObjCExpatFoundation.c
src/NSPropertyListSerialization+Expat.m
)

INSTALL( TARGETS MulleObjCExpatFoundation DESTINATION "lib")
INSTALL( FILES ${HEADERS} DESTINATION "include/MulleObjCExpatFoundation")

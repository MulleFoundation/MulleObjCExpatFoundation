cmake_minimum_required( VERSION 3.0)

project( expat NONE)

file( GLOB BUILDINFO_DIRS
   expat*
)

foreach( DIR ${BUILDINFO_DIRS} )
   install( DIRECTORY "${DIR}" DESTINATION "share/mulle-craft")
endforeach()

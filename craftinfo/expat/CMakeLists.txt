cmake_minimum_required( VERSION 3.0)

project( expat NONE)

file( GLOB DEFINITION_DIRS
   definition*
)

foreach( DIR ${DEFINITION_DIRS} )
   install( DIRECTORY "${DIR}" DESTINATION "share/mulle-craft/expat")
endforeach()

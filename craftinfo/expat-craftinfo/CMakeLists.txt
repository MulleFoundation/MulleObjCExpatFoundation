cmake_minimum_required( VERSION 3.13...99.99)

project( expat NONE)

file( GLOB MAPPER_SCRIPTS
   dispense-mapper*.sh*
)

install( FILES ${MAPPER_SCRIPTS} DESTINATION "share/mulle-craft/expat")


file( GLOB DEFINITION_DIRS
   definition*
)

install( DIRECTORY ${DEFINITION_DIRS} DESTINATION "share/mulle-craft/expat")


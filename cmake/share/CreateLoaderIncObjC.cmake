if( NOT __CREATE_LOADER_INC_OBJC_CMAKE__)
   set( __CREATE_LOADER_INC_OBJC_CMAKE__ ON)

   if( MULLE_TRACE_INCLUDE)
      message( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
   endif()

   # this is the the second part, the option is in DependenciesIncObjC
   if( CREATE_OBJC_LOADER_INC)
      #
      # _1_MulleObjCExpatFoundation is an object library (a collection of files).
      # _2_MulleObjCExpatFoundation is the loader with OBJC_LOADER_INC.
      # Produce a static library _3_MulleObjCExpatFoundation from _1_MulleObjCExpatFoundation
      # to feed into MULLE_OBJC_LOADER_TOOL.
      #
      # The static library is, so that the commandline doesn't overflow for
      # many .o files.
      # In the end OBJC_LOADER_INC will be generated, which will be
      # included by the Loader.
      #

      add_library( "_3_MulleObjCExpatFoundation" STATIC
         $<TARGET_OBJECTS:_1_MulleObjCExpatFoundation>
      )

      add_custom_command(
         OUTPUT ${OBJC_LOADER_INC}
         COMMAND ${MULLE_OBJC_LOADER_TOOL}
                   -v
                   -c "${CMAKE_BUILD_TYPE}"
                   -o "${OBJC_LOADER_INC}"
                   $<TARGET_FILE:_3_MulleObjCExpatFoundation>
                   ${INHERITED_OBJC_LOADERS}
         DEPENDS $<TARGET_FILE:_3_MulleObjCExpatFoundation>
                 ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         COMMENT  "Create: ${OBJC_LOADER_INC}"
         VERBATIM
      )

      add_custom_target( "__objc_loader_inc__"
         DEPENDS ${OBJC_LOADER_INC}
      )

      add_dependencies( "_2_MulleObjCExpatFoundation" __objc_loader_inc__)
   endif()

   include( CreateLoaderIncObjCAux OPTIONAL)

endif()
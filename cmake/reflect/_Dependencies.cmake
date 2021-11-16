# This file will be regenerated by `mulle-sourcetree-to-cmake` via
# `mulle-sde reflect` and any edits will be lost.
#
# This file will be included by cmake/share/Files.cmake
#
# Disable generation of this file with:
#
# mulle-sde environment set MULLE_SOURCETREE_TO_CMAKE_DEPENDENCIES_FILE DISABLE
#
if( MULLE_TRACE_INCLUDE)
   message( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
endif()

#
# Generated from sourcetree: a2dcf4d0-48f2-4e74-8aef-13e42ef36b92;expat;no-all-load,no-import;
# Disable with : `mulle-sourcetree mark expat no-link`
# Disable for this platform: `mulle-sourcetree mark expat no-cmake-platform-${MULLE_UNAME}`
#
if( NOT EXPAT_LIBRARY)
   find_library( EXPAT_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}expat${CMAKE_STATIC_LIBRARY_SUFFIX} expat NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "EXPAT_LIBRARY is ${EXPAT_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( EXPAT_LIBRARY)
      #
      # Add EXPAT_LIBRARY to DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark expat no-cmake-add`
      #
      set( DEPENDENCY_LIBRARIES
         ${DEPENDENCY_LIBRARIES}
         ${EXPAT_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark expat no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_EXPAT_ROOT "${EXPAT_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_EXPAT_ROOT "${_TMP_EXPAT_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark expat no-cmake-dependency`
      #
      foreach( _TMP_EXPAT_NAME "expat")
         set( _TMP_EXPAT_DIR "${_TMP_EXPAT_ROOT}/include/${_TMP_EXPAT_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_EXPAT_DIR}/DependenciesAndLibraries.cmake")
            unset( EXPAT_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_EXPAT_DIR}")
            # we only want top level INHERIT_OBJC_LOADERS, so disable them
            if( NOT NO_INHERIT_OBJC_LOADERS)
               set( NO_INHERIT_OBJC_LOADERS OFF)
            endif()
            list( APPEND _TMP_INHERIT_OBJC_LOADERS ${NO_INHERIT_OBJC_LOADERS})
            set( NO_INHERIT_OBJC_LOADERS ON)
            #
            include( "${_TMP_EXPAT_DIR}/DependenciesAndLibraries.cmake")
            #
            list( GET _TMP_INHERIT_OBJC_LOADERS -1 NO_INHERIT_OBJC_LOADERS)
            list( REMOVE_AT _TMP_INHERIT_OBJC_LOADERS -1)
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_EXPAT_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${EXPAT_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_EXPAT_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
   else()
      # Disable with: `mulle-sourcetree mark expat no-require-link`
      message( FATAL_ERROR "EXPAT_LIBRARY was not found")
   endif()
endif()


#
# Generated from sourcetree: 404EA57B-418F-4A2E-AF22-16970AFBBD03;MulleObjCPlistFoundation;no-singlephase;
# Disable with : `mulle-sourcetree mark MulleObjCPlistFoundation no-link`
# Disable for this platform: `mulle-sourcetree mark MulleObjCPlistFoundation no-cmake-platform-${MULLE_UNAME}`
#
if( NOT MULLE_OBJC_PLIST_FOUNDATION_LIBRARY)
   find_library( MULLE_OBJC_PLIST_FOUNDATION_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleObjCPlistFoundation${CMAKE_STATIC_LIBRARY_SUFFIX} MulleObjCPlistFoundation NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_OBJC_PLIST_FOUNDATION_LIBRARY is ${MULLE_OBJC_PLIST_FOUNDATION_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_OBJC_PLIST_FOUNDATION_LIBRARY)
      #
      # Add MULLE_OBJC_PLIST_FOUNDATION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark MulleObjCPlistFoundation no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_OBJC_PLIST_FOUNDATION_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark MulleObjCPlistFoundation no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_OBJC_PLIST_FOUNDATION_ROOT "${MULLE_OBJC_PLIST_FOUNDATION_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_OBJC_PLIST_FOUNDATION_ROOT "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleObjCPlistFoundation no-cmake-dependency`
      #
      foreach( _TMP_MULLE_OBJC_PLIST_FOUNDATION_NAME "MulleObjCPlistFoundation")
         set( _TMP_MULLE_OBJC_PLIST_FOUNDATION_DIR "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_PLIST_FOUNDATION_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_OBJC_PLIST_FOUNDATION_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_DIR}")
            #
            include( "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_OBJC_PLIST_FOUNDATION_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark MulleObjCPlistFoundation no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_OBJC_PLIST_FOUNDATION_NAME "MulleObjCPlistFoundation")
            set( _TMP_MULLE_OBJC_PLIST_FOUNDATION_FILE "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_PLIST_FOUNDATION_NAME}/MulleObjCLoader+${_TMP_MULLE_OBJC_PLIST_FOUNDATION_NAME}.h")
            if( EXISTS "${_TMP_MULLE_OBJC_PLIST_FOUNDATION_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_OBJC_PLIST_FOUNDATION_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Disable with: `mulle-sourcetree mark MulleObjCPlistFoundation no-require-link`
      message( FATAL_ERROR "MULLE_OBJC_PLIST_FOUNDATION_LIBRARY was not found")
   endif()
endif()


#
# Generated from sourcetree: 06CB6048-6DD4-42CF-ADA6-0A73CABDDD39;MulleBase64;;
# Disable with : `mulle-sourcetree mark MulleBase64 no-link`
# Disable for this platform: `mulle-sourcetree mark MulleBase64 no-cmake-platform-${MULLE_UNAME}`
#
if( NOT MULLE_BASE64_LIBRARY)
   find_library( MULLE_BASE64_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleBase64${CMAKE_STATIC_LIBRARY_SUFFIX} MulleBase64 NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_BASE64_LIBRARY is ${MULLE_BASE64_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_BASE64_LIBRARY)
      #
      # Add MULLE_BASE64_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark MulleBase64 no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_BASE64_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark MulleBase64 no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_BASE64_ROOT "${MULLE_BASE64_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_BASE64_ROOT "${_TMP_MULLE_BASE64_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleBase64 no-cmake-dependency`
      #
      foreach( _TMP_MULLE_BASE64_NAME "MulleBase64")
         set( _TMP_MULLE_BASE64_DIR "${_TMP_MULLE_BASE64_ROOT}/include/${_TMP_MULLE_BASE64_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_BASE64_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_BASE64_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_BASE64_DIR}")
            #
            include( "${_TMP_MULLE_BASE64_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_BASE64_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_BASE64_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_BASE64_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark MulleBase64 no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_BASE64_NAME "MulleBase64")
            set( _TMP_MULLE_BASE64_FILE "${_TMP_MULLE_BASE64_ROOT}/include/${_TMP_MULLE_BASE64_NAME}/MulleObjCLoader+${_TMP_MULLE_BASE64_NAME}.h")
            if( EXISTS "${_TMP_MULLE_BASE64_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_BASE64_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Disable with: `mulle-sourcetree mark MulleBase64 no-require-link`
      message( FATAL_ERROR "MULLE_BASE64_LIBRARY was not found")
   endif()
endif()


#
# Generated from sourcetree: 8649B13A-A8E7-4E52-8E23-EBB3EFBFADF1;MulleFoundation;;
# Disable with : `mulle-sourcetree mark MulleFoundation no-link`
# Disable for this platform: `mulle-sourcetree mark MulleFoundation no-cmake-platform-${MULLE_UNAME}`
#
if( NOT MULLE_FOUNDATION_LIBRARY)
   find_library( MULLE_FOUNDATION_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleFoundation${CMAKE_STATIC_LIBRARY_SUFFIX} MulleFoundation NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_FOUNDATION_LIBRARY is ${MULLE_FOUNDATION_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_FOUNDATION_LIBRARY)
      #
      # Add MULLE_FOUNDATION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_FOUNDATION_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_FOUNDATION_ROOT "${MULLE_FOUNDATION_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_FOUNDATION_ROOT "${_TMP_MULLE_FOUNDATION_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-dependency`
      #
      foreach( _TMP_MULLE_FOUNDATION_NAME "MulleFoundation")
         set( _TMP_MULLE_FOUNDATION_DIR "${_TMP_MULLE_FOUNDATION_ROOT}/include/${_TMP_MULLE_FOUNDATION_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_FOUNDATION_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_FOUNDATION_DIR}")
            #
            include( "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_FOUNDATION_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_FOUNDATION_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_FOUNDATION_NAME "MulleFoundation")
            set( _TMP_MULLE_FOUNDATION_FILE "${_TMP_MULLE_FOUNDATION_ROOT}/include/${_TMP_MULLE_FOUNDATION_NAME}/MulleObjCLoader+${_TMP_MULLE_FOUNDATION_NAME}.h")
            if( EXISTS "${_TMP_MULLE_FOUNDATION_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_FOUNDATION_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Disable with: `mulle-sourcetree mark MulleFoundation no-require-link`
      message( FATAL_ERROR "MULLE_FOUNDATION_LIBRARY was not found")
   endif()
endif()

/*
 *   This file will be regenerated by `mulle-project-versioncheck`.
 *   Any edits will be lost.
 */
#ifndef mulle_objc_expat_foundation_versioncheck_h__
#define mulle_objc_expat_foundation_versioncheck_h__

#if defined( MULLE_BASE64_VERSION)
# ifndef MULLE_BASE64_VERSION_MIN
#  define MULLE_BASE64_VERSION_MIN  ((0UL << 20) | (0 << 8) | 8)
# endif
# ifndef MULLE_BASE64_VERSION_MAX
#  define MULLE_BASE64_VERSION_MAX  ((0UL << 20) | (1 << 8) | 0)
# endif
# if MULLE_BASE64_VERSION < MULLE_BASE64_VERSION_MIN || MULLE_BASE64_VERSION >= MULLE_BASE64_VERSION_MAX
#  pragma message("MULLE_BASE64_VERSION     is " MULLE_C_STRINGIFY_MACRO( MULLE_BASE64_VERSION))
#  pragma message("MULLE_BASE64_VERSION_MIN is " MULLE_C_STRINGIFY_MACRO( MULLE_BASE64_VERSION_MIN))
#  pragma message("MULLE_BASE64_VERSION_MAX is " MULLE_C_STRINGIFY_MACRO( MULLE_BASE64_VERSION_MAX))
#  if MULLE_BASE64_VERSION < MULLE_BASE64_VERSION_MIN
#   error "MulleBase64 is too old"
#  else
#   error "MulleBase64 is too new"
#  endif
# endif
#endif
#if defined( MULLE_FOUNDATION_BASE_VERSION)
# ifndef MULLE_FOUNDATION_BASE_VERSION_MIN
#  define MULLE_FOUNDATION_BASE_VERSION_MIN  ((0UL << 20) | (26 << 8) | 0)
# endif
# ifndef MULLE_FOUNDATION_BASE_VERSION_MAX
#  define MULLE_FOUNDATION_BASE_VERSION_MAX  ((0UL << 20) | (27 << 8) | 0)
# endif
# if MULLE_FOUNDATION_BASE_VERSION < MULLE_FOUNDATION_BASE_VERSION_MIN || MULLE_FOUNDATION_BASE_VERSION >= MULLE_FOUNDATION_BASE_VERSION_MAX
#  pragma message("MULLE_FOUNDATION_BASE_VERSION     is " MULLE_C_STRINGIFY_MACRO( MULLE_FOUNDATION_BASE_VERSION))
#  pragma message("MULLE_FOUNDATION_BASE_VERSION_MIN is " MULLE_C_STRINGIFY_MACRO( MULLE_FOUNDATION_BASE_VERSION_MIN))
#  pragma message("MULLE_FOUNDATION_BASE_VERSION_MAX is " MULLE_C_STRINGIFY_MACRO( MULLE_FOUNDATION_BASE_VERSION_MAX))
#  if MULLE_FOUNDATION_BASE_VERSION < MULLE_FOUNDATION_BASE_VERSION_MIN
#   error "MulleFoundationBase is too old"
#  else
#   error "MulleFoundationBase is too new"
#  endif
# endif
#endif

#endif

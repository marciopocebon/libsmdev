dnl Function to test if a certain feature was enabled
AC_DEFUN([LIBSMDEV_TEST_ENABLE],
 [AC_ARG_ENABLE(
  [$1],
  [AS_HELP_STRING(
   [--enable-$1],
   [$3 (default is $4)])],
  [ac_cv_libsmdev_enable_$2=$enableval],
  [ac_cv_libsmdev_enable_$2=$4])dnl
  AC_CACHE_CHECK(
   [whether to enable $3],
   [ac_cv_libsmdev_enable_$2],
   [ac_cv_libsmdev_enable_$2=$4])dnl
 ])

dnl Function to detect whether printf conversion specifier "%jd" is available
AC_DEFUN([LIBSMDEV_CHECK_FUNC_PRINTF_JD],
 [AC_MSG_CHECKING(
  [whether printf supports the conversion specifier "%jd"])

 SAVE_CFLAGS="$CFLAGS"
 CFLAGS="$CFLAGS -Wall -Werror"
 AC_LANG_PUSH(C)

 dnl First try to see if compilation and linkage without a parameter succeeds
 AC_LINK_IFELSE(
  [AC_LANG_PROGRAM(
   [[#include <stdio.h>]],
   [[printf( "%jd" ); ]] )],
  [ac_cv_libsmdev_have_printf_jd=no],
  [ac_cv_libsmdev_have_printf_jd=yes])

 dnl Second try to see if compilation and linkage with a parameter succeeds
 AS_IF(
  [test "x$ac_cv_libsmdev_have_printf_jd" = xyes],
  [AC_LINK_IFELSE(
   [AC_LANG_PROGRAM(
    [[#include <sys/types.h>
#include <stdio.h>]],
    [[printf( "%jd", (off_t) 10 ); ]] )],
    [ac_cv_libsmdev_have_printf_jd=yes],
    [ac_cv_libsmdev_have_printf_jd=no])
  ])

 dnl Third try to see if the program runs correctly
 AS_IF(
  [test "x$ac_cv_libsmdev_have_printf_jd" = xyes],
  [AC_RUN_IFELSE(
   [AC_LANG_PROGRAM(
    [[#include <sys/types.h>
#include <stdio.h>]],
    [[char string[ 3 ];
if( snprintf( string, 3, "%jd", (off_t) 10 ) < 0 ) return( 1 );
if( ( string[ 0 ] != '1' ) || ( string[ 1 ] != '0' ) ) return( 1 ); ]] )],
    [ac_cv_libsmdev_have_printf_jd=yes],
    [ac_cv_libsmdev_have_printf_jd=no],
    [ac_cv_libsmdev_have_printf_jd=undetermined])
   ])

 AC_LANG_POP(C)
 CFLAGS="$SAVE_CFLAGS"

 AS_IF(
  [test "x$ac_cv_libsmdev_have_printf_jd" = xyes],
  [AC_MSG_RESULT(
   [yes])
  AC_DEFINE(
   [HAVE_PRINTF_JD],
   [1],
   [Define to 1 whether printf supports the conversion specifier "%jd".]) ],
  [AC_MSG_RESULT(
   [$ac_cv_libsmdev_have_printf_jd]) ])
 ])

dnl Function to detect whether printf conversion specifier "%zd" is available
AC_DEFUN([LIBSMDEV_CHECK_FUNC_PRINTF_ZD],
 [AC_MSG_CHECKING(
  [whether printf supports the conversion specifier "%zd"])

 SAVE_CFLAGS="$CFLAGS"
 CFLAGS="$CFLAGS -Wall -Werror"
 AC_LANG_PUSH(C)

 dnl First try to see if compilation and linkage without a parameter succeeds
 AC_LINK_IFELSE(
  [AC_LANG_PROGRAM(
   [[#include <stdio.h>]],
   [[printf( "%zd" ); ]] )],
  [ac_cv_libsmdev_have_printf_zd=no],
  [ac_cv_libsmdev_have_printf_zd=yes])

 dnl Second try to see if compilation and linkage with a parameter succeeds
 AS_IF(
  [test "x$ac_cv_libsmdev_have_printf_zd" = xyes],
  [AC_LINK_IFELSE(
   [AC_LANG_PROGRAM(
    [[#include <sys/types.h>
#include <stdio.h>]],
    [[printf( "%zd", (size_t) 10 ); ]] )],
    [ac_cv_libsmdev_have_printf_zd=yes],
    [ac_cv_libsmdev_have_printf_zd=no])
  ])

 dnl Third try to see if the program runs correctly
 AS_IF(
  [test "x$ac_cv_libsmdev_have_printf_zd" = xyes],
  [AC_RUN_IFELSE(
   [AC_LANG_PROGRAM(
    [[#include <sys/types.h>
#include <stdio.h>]],
    [[char string[ 3 ];
if( snprintf( string, 3, "%zd", (size_t) 10 ) < 0 ) return( 1 );
if( ( string[ 0 ] != '1' ) || ( string[ 1 ] != '0' ) ) return( 1 ); ]] )],
    [ac_cv_libsmdev_have_printf_zd=yes],
    [ac_cv_libsmdev_have_printf_zd=no],
    [ac_cv_libsmdev_have_printf_zd=undetermined])
   ])

 AC_LANG_POP(C)
 CFLAGS="$SAVE_CFLAGS"

 AS_IF(
  [test "x$ac_cv_libsmdev_have_printf_zd" = xyes],
  [AC_MSG_RESULT(
   [yes])
  AC_DEFINE(
   [HAVE_PRINTF_ZD],
   [1],
   [Define to 1 whether printf supports the conversion specifier "%zd".]) ],
  [AC_MSG_RESULT(
   [$ac_cv_libsmdev_have_printf_zd]) ])
 ])

dnl Function to detect if posix_fadvise is available
AC_DEFUN([LIBSMDEV_CHECK_FUNC_POSIX_FADVISE],
 [AC_CHECK_FUNCS([posix_fadvise])

 AS_IF(
  [test "x$ac_cv_func_posix_fadvise" = xyes],
  [AC_MSG_CHECKING(
    [whether posix_fadvise can be linked])

   SAVE_CFLAGS="$CFLAGS"
   CFLAGS="$CFLAGS -Wall -Werror"
   AC_LANG_PUSH(C)

   AC_LINK_IFELSE(
    AC_LANG_PROGRAM(
     [[#include <fcntl.h>]],
     [[#if !defined( POSIX_FADV_SEQUENTIAL )
#define POSIX_FADV_SEQUENTIAL 2
#endif
posix_fadvise( 0, 0, 0, POSIX_FADV_SEQUENTIAL )]]),
     [ac_cv_func_posix_fadvise=yes],
     [ac_cv_func_posix_fadvise=no])

   AC_LANG_POP(C)
   CFLAGS="$SAVE_CFLAGS"

   AS_IF(
    [test "x$ac_cv_func_posix_fadvise" = xyes],
    [AC_MSG_RESULT(
     [yes])
    AC_DEFINE(
     [HAVE_POSIX_FADVISE],
     [1],
     [Define to 1 if you have the posix_fadvise function.]) ],
    [AC_MSG_RESULT(
     [no]) ])
  ])
 ])

dnl Function to detect if libuna available
AC_DEFUN([LIBSMDEV_CHECK_LIBUNA],
 [AC_CHECK_HEADERS([libuna.h])

 AS_IF(
  [test "x$ac_cv_header_libuna_h" = xno],
  [ac_libsmdev_have_libuna=no],
  [ac_libsmdev_have_libuna=yes
  AC_CHECK_LIB(
   una,
   libuna_get_version,
   [],
   [ac_libsmdev_have_libuna=no])
 
  dnl Byte stream functions
  AC_CHECK_LIB(
   una,
   libuna_byte_stream_size_from_utf16,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_byte_stream_copy_from_utf16,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_byte_stream_size_from_utf32,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_byte_stream_copy_from_utf32,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
 
  dnl UTF-16 string functions
  AC_CHECK_LIB(
   una,
   libuna_utf16_string_size_from_byte_stream,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf16_string_copy_from_byte_stream,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf16_string_size_from_utf8,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf16_string_copy_from_utf8,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
 
  dnl UTF-32 string functions
  AC_CHECK_LIB(
   una,
   libuna_utf32_string_size_from_byte_stream,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf32_string_copy_from_byte_stream,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf32_string_size_from_utf8,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf32_string_copy_from_utf8,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
 
  dnl UTF-8 string functions
  AC_CHECK_LIB(
   una,
   libuna_utf8_string_size_from_utf16,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf8_string_copy_from_utf16,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf8_string_size_from_utf32,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  AC_CHECK_LIB(
   una,
   libuna_utf8_string_copy_from_utf32,
   [ac_libsmdev_dummy=yes],
   [ac_libsmdev_have_libuna=no])
  ])
 ])


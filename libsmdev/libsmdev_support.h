/*
 * libsmdev support functions
 *
 * Copyright (c) 2008-2010, Joachim Metz <forensics@hoffmannbv.nl>,
 * Hoffmann Investigations.
 *
 * Refer to AUTHORS for acknowledgements.
 *
 * This software is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this software.  If not, see <http://www.gnu.org/licenses/>.
 */

#if !defined( _LIBSMDEV_SUPPORT_H )
#define _LIBSMDEV_SUPPORT_H

#include <common.h>
#include <types.h>

#include <liberror.h>

#include "libsmdev_extern.h"

#if defined( __cplusplus )
extern "C" {
#endif

LIBSMDEV_EXTERN const char *libsmdev_get_version(
                            void );

LIBSMDEV_EXTERN int libsmdev_check_device(
                     const char *filename,
                     liberror_error_t **error );

#if defined( HAVE_WIDE_CHARACTER_TYPE )
LIBSMDEV_EXTERN int libsmdev_check_device_wide(
                     const char *filename,
                     liberror_error_t **error );
#endif

#if defined( __cplusplus )
}
#endif

#endif


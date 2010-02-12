/*
 * Handle functions
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

#if !defined( _LIBSMDEV_INTERNAL_HANDLE_H )
#define _LIBSMDEV_INTERNAL_HANDLE_H

#include <common.h>
#include <types.h>

#include <liberror.h>

#include "libsmdev_extern.h"
#include "libsmdev_list_type.h"
#include "libsmdev_string.h"
#include "libsmdev_system_string.h"
#include "libsmdev_types.h"

#if defined( __cplusplus )
extern "C" {
#endif

typedef struct libsmdev_internal_handle libsmdev_internal_handle_t;

struct libsmdev_internal_handle
{
	/* The device filename
	 */
	libsmdev_system_character_t *filename;

	/* The device filename size
	 */
	size_t filename_size;

#if defined( WINAPI )
	/* The device file handle
	 */
	HANDLE file_handle;
#else
	/* The device file descriptor
	 */
	int file_descriptor;
#endif

	/* The current offset
	 */
	off64_t offset;

	/* The amount of bytes per sector
	 */
	uint32_t bytes_per_sector;

	/* Value to indicate the bytes per sector value was set
	 */
	uint8_t bytes_per_sector_set;

	/* The media size
	 */
	size64_t media_size;

	/* Value to indicate the media size value was set
	 */
	uint8_t media_size_set;

	/* The bus type
	 */
	uint8_t bus_type;

	/* The device type
	 */
	uint8_t device_type;

	/* Value to indicate if the device is removable
	 */
	uint8_t removable;

	/* The vendor string
	 */
	libsmdev_character_t vendor[ 64 ];

	/* The model string
	 */
	libsmdev_character_t model[ 64 ];

	/* The serial number string
	 */
	libsmdev_character_t serial_number[ 64 ];

	/* The amount of sessions for an optical disc
	 */
	uint16_t amount_of_sessions;

	/* Value to indicate the media information values were set
	 */
	uint8_t media_information_set;

	/* The amount of read/write error retries
	 */
	uint8_t amount_of_error_retries;

	/* The error granularity
	 */
	size_t error_granularity;

	/* The read/write error flags
	 */
	uint8_t error_flags;

	/* The read/write errors offset list
	 */
	libsmdev_list_t *errors_list;

	/* Value to indicate if abort was signalled
	 */
	int abort;
};

LIBSMDEV_EXTERN int libsmdev_handle_initialize(
                     libsmdev_handle_t **handle,
                     liberror_error_t **error );

LIBSMDEV_EXTERN int libsmdev_handle_free(
                     libsmdev_handle_t **handle,
                     liberror_error_t **error );

LIBSMDEV_EXTERN int libsmdev_handle_signal_abort(
                     libsmdev_handle_t *handle,
                     liberror_error_t **error );

LIBSMDEV_EXTERN int libsmdev_handle_open(
                     libsmdev_handle_t *handle,
                     char * const filenames[],
                     int amount_of_filenames,
                     int flags,
                     liberror_error_t **error );

#if defined( HAVE_WIDE_CHARACTER_TYPE )
LIBSMDEV_EXTERN int libsmdev_handle_open_wide(
                     libsmdev_handle_t *handle,
                     wchar_t * const filenames[],
                     int amount_of_filenames,
                     int flags,
                     liberror_error_t **error );
#endif

LIBSMDEV_EXTERN int libsmdev_handle_close(
                     libsmdev_handle_t *handle,
                     liberror_error_t **error );

LIBSMDEV_EXTERN ssize_t libsmdev_handle_read_buffer(
                         libsmdev_handle_t *handle,
                         void *buffer,
                         size_t buffer_size,
                         liberror_error_t **error );

LIBSMDEV_EXTERN ssize_t libsmdev_handle_write_buffer(
                         libsmdev_handle_t *handle,
                         void *buffer,
                         size_t buffer_size,
                         liberror_error_t **error );

LIBSMDEV_EXTERN off64_t libsmdev_handle_seek_offset(
                         libsmdev_handle_t *handle,
                         off64_t offset,
                         int whence,
                         liberror_error_t **error );

LIBSMDEV_EXTERN int libsmdev_handle_get_offset(
                     libsmdev_handle_t *handle,
                     off64_t *offset,
                     liberror_error_t **error );

LIBSMDEV_EXTERN int libsmdev_handle_get_filename_size(
                     libsmdev_handle_t *handle,
                     size_t *filename_size,
                     liberror_error_t **error );

LIBSMDEV_EXTERN int libsmdev_handle_get_filename(
                     libsmdev_handle_t *handle,
                     char *filename,
                     size_t filename_size,
                     liberror_error_t **error );

int libsmdev_handle_set_filename(
     libsmdev_handle_t *handle,
     const char *filename,
     size_t filename_length,
     liberror_error_t **error );

#if defined( HAVE_WIDE_CHARACTER_TYPE )
LIBSMDEV_EXTERN int libsmdev_handle_get_filename_size_wide(
                     libsmdev_handle_t *handle,
                     size_t *filename_size,
                     liberror_error_t **error );

LIBSMDEV_EXTERN int libsmdev_handle_get_filename_wide(
                     libsmdev_handle_t *handle,
                     wchar_t *filename,
                     size_t filename_size,
                     liberror_error_t **error );

int libsmdev_handle_set_filename_wide(
     libsmdev_handle_t *handle,
     const wchar_t *filename,
     size_t filename_length,
     liberror_error_t **error );
#endif

int libsmdev_file_exists(
     const char *filename,
     liberror_error_t **error );

#if defined( HAVE_WIDE_CHARACTER_TYPE )
int libsmdev_file_exists_wide(
     const wchar_t *filename,
     liberror_error_t **error );
#endif

#if defined( __cplusplus )
}
#endif

#endif


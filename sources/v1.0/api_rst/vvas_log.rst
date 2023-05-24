.. _VVAS Logging APIs:

**VVAS Logging APIs**

 This file contains logging function declaration and helper macros for core libraries to print log



.. c:enum:: VvasLogLevel

   Log levels supported VVAS Core APIs

**Constants**

``LOG_LEVEL_ERROR``
  Prints ERROR logs

``LOG_LEVEL_WARNING``
  Prints WARNING and ERROR logs

``LOG_LEVEL_INFO``
  Prints INFO, WARNING & ERROR logs

``LOG_LEVEL_DEBUG``
  Prints DEBUG, INFO, WARNING & ERROR logs


.. c:function:: void vvas_log (uint32_t log_level, uint32_t set_log_level, const char *filename, const char *func, uint32_t line, const char *fmt, ...)

   This function send logs to a destination based on environment variable value VVAS_CORE_LOG_FILE_PATH

**Parameters**

``uint32_t log_level``
  Log level

``uint32_t set_log_level``
  Log level to filter logs

``const char *filename``
  Source code filename from which this logging is triggered

``const char *func``
  Source code function name

``uint32_t line``
  Source code line number

``const char *fmt``
  Format string passed for logging.

``...``
  variable arguments

**Description**

This API dumps logs based on VVAS_CORE_LOG_FILE_PATH environment variable like below:
  1. if Valid path is set then logs will be stored in specified path.
  2. if "CONSOLE" is set then logs will be routed to console.
  3. if no value is set then logs will be routed to syslog

**Note**

It is recommended use macros LOG_ERROR/LOG_WARNING/LOG_INFO/LOG_DEBUG instead of calling this function to avoid sending multiple arguments

**Return**

None



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.. _device_debug.rst:

Debugging
~~~~~~~~~


VVAS Debugging 
##############

This section covers various debugging options available in VVAS.

GStreamer logs
===============

VVAS relies on debugging tools supported by GStreamer framework. For more details, you may refer to `GStreamer Debugging Tools <https://gstreamer.freedesktop.org/documentation/tutorials/basic/debugging-tools.html?gi-language=c>`_

vvas-core library logs
=======================

VVAS GStreamer plug-ins are using different vvas-core libraries for different functionalities. Logs specific to each of these vvas-core libraries can be enabled/disabled. How to rout these to syslog, to a file or to the console is covered in the section below.
vvas-core library logs will be routed to one of the options mentioned below.

To syslog
----------
If syslog is supported, this is the default destination for the logs. Logs will be routed to either ``/var/log/syslog`` or ``/var/logs/messages``.

.. note::

        Make sure systemd or other logging service is running
        
.. note::

        Syslog support currently not available in V70 platform. 
        

To a File
----------
If environment variable ``VVAS_CORE_LOG_FILE_PATH`` is set to file path then vvas-core logs will be routed to file provided.
if file path is invalid or unable to create file in the provided path due to permissions then logs will be routed to SYSLOG.

.. code-block::

        Example: export VVAS_CORE_LOG_FILE_PATH=$PWD/log.txt

To Console
----------
If environment variable ``VVAS_CORE_LOG_FILE_PATH`` is set to “CONSOLE” then vvas-core logs will be routed to console.

.. code-block::

        Example: export VVAS_CORE_LOG_FILE_PATH=CONSOLE


.. note::

        The current V70 docker container sets the ``VVAS_CORE_LOG_FILE_PATH`` to "CONSOLE" inside the setup file ``docker_env_setup.sh``. Hence after sourcing that setup file VVAS core logs are routed to the console. 


Setting VVAS_CORE Log Level
============================
To set vvas_core log level for GStreamer based applications, GST_EXPORT should be set accordingly. Mapping between GStreamer log level and vvas-core library log level is as mentioned below.

.. list-table::
   :widths: 20 80
   :header-rows: 1

   * - GStreamer Log level
     - vvas-core log level

   * - GST_LEVEL_NONE, GST_LEVEL_ERROR
     - LOG_LEVEL_ERROR

   * - GST_LEVEL_WARNING, GST_LEVEL_FIXME
     - LOG_LEVEL_WARNING

   * - GST_LEVEL_INFO
     - LOG_LEVEL_INFO

   * - Default
     - LOG_LEVEL_DEBUG


Device side debugging
#####################

V70 device runs Petalinux on APU and to check the V70 device side logs, login to minicom and access device side Linux terminal. The steps are as below

- Install minicom on the host system (outside of the docker) using ``sudo apt install minicom``
- Access V70 device via minicom using below command (run outside the docker on host system)

.. code-block:: shell 
     
      sudo minicom -D /dev/ttyXRTUL1
      
- Serial device ``ttyXRTUL1`` is considering single Alveo card installed on the host

- Once V70 device is accessible, one can use below handy commands for further debug in addition to normal Linux commands to see memory info, cpu info and dmesg.

- To check if VDU soft kernels are installed and how many, lookout for skd in process status command

.. code-block:: shell

       ps -ef | grep skd

- See VDU software control and soft kernel logs inside ``/var/log/messages``


..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

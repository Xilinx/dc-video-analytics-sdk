.. _VVAS Context APIs:

**VVAS Context APIs**


This file contains context related structures and method declarations for VVAS core libraries.



.. c:struct:: VvasContext

   Holds a context related to a device

**Definition**

::

  struct VvasContext {
    int32_t dev_idx;
    char *xclbin_loc;
    vvasDeviceHandle dev_handle;
    uuid_t uuid;
    VvasLogLevel log_level;
  };

**Members**

``dev_idx``
  Device index to which current context belongs

``xclbin_loc``
  xclbin location which is used to configure a device

``dev_handle``
  Device Handle to which current context belongs to and having device index :c:type:`VvasContext->dev_idx <VvasContext>`

``uuid``
  UUID of xclbin

``log_level``
  Loging level to be used by context



.. c:function:: VvasContext* vvas_context_create (int32_t dev_idx, char * xclbin_loc, VvasLogLevel log_level, VvasReturnType *vret)

   Opens device specified by dev_idx and download xclbin image on the same

**Parameters**

``int32_t dev_idx``
  Index of the FPGA device. This can be -1 if no FPGA is present

``char * xclbin_loc``
  Location of xclbin to be downloaded on device index **dev_idx**. This can be NULL as well in case user does not want to access FPGA device

``VvasLogLevel log_level``
  Logging level

``VvasReturnType *vret``
  Address to store return value. In case of error, **vret** is useful in understanding the root cause

**Description**

User can create multiple contexts to a device with same xclbin. If user wish to create
a context with different xclbin than the xclbin already configured on a FPGA device,
he/she need to first destroy the old context with vvas_context_destroy()
before creating new context. User shall provide valid **dev_idx** and **xclbin_loc** if
there is a need to access FPGA device while calling this API. In case a vvas-core API doesn't need to access any FPGA
device, then device id must be -1 and xclbin_loc can be NULL

**Return**



* Address of VvasContext on success
* NULL on failure


.. c:function:: VvasReturnType vvas_context_destroy (VvasContext* vvas_ctx)

   Destroys device context

**Parameters**

``VvasContext* vvas_ctx``
  Context to device

**Description**

Before destroying the context, application should destroy modules which are using current context.

**Return**

:c:type:`enum VvasReturnType <VvasReturnType>`



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.. _VVAS Common APIs:

**VVAS Common APIs**

This file contains common structures, enumerations and method declarations for VVAS core libraries.



.. c:enum:: VvasReturnType

   Enum representing VVAS core APIs' return type

**Constants**

``VVAS_RET_ALLOC_ERROR``
  Memory allocation error

``VVAS_RET_INVALID_ARGS``
  Invalid arguments to APIs

``VVAS_RET_ERROR``
  Generic error

``VVAS_RET_SUCCESS``
  Success

``VVAS_RET_EOS``
  End of stream

``VVAS_RET_SEND_AGAIN``
  Call the API without changing arguments

``VVAS_RET_NEED_MOREDATA``
  Core APIs need more data to complete a specific operation

``VVAS_RET_CAPS_CHANGED``
  Capabilities changed

**Note**

Negative number represents error and positive number is not an error




.. c:enum:: VvasDataSyncFlags

   Flags to synchronize data between host and FPGA device

**Constants**

``VVAS_DATA_SYNC_NONE``
  No DMA Synchronization required

``VVAS_DATA_SYNC_FROM_DEVICE``
  Synchronize data from device to host

``VVAS_DATA_SYNC_TO_DEVICE``
  Synchronize data from host to device

**Description**

Data will be synchronized from device to host or host to device via DMA operation.
Here host is an x86 machine and device is an FPGA device




.. c:enum:: VvasDataMapFlags

   Flags used while mapping memory

**Constants**

``VVAS_DATA_MAP_NONE``
  Default flag

``VVAS_DATA_MAP_READ``
  Map memory in read mode

``VVAS_DATA_MAP_WRITE``
  Map memory in write mode

**Description**

Memory flags used while mapping underlying memory to user space




.. c:enum:: VvasAllocationType

   Enum representing VVAS allocation type

**Constants**

``VVAS_ALLOC_TYPE_UNKNOWN``
  Unknown allocation type

``VVAS_ALLOC_TYPE_CMA``
  Physically contiguous Memory will be allocated by backend drivers (i.e XRT)

``VVAS_ALLOC_TYPE_NON_CMA``
  Memory will be allocated using malloc API




.. c:enum:: VvasAllocationFlags

   Enum representing VVAS allocation flags. Can be extended in future.

**Constants**

``VVAS_ALLOC_FLAG_UNKNOWN``
  Unknown allocation type

``VVAS_ALLOC_FLAG_NONE``
  To create memory both on FPGA device and host. This is the default option




.. c:struct:: VvasAllocationInfo

   Structure to store information related memory allocation

**Definition**

::

  struct VvasAllocationInfo {
    uint8_t mbank_idx;
    VvasAllocationType alloc_type;
    VvasAllocationFlags alloc_flags;
    VvasDataMapFlags map_flags;
    VvasDataSyncFlags sync_flags;
  };

**Members**

``mbank_idx``
  Index of the Memory bank from which memory is allocated

``alloc_type``
  Memory allocation type :c:type:`enum VvasAllocationType <VvasAllocationType>`

``alloc_flags``
  Flags used to allocate memory :c:type:`enum VvasAllocationFlags <VvasAllocationFlags>`

``map_flags``
  Flags to indicate current mapping type :c:type:`enum VvasDataMapFlags <VvasDataMapFlags>`

``sync_flags``
  Flags which represents data synchronization requirement **enum** VvasDataSyncFlags





.. c:struct:: VvasMetadata

   Structure to store frame metadata

**Definition**

::

  struct VvasMetadata {
    uint64_t pts;
    uint64_t dts;
    uint64_t duration;
  };

**Members**

``pts``
  Presentation timestamp

``dts``
  Decoding timestamp

``duration``
  Duration of the frame





.. c:enum:: VvasFontType

   Fonts supported by VVAS core

**Constants**

``VVAS_FONT_HERSHEY_SIMPLEX``
  Normal size sans-serif font

``VVAS_FONT_HERSHEY_PLAIN``
  Small size sans-serif font

``VVAS_FONT_HERSHEY_DUPLEX``
  Normal size sans-serif font (more complex than VVAS_FONT_HERSHEY_SIMPLEX)

``VVAS_FONT_HERSHEY_COMPLEX``
  Normal size serif font

``VVAS_FONT_HERSHEY_TRIPLEX``
  Normal size serif font (more complex than VVAS_FONT_HERSHEY_COMPLEX)

``VVAS_FONT_HERSHEY_COMPLEX_SMALL``
  Smaller version of VVAS_FONT_HERSHEY_COMPLEX



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

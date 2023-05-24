.. _VVAS Memory APIs:

**VVAS Memory APIs**

This file contains structures and methods related VVAS memory.

.. c:macro:: VvasMemoryDataFreeCB

   **Typedef**: Callback function to be called to free memory pointed by **data**, when VvasMemory handle is getting freed using **vvas_memory_free\(\)** API.


**Syntax**

  ``void VvasMemoryDataFreeCB (void *data, void *user_data)``

**Parameters**

``void *data``
  Address of the data pointer

``void *user_data``
  User data pointer sent via **vvas_memory_alloc_from_data\(\)** API

**Return**

None




.. c:struct:: VvasMemoryMapInfo

   Stores information related to VvasMemory after mapping

**Definition**

::

  struct VvasMemoryMapInfo {
    uint8_t *data;
    size_t size;
  };

**Members**

``data``
  Pointer to memory which is mapped to user space using VvasDataMapFlags

``size``
  Size of the mapped memory



.. c:function:: VvasMemory* vvas_memory_alloc (VvasContext *vvas_ctx, VvasAllocationType mem_type, VvasAllocationFlags mem_flags, uint8_t mbank_idx, size_t size, VvasReturnType *ret)

   Allocates memory specified by **size** and other arguments passed to this API

**Parameters**

``VvasContext *vvas_ctx``
  Address of VvasContext handle created using **vvas_context_create\(\)**

``VvasAllocationType mem_type``
  Type of the memory need to be allocated

``VvasAllocationFlags mem_flags``
  Flags of type :c:type:`enum VvasAllocationFlags <VvasAllocationFlags>`

``uint8_t mbank_idx``
  Index of the memory bank on which memory need to be allocated

``size_t size``
  Size of the memory to be allocated.

``VvasReturnType *ret``
  Address to store return value. In case of error, **ret** is useful in understanding the root cause

**Return**



* On Success, returns VvasMemory handle,
* On Failure, returns NULL


.. c:function:: VvasMemory* vvas_memory_alloc_from_data (VvasContext *vvas_ctx, uint8_t *data, size_t size, VvasMemoryDataFreeCB free_cb, void *user_data, VvasReturnType *ret)

   Allocates VvasMemory handle from **data** pointer and **size**

**Parameters**

``VvasContext *vvas_ctx``
  Address of VvasContext handle created using **vvas_context_create\(\)**

``uint8_t *data``
  Pointer to data which needs to encapsulated in :c:type:`struct VvasMemory <VvasMemory>`

``size_t size``
  Size of the memory to which **data** pointer is pointing

``VvasMemoryDataFreeCB free_cb``
  Callback function to be called during **vvas_memory_free\(\)** API.

``void *user_data``
  User defined data

``VvasReturnType *ret``
  Address to store return value. Upon case of error, **ret** is useful in understanding the root cause

**Description**

When application allocates memory and needs to send it to VVAS core APIs, this API is useful to wrap this memory pointer into VvasMemory handle.

**Return**



* On Success, returns VvasMemory handle,
* On Failure, returns NULL


.. c:function:: void vvas_memory_free (VvasMemory* vvas_mem)

   Frees the memory allocated by **vvas_memory_alloc\(\)** API

**Parameters**

``VvasMemory* vvas_mem``
  Address of :c:type:`struct VvasMemory <VvasMemory>` object

**Return**

None


.. c:function:: VvasReturnType vvas_memory_map (VvasMemory* vvas_mem, VvasDataMapFlags flags, VvasMemoryMapInfo *info)

   Maps **vvas_mem** to user space using **flags**. Based on :c:type:`VvasMemory->sync_flags <VvasMemory>`, data will be synchronized between host and device.

**Parameters**

``VvasMemory* vvas_mem``
  Address of :c:type:`struct VvasMemory <VvasMemory>` object

``VvasDataMapFlags flags``
  Flags used to map **vvas_mem**

``VvasMemoryMapInfo *info``
  Structure which gets populated after mapping is successful

**Return**

:c:type:`enum VvasReturnType <VvasReturnType>`


.. c:function:: VvasReturnType vvas_memory_unmap (VvasMemory* vvas_mem, VvasMemoryMapInfo *info)

   Unmaps **vvas_mem** from user space

**Parameters**

``VvasMemory* vvas_mem``
  Address of :c:type:`struct VvasMemory <VvasMemory>` object

``VvasMemoryMapInfo *info``
  Memory map information populated during vvas_memory_map() API

**Return**

:c:type:`enum VvasReturnType <VvasReturnType>`


.. c:function:: void vvas_memory_set_metadata (VvasMemory* vvas_mem, VvasMetadata *meta_data)

   Sets :c:type:`VvasMetadata` metadata on :c:type:`struct VvasMemory <VvasMemory>` object

**Parameters**

``VvasMemory* vvas_mem``
  Address of :c:type:`struct VvasMemory <VvasMemory>` object

``VvasMetadata *meta_data``
  Address of :c:type:`struct VvasMetadata <VvasMetadata>` to be set on **vvas_mem**

**Return**

None


.. c:function:: void vvas_memory_get_metadata (VvasMemory* vvas_mem, VvasMetadata *meta_data)

   Gets :c:type:`VvasMetadata` metadata from :c:type:`struct VvasMemory <VvasMemory>` object

**Parameters**

``VvasMemory* vvas_mem``
  Address of :c:type:`struct VvasMemory <VvasMemory>` object

``VvasMetadata *meta_data``
  Address of :c:type:`struct VvasMetadata <VvasMetadata>` to be populated by this API
  .

**Return**

None



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

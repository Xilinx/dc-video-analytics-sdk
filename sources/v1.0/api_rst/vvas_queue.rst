.. _VVAS Queue APIs:

**VVAS Queue APIs**

This file contains APIs for handling Queue related operations.



.. c:type:: VvasQueue

   Handle for VvasQueue instance.


.. c:function:: VvasQueue * vvas_queue_new (int32_t length)

   Allocates a new VvasQueue.

**Parameters**

``int32_t length``
  Queue length, -1 for no limit on length.   

**Context**

This API allocates a new VvasQueue. This instance
must be freed using **vvas_queue_free**.

**Return**

Handle for VvasQueue.


.. c:function:: void vvas_queue_free (VvasQueue * vvas_queue)

   Frees memory allocated for the VvasQueue.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using vvas_queue_new.

**Context**

This API frees the memory allocated for the VvasQueue. 
If queue elements contain dynamically-allocated memory,
then they should be freed first.

**Return**

none.


.. c:macro:: VvasQueueDestroyNotify

   **Typedef**: Destroy Notification callback.


**Syntax**

  ``void VvasQueueDestroyNotify (void *data)``

**Parameters**

``void *data``
  data to be freeed. 

**Return**

void. 


.. c:function:: void vvas_queue_free_full (VvasQueue * vvas_queue, VvasQueueDestroyNotify free_func)

   Free's all the memory used by a VvasQueue.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

``VvasQueueDestroyNotify free_func``
  Callback function which is called when a data element
  is destroyed. It is passed the pointer to the data 
  element and should free any memory and resources 
  allocated for it.  

**Context**

This API frees all the memory used by a VvasQueue, and calls the
specified destroy function on every element's data. free_func 
should not modify the queue (eg, by removing the freed element from it).

**Return**

None.


.. c:function:: void vvas_queue_clear (VvasQueue * vvas_queue)

   Removes all the elements in queue.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using  **vvas_queue_new**.

**Context**

This API removes all the elements in queue. If queue elements contain
dynamically-allocated memory, they should be freed first.

**Return**

None.


.. c:function:: void vvas_queue_clear_full (VvasQueue * vvas_queue, VvasQueueDestroyNotify free_func)

   Free's all the memory used by a VvasQueue.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

``VvasQueueDestroyNotify free_func``
  Callback function which is called when a data element is freed.
  It is passed the pointer to the data element and should free any
  memory and resources allocated for it.
   

**Context**

This API frees all the memory used by a VvasQueue, and calls the 
provided free_func on each item in the VvasQueue.free_func should
not modify the queue (eg, by removing the freed element from it).

**Return**

None.


.. c:function:: bool vvas_queue_is_empty (VvasQueue * vvas_queue)

   Check's if vvas_queue is empty/not.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

**Context**

This API is to check if vvas_queue is empty or not.

**Return**

Returns TRUE if vvas_queue is empty.


.. c:function:: uint32_t vvas_queue_get_length (VvasQueue * vvas_queue)

   Get's queue length.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

**Context**

This API is to get the vvas_queue's length.

**Return**

Returns the number of items in the queue.


.. c:macro:: VvasQueueFunc

   **Typedef**: Queue iteration callback.


**Syntax**

  ``void VvasQueueFunc (void *data, void *udata)``

**Parameters**

``void *data``
  Queue handle. 

``void *udata``
  user data. 

**Context**

Call back function.

**Return**

void.


.. c:function:: void vvas_queue_for_each (VvasQueue * vvas_queue, VvasQueueFunc func, void *user_data)

   Callback function called for each element.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

``VvasQueueFunc func``
  A callback function to be called for each element of the queue.

``void *user_data``
  user data to be passed.  

**Context**

This API Calls func for each element in the queue passing 
user_data to the function. func should not modify the queue.

**Return**

None.


.. c:function:: bool vvas_queue_enqueue (VvasQueue * vvas_queue, void *data)

   Adds a new Queue element at the tail.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

``void *data``
  The data for the new element.

**Context**

This API Adds a new element at the tail of the queue, this API will
block if the queue is full. For non blocking enqueue use 
**vvas_queue_enqueue_noblock**.

**Return**

None.


.. c:function:: bool vvas_queue_enqueue_noblock (VvasQueue * vvas_queue, void *data)

   API Adds a new element at the tail.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

``void *data``
  The data for the new element.  

**Context**

This API Adds a new element at the tail of the queue, this API will
not block when queue is full.

**Return**

Returns TRUE is data is enquired, FALSE otherwise.


.. c:function:: void * vvas_queue_dequeue (VvasQueue * vvas_queue)

   Removes the first element of the queue.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

**Context**

This API removes the first element of the queue and returns its data.
This API will block if the queue is empty. For non blocking dequeue use
**vvas_queue_dequeue_noblock**.

**Return**

The data of the first element in the queue, or NULL if the queue is empty.


.. c:function:: void * vvas_queue_dequeue_noblock (VvasQueue * vvas_queue)

   Removes the first element & returns its data.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.  

**Context**

This API removes the first element of the queue and returns its data.

**Return**

The data of the first element in the queue, or NULL if the queue is empty.


.. c:function:: void * vvas_queue_dequeue_timeout (VvasQueue * vvas_queue, uint64_t timeout)

   Removes the first element of the queue.

**Parameters**

``VvasQueue * vvas_queue``
  VvasQueue allocated using **vvas_queue_new**.

``uint64_t timeout``
  Time in microseconds to wait for data in the queue.

**Context**

This API removes the first element of the queue and returns its data.
If the queue is empty, it will block for timeout microseconds, or until
data becomes available.

**Return**

 * The data of the first element in the queue.
 * If no data is received before timeout, NULL is returned.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

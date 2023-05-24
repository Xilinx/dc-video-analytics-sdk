.. _VVAS Mutex APIs:

**VVAS Mutex APIs**

This file contains APIs for handling synchronization.



.. c:type:: VvasMutex

   Holds the reference to Mutex handle.




.. c:union:: _VvasMutex

   This union is for creating Mutex instance.

**Definition**

::

  union _VvasMutex {
    void* p;
    int32_t i[2];
  };

**Members**

``p``
  Pointer for Mutex Handle.

``i``
  Mutex count.



.. c:function:: void vvas_mutex_init (VvasMutex *mutex)

   Initializes mutex.

**Parameters**

``VvasMutex *mutex``
  Handle of mutex.

**Return**

None.


.. c:function:: void vvas_mutex_lock (VvasMutex *mutex)

   Locks mutex.

**Parameters**

``VvasMutex *mutex``
  Handle of mutex.

**Context**

This function Locks mutex. If mutex is already locked by another thread
the current thread will block until mutex is unlocked by the
other thread.

**Return**

None.


.. c:function:: bool vvas_mutex_trylock (VvasMutex *mutex)

   Try's lock on Mutex.

**Parameters**

``VvasMutex *mutex``
  Address of mutex object.

**Context**

This function will try to lock mutex. If mutex is already locked by
another thread, it immediately returns FALSE.

**Return**



 * TRUE - If mutex lock is acquired. 
 * FALSE - If failes to acquire lock. 


.. c:function:: void vvas_mutex_unlock (VvasMutex *mutex)

   Unlocks Mutex.

**Parameters**

``VvasMutex *mutex``
  Address of mutex object.

**Context**

This function unlocks mutex.

**Return**

None.


.. c:function:: void vvas_mutex_clear (VvasMutex *mutex)

   Clears Mutex.

**Parameters**

``VvasMutex *mutex``
  Address of mutex object.

**Context**

This function frees resources allocated to the mutex.

**Return**

None.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

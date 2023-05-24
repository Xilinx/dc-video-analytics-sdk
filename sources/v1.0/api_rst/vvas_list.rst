.. _VVAS List APIs:

**VVAS List APIs**

This file contains APIs for handling List related operations.



.. c:struct:: VvasList

   Data structure for the list element.

**Definition**

::

  struct VvasList {
    void* data;
    struct VvasList* next;
    struct VvasList* prev;
  };

**Members**

``data``
  Holds the address of data.

``next``
  Holds the address of next element in list.

``prev``
  Holds the address of previous element in list.



.. c:function:: void vvas_list_free (VvasList* list)

   Frees all the memory allocated and used by VvasList.

**Parameters**

``VvasList* list``
  Pointer to  VvasList.

**Return**

None


.. c:function:: VvasList* vvas_list_append (VvasList* list, void *data)

   Add a new element at the end of the list.

**Parameters**

``VvasList* list``
  Pointer to  VvasList in which element has to be added.

``void *data``
  Element to be added into the list.

**Return**

 * On success Returns the updated list.
 * On Failure returns NULL.


.. c:function:: uint32_t vvas_list_length (VvasList* list)

   Returns number of elements in a VvasList

**Parameters**

``VvasList* list``
  Pointer to  VvasList.

**Return**

Number of element in the  VvasList.


.. c:function:: void* vvas_list_find (VvasList * list, void * data)

   Finds the element having data in the list.

**Parameters**

``VvasList * list``
  Pointer to  VvasList.

``void * data``
  Data to look for.

**Return**



 * On Success returns the pointer to Element data found.
 * On Failure return NULL.


.. c:function:: void* vvas_list_nth_data (VvasList* list, uint32_t n)

   Gets the data of the element at the given position.

**Parameters**

``VvasList* list``
  Pointer to  VvasList.

``uint32_t n``
  Position of the element.

**Return**

 * On Success returns the pointer to Element data.
 * On Failure return NULL.


.. c:function:: VvasList* vvas_list_remove (VvasList* list, const void* data)

   Removes element from given list.

**Parameters**

``VvasList* list``
  Pointer to  VvasList.

``const void* data``
  Pointer to the data to be removed. Data is owned by the caller

**Return**

Updated  VvasList


.. c:function:: VvasList* vvas_list_first (VvasList* list)

   Gets the first element of the VvasList.

**Parameters**

``VvasList* list``
  Pointer to  VvasList.

**Return**

Pointer to the first element of the  VvasList, i.e head.


.. c:macro:: VvasFunc

   **Typedef**: Call back function for vvas_list_foreach.


**Syntax**

  ``void VvasFunc (void *data, void *udata)``

**Parameters**

``void *data``
  List element data handle.

``void *udata``
  User data.

**Return**

None


.. c:function:: void vvas_list_foreach (VvasList* list, VvasFunc func, void *data)

   Call's the function for each element of the VvasList.

**Parameters**

``VvasList* list``
  A pointer to  VvasList.

``VvasFunc func``
  A callback function to be called for each element of the list.

``void *data``
  User data to pass to the function.


.. c:macro:: vvas_list_free_notify

   **Typedef**: This is the function prototype to be passed for vvas_list_free_full.


**Syntax**

  ``void vvas_list_free_notify (void *data)``

**Parameters**

``void *data``
  Data handle to be freed

**Return**

None


.. c:function:: void vvas_list_free_full (VvasList* list, vvas_list_free_notify func)

   Frees all the memory allocated and used by VvasList.

**Parameters**

``VvasList* list``
  Pointer to  VvasList.

``vvas_list_free_notify func``
  Pointer to  vvas_list_free_full, pointer to destroy function.

**Return**

None


.. c:macro:: vvas_list_copy_func

   **Typedef**: This function will be called for list copy.


**Syntax**

  ``VOID_POINTER vvas_list_copy_func (const void* src_list, void* data)``

**Parameters**

``const void* src_list``
  Source data handle. 

``void* data``
  User data.

**Return**

New copied list.


.. c:function:: VvasList* vvas_list_copy_deep (VvasList* list, vvas_list_copy_func func, void* data)

   Performs deep copy of the list node passed.

**Parameters**

``VvasList* list``
  Pointer to  VvasList.

``vvas_list_copy_func func``
  Pointer to  vvas_list_copy_func.

``void* data``
  Pointer to user data. 

**Return**

Pointer to the first element of the  VvasList, i.e head.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

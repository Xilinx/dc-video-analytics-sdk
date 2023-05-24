.. _VVAS Hash APIs:

**VVAS Hash APIs**

This file contains APIs for handling HashMap related operations.



.. c:struct:: _VvasHashTable

   Holds hash table handle.

**Definition**

::

  struct _VvasHashTable {
  };

**Members**





.. c:struct:: VvasHashTableIter

   Holds hash table iteration information.

**Definition**

::

  struct VvasHashTableIter {
    void *dummy1;
    void *dummy2;
    void *dummy3;
    int dummy4;
    bool dummy5;
    void *dummy6;
  };

**Members**

``dummy1``
  Pointer handle, this is internal member users need not pass value. 

``dummy2``
  Pointer handle, this is internal member users need not pass value.

``dummy3``
  Pointer handle, this is internal member users need not pass value.

``dummy4``
  int value, this is internal member users need not pass value.

``dummy5``
  bool value, this is internal member users need not pass value.

``dummy6``
  Pointer handle, this is internal member users need not pass value.



.. c:macro:: VvasHashFunc

   **Typedef**: Function pointer to create hash value.


**Syntax**

  ``uint32_t VvasHashFunc (const void * key)``

**Parameters**

``const void * key``
  Key value.

**Return**

Hash value.


.. c:macro:: VvasEqualFunc

   **Typedef**: Function pointer to compare key values.


**Syntax**

  ``bool VvasEqualFunc (const void * a, const void * b)``

**Parameters**

``const void * a``
  Key value to be compared.

``const void * b``
  Key value to be compared.

**Return**

True if both are equal.


.. c:macro:: VvasDestroyNotify

   **Typedef**: Function pointer to be called when Destoryed.


**Syntax**

  ``void VvasDestroyNotify (void * data)``

**Parameters**

``void * data``
  Data to be destroyed.

**Return**

None.


.. c:macro:: VvasHRFunc

   **Typedef**: Function pointer to called for each key value pair.


**Syntax**

  ``bool VvasHRFunc (void * key, void * value, void * user_data)``

**Parameters**

``void * key``
  Key value.

``void * value``
  Hash value.

``void * user_data``
  User data to be passed.

**Return**

False to end loop.


.. c:function:: uint32_t vvas_direct_hash (const void * key)

   Converts gpointer to hash.

**Parameters**

``const void * key``
  Key Value.

**Return**

A Hash value.


.. c:function:: uint32_t vvas_int_hash (const void * key)

   Converts gpointer to int value.

**Parameters**

``const void * key``
  Key Value.

**Return**

A Hash value.


.. c:function:: uint32_t vvas_str_hash (const void * key)

   Converts a string to hash value.

**Parameters**

``const void * key``
  Key Value.

**Return**

A Hash value.


.. c:function:: bool vvas_direct_equal (const void * a, const void * b)

   Compares pointers.

**Parameters**

``const void * a``
  Pointer to be compared.

``const void * b``
  Pointer to be compared.

**Return**

True if equal.


.. c:function:: bool vvas_int_equal (const void * a, const void * b)

   Compares two int values.

**Parameters**

``const void * a``
  Pointer to be compared.

``const void * b``
  Pointer to be compared.

**Return**

True if equal.


.. c:function:: bool vvas_int64_equal (const void * a, const void * b)

   Compares two int64 values.

**Parameters**

``const void * a``
  Pointer to be compared.

``const void * b``
  Pointer to be compared.

**Return**

True if equal.


.. c:function:: bool vvas_double_equal (const void * a, const void * b)

   Compares two double values.

**Parameters**

``const void * a``
  Pointer to be compared.

``const void * b``
  Pointer to be compared.

**Return**

True if equal.


.. c:function:: bool vvas_str_equal (const void * a, const void * b)

   Compares two strings.

**Parameters**

``const void * a``
  Pointer to be compared.

``const void * b``
  Pointer to be compared.

**Return**

True if equal.


.. c:function:: VvasHashTable* vvas_hash_table_new (VvasHashFunc hash_func, VvasEqualFunc key_eq_func)

   Creates a new VvasHashTable with a reference count of 1.

**Parameters**

``VvasHashFunc hash_func``
  A function to create a hash value from a key.

``VvasEqualFunc key_eq_func``
  A function to create a hash value from a key.

**Return**

A new  VvasHashTable.


.. c:function:: VvasHashTable* vvas_hash_table_new_full (VvasHashFunc hash_func, VvasEqualFunc key_eq_func, VvasDestroyNotify key_destroy_fn, VvasDestroyNotify value_destroy_fn)

   Creates a new VvasHashTable.

**Parameters**

``VvasHashFunc hash_func``
  A function to create a hash value from a key.                

``VvasEqualFunc key_eq_func``
  A function to create a hash value from a key.

``VvasDestroyNotify key_destroy_fn``
  function to free the memory allocated for the key used
  when removing the entry from the VvasHashTable, or NULL 
  if you don’t want to supply such a function.

``VvasDestroyNotify value_destroy_fn``
  A function to free the memory allocated for the value
  used when removing the entry from the GHashTable, or NULL
  if you don’t want to supply such a function. 

**Context**

Creates a new VvasHashTable like vvas_hash_table_new() 
with a reference count of 1 and allows to specify functions 
to free the memory allocated for the key and value that get 
called when removing the entry from the VvasHashTable.

**Return**

A new VvasHashTable.


.. c:function:: bool vvas_hash_table_insert (VvasHashTable* hash_table, void * key, void * value)

   Inserts a new key and value into a VvasHashTable. 

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

``void * key``
  A key to insert.

``void * value``
  The value to associate with the key.

**Return**

TRUE if the key did not exist yet.


.. c:function:: void * vvas_hash_table_lookup (VvasHashTable* hash_table, const void * key)

   Looks up key in Hash Table

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

``const void * key``
  The key to look up.

**Return**

Associates value or NULL if key is not found.


.. c:function:: bool vvas_hash_table_contains (VvasHashTable* hash_table, void * key)

   Checks if key exit in the hash table

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

``void * key``
  A key to check.

**Return**

TRUE if key found, FALSE if key not found.


.. c:function:: uint32_t vvas_hash_table_size (VvasHashTable* hash_table)

   Returns number of elements in the hash table

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

**Return**

Number of element in the hash table.


.. c:function:: bool vvas_hash_table_remove (VvasHashTable* hash_table, void * key)

   Removes a key and its associated value from a hash table.

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

``void * key``
  The Key to remove.

**Return**

TRUE if key was found and removed from hash table.


.. c:function:: uint32_t vvas_hash_table_foreach_remove (VvasHashTable* hash_table, VvasHRFunc func, void * user_data)

   Calls the function for each remove

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

``VvasHRFunc func``
  The function to call for each key/value pair.

``void * user_data``
  user data to be passed to the function.

**Context**

Calls the given function for each key/value pair in the hash table.
if function returns TRUE, then key/value pair is removed from 
the hash table.

**Return**

The number of key/value pair removed.


.. c:function:: void vvas_hash_table_remove_all (VvasHashTable* hash_table)

   Removes all key/value from the hash table

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

**Return**

None.


.. c:function:: void vvas_hash_table_unref (VvasHashTable* hash_table)

   Decrement the reference count by one.

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

**Context**

Decrement the reference count by one. 
Once the reference count drops to zero all the key/value 
will be destroyed.

**Return**

None.


.. c:function:: void vvas_hash_table_destroy (VvasHashTable* hash_table)

   Destroys all keys and values in hash table

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

**Context**

Destroys all keys and values in the VvasHashTable and decrements 
its reference count by 1. If keys and/or values are dynamically 
allocated, you should either free them first or create the 
VvasHashTable with destroy notifiers using 
vvas_hash_table_new_full(). In the latter case the destroy
functions you supplied will be called on all keys and values 
during the destruction phase.
 

**Return**

None.


.. c:function:: void vvas_hash_table_iter_init (VvasHashTable* hash_table, VvasHashTableIter *iter)

   Returns the iterator for hash table.

**Parameters**

``VvasHashTable* hash_table``
  Handle for VvasHashTable.

``VvasHashTableIter *iter``
  Handle for table iterator.

**Return**

None.


.. c:function:: bool vvas_hash_table_iter_next (VvasHashTableIter *iter, void **key, void **value)

   Allows to iterate through the table.

**Parameters**

``VvasHashTableIter *iter``
  Handle for VvasHashTableIter.

``void **key``
  Pointer to update.

``void **value``
  Pointer to update.

**Context**

Allows to iterate through the table and updates 
information in Key and values params passed.

**Return**

None.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

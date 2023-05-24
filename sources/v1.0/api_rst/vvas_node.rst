.. _VVAS Node APIs:

**VVAS Node APIs**

This file contains APIs for handling Node related operations.



.. c:struct:: _VvasTreeNode

   This structure is for creating Node instance.

**Definition**

::

  struct _VvasTreeNode {
    void* data;
    VvasTreeNode *next;
    VvasTreeNode *prev;
    VvasTreeNode *parent;
    VvasTreeNode *children;
  };

**Members**

``data``
  Handle for storing data.

``next``
  Handle for storing next node.

``prev``
  Handle for storing Previous node.

``parent``
  Handle for storing Parent node.

``children``
  Handle for storing children.





.. c:enum:: VvasTreeNodeTraverseType

   This enum is defines node traverse type.

**Constants**

``IN_ORDER``
  Visits a node's left child first, then the node itself, then its right child.

``PRE_ORDER``
  Visits a node, then its children.

``POST_ORDER``
  Visits a node's children, then the node itself.




.. c:enum:: VvasTreeNodeTraverseFlags

   This enum defines which nodes to be visited.

**Constants**

``TRAVERSE_LEAFS``
  Only leaf nodes should be visited. 

``TRAVERSE_NON_LEAFS``
  Only non-leaf nodes should be visited.

``TRAVERSE_ALL``
  All nodes should be visited.


.. c:function:: VvasTreeNode* vvas_treenode_new (void* data)

   Creates new tree node.

**Parameters**

``void* data``
  Address of data.

**Context**

This function creates new tree node.

**Return**

 * On Success returns node address.
 * On Failure returns NULL.


.. c:function:: void vvas_treenode_destroy (VvasTreeNode* node)

   Deallocates tree node.

**Parameters**

``VvasTreeNode* node``
  Address of node.

**Context**

This function deallocates node.

**Return**

None.


.. c:macro:: vvas_treenode_copy_func

   **Typedef**: Copy node data.


**Syntax**

  ``VOID_POINTER vvas_treenode_copy_func (const void* src, void* data)``

**Parameters**

``const void* src``
  Data to be copied.

``void* data``
  Additional data.

**Context**

This function is used to copy node data while performing deep-copy 
of a tree node.

**Return**

 * On Success returns address of the new node.
 * On Failure returns NULL. 


.. c:function:: VvasTreeNode* vvas_treenode_copy_deep (VvasTreeNode* node, vvas_treenode_copy_func func, void *data)

   Deep copies node.

**Parameters**

``VvasTreeNode* node``
  Address of source node to copy data from.

``vvas_treenode_copy_func func``
  Address of function which is called to copy data in each node.

``void *data``
  Additional data to be passed to func.

**Context**

This function recursively deep copies node data.

**Return**

 * On Success returns address of the new node which contain copies of data.
 * On Failure returns NULL. 


.. c:macro:: vvas_treenode_traverse_func

   **Typedef**: To traverse tree node.


**Syntax**

  ``bool vvas_treenode_traverse_func (const VvasTreeNode *Node, void *data)``

**Parameters**

``const VvasTreeNode *Node``
  Address of node.

``void *data``
  User data to be passed to the node.

**Context**

This function is passed for vvas_treenode_traverse and is called for  
each node visited, traverse can be halted by returning TRUE. 
  

**Return**

 * TRUE to stop the traverse.
 * FALSE to continue traverse.


.. c:function:: void vvas_treenode_traverse (VvasTreeNode *node, VvasTreeNodeTraverseType traverse_order, VvasTreeNodeTraverseFlags traverse_flags, int32_t max_depth, vvas_treenode_traverse_func func, void *data)

   Traverse a tree node.

**Parameters**

``VvasTreeNode *node``
  Node of the tree to start traversing.

``VvasTreeNodeTraverseType traverse_order``
  Order in which nodes are to be traversed in a tree.

``VvasTreeNodeTraverseFlags traverse_flags``
  Order in which children of nodes to be visited.

``int32_t max_depth``
  Maximum depth of traversal, if max_depth is -1 then all nodes in tree are visited.

``vvas_treenode_traverse_func func``
  Function to be called for each node visit. 

``void *data``
  User data to be passed to the function.

**Context**

This function used to traverse a tree starting at the given node.

**Return**

None.


.. c:function:: void vvas_treenode_append (VvasTreeNode *parent_node, VvasTreeNode *child_node)

   Inserts node from bottom.

**Parameters**

``VvasTreeNode *parent_node``
  Parent node.

``VvasTreeNode *child_node``
  child node.

**Context**

This function used to insert the node as the last child of the given parent node.

**Return**

None.


.. c:macro:: vvas_treenode_traverse_child_func

   **Typedef**: To Traverse child node func callback.


**Syntax**

  ``void vvas_treenode_traverse_child_func (VvasTreeNode *Node, void *data)``

**Parameters**

``VvasTreeNode *Node``
  Address of node.

``void *data``
  User data to be passed to the node.

**Context**

This function is passed for vvas_treenode_traverse_child, It is called with each child node 
together with the user data passed.

**Return**

None.


.. c:function:: void vvas_treenode_traverse_child (VvasTreeNode *node, VvasTreeNodeTraverseFlags traverse_flags, vvas_treenode_traverse_child_func func, void *data)

   Traverses child nodes.

**Parameters**

``VvasTreeNode *node``
  Parent node address.

``VvasTreeNodeTraverseFlags traverse_flags``
  Order in which children of nodes to be visited.

``vvas_treenode_traverse_child_func func``
  Function to be called for each child node visit. 

``void *data``
  User data to be passed to the function.

**Context**

Calls given function for each child node of the Parent node. It 
does not descend beneath the child nodes.

**Return**

None.


.. c:function:: uint32_t vvas_treenode_get_depth (VvasTreeNode *node)

   Gets the depth of the node.

**Parameters**

``VvasTreeNode *node``
  Address of the node for which depth to be found out. 

**Context**

This function used to get the depth of the node.        

**Return**

 * On Success returns depth of the given node.
 * On Failure returns 0, if node is null. The root node has 
   depth of 1, for children of the root node the depth is 
   2 and so on.


.. c:function:: uint32_t vvas_treenode_get_max_height (VvasTreeNode *node)

   Gets the max height of the node.

**Parameters**

``VvasTreeNode *node``
  Address of the node.

**Context**

This function used to get the maximum distance of the given node 
from all leaf nodes. 

**Return**

 * On Success returns max distance of the given node from all leaf node.
 * On Failure returns 0, if node is null.If node has no children, 1 
   is returned. If node has  children, 2 is returned.


.. c:function:: uint32_t vvas_treenode_get_n_childnodes (VvasTreeNode *root_node)

   Gets number of child nodes.

**Parameters**

``VvasTreeNode *root_node``
  Address of the parent node.

**Context**

This function used to get the number of child nodes of the given node.

**Return**

 * On Success returns number of child nodes of the parent node.
 * On Failure returns 0, if node is null.


.. c:function:: VvasTreeNode* vvas_treenode_insert_before (VvasTreeNode *parent, VvasTreeNode* sibling, VvasTreeNode* node)

   inserts before given node.

**Parameters**

``VvasTreeNode *parent``
  Address of the parent node.

``VvasTreeNode* sibling``
  Address of the sibling node.

``VvasTreeNode* node``
  Address of the  node to be inserted.

**Context**

This function will insert before the tree node.

**Return**

 * On Success returns number of child nodes of the parent node.
 * On Failure returns 0, if node is null.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

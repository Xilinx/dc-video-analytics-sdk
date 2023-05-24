.. _VVAS Infer Classification APIs:

**VVAS Infer Classification APIs**

This file contains data type and API declarations for Infer classification operations.



.. c:struct:: VvasColorInfo

   Contains information for color of the detected object

**Definition**

::

  struct VvasColorInfo {
    uint8_t red;
    uint8_t green;
    uint8_t blue;
    uint8_t alpha;
  };

**Members**

``red``
  R color component

``green``
  G color component

``blue``
  B color component

``alpha``
  Transparency





.. c:struct:: VvasInferClassification

   Contains information on classification for each object

**Definition**

::

  struct VvasInferClassification {
    uint64_t classification_id;
    int32_t class_id;
    double class_prob;
    char* class_label;
    int32_t num_classes;
    double* probabilities;
    char** labels;
    VvasColorInfo label_color;
  };

**Members**

``classification_id``
  A unique id associated to this classification

``class_id``
  The numerical id associated to the assigned class

``class_prob``
  The resulting probability of the assigned class. Typically ranges between 0 and 1

``class_label``
  The label associated to this class or NULL if not available

``num_classes``
  The total number of classes of the entire prediction

``probabilities``
  The entire array of probabilities of the prediction

``labels``
  The entire array of labels of the prediction. NULL if not available

``label_color``
  The color of labels



.. c:function:: VvasInferClassification * vvas_inferclassification_new (void)

   This function allocates new memory for **VvasInferClassification**

**Parameters**

``void``
  no arguments

**Return**



 * On Success returns address of the new object of **VvasInferClassification**.
 * On Failure returns NULL


.. c:function:: void vvas_inferclassification_free (VvasInferClassification *self)

   This function deallocates memory associated with VvasInferClassification object

**Parameters**

``VvasInferClassification *self``
  Address of the object handle to be freed

**Return**

none.


.. c:function:: VvasInferClassification* vvas_inferclassification_copy (const VvasInferClassification *self)

   This function creates a new copy of **VvasInferClassification** object

**Parameters**

``const VvasInferClassification *self``
  Address of context handle

**Return**

 * On Success returns address of the new object of **VvasInferClassification**.
 * On Failure returns NULL


.. c:function:: char * vvas_inferclassification_to_string (VvasInferClassification * self, int level)

   This function creates a string of classifications

**Parameters**

``VvasInferClassification * self``
  Address of **VvasInferenceClassification**

``int level``
  Level of inference prediction
  
  User has to free this memory

**Return**

Returns a string with all classifications serialized.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

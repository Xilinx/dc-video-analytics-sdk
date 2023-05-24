.. _VVAS Metaconvert APIs:

**VVAS Metaconvert APIs**

This file contains functions to covert different type of infer metadata to overlay metadata.



.. c:struct:: VvasRGBColor

   Holds RGB color values

**Definition**

::

  struct VvasRGBColor {
    uint8_t red;
    uint8_t green;
    uint8_t blue;
  };

**Members**

``red``
  Red component value

``green``
  Green component value

``blue``
  Blue component value





.. c:struct:: VvasFilterObjectInfo

   Information about objects to be filtered from a list

**Definition**

::

  struct VvasFilterObjectInfo {
    char name[META_CONVERT_MAX_STR_LENGTH];
    VvasRGBColor color;
    uint8_t do_mask;
  };

**Members**

``name``
  Name of object to be considered for processing by metaconvert

``color``
  Color components to be applied on the object

``do_mask``
  If set, masking will be done on this object





.. c:struct:: VvasMetaConvertConfig

   Configuration to be supplied by the user

**Definition**

::

  struct VvasMetaConvertConfig {
    VvasFontType font_type;
    float font_size;
    int32_t line_thickness;
    int32_t radius;
    uint8_t level;
    uint8_t mask_level;
    uint32_t y_offset;
    bool draw_above_bbox_flag;
    VvasRGBColor text_color;
    char **allowed_labels;
    uint32_t allowed_labels_count;
    VvasFilterObjectInfo **allowed_classes;
    uint32_t allowed_classes_count;
  };

**Members**

``font_type``
  Font type :c:type:`enum VvasFontType <VvasFontType>`

``font_size``
  Font size

``line_thickness``
  Line thickness while drawing rectangles or lines

``radius``
  Circle/point radius

``level``
  Prepare VvasOverlayShapeInfo from nodes present in specific level only.
  With level = 0, displays all nodes information

``mask_level``
  Apply masking at specific level

``y_offset``
  Y-axis offset while displaying text

``draw_above_bbox_flag``
  Flag to draw text above or inside bounding box.
  In case x and y position are zero draws inside frame left top corner

``text_color``
  Color values to be used to display text

``allowed_labels``
  List of labels from VvasInferPrediction to be considered while creating text.
  If allowed_labels is NULL, then all possible VvasInferPrediction labels are allowed

``allowed_labels_count``
  Count of the filter_labels array

``allowed_classes``
  Consider only specific classes and respective color while preparing :c:type:`struct VvasOverlayShapeInfo <VvasOverlayShapeInfo>`

``allowed_classes_count``
  Count of the **allowed_classes** array



.. c:function:: VvasMetaConvert * vvas_metaconvert_create (VvasContext *vvas_ctx, VvasMetaConvertConfig *cfg, VvasLogLevel log_level, VvasReturnType *ret)

   Creates VvasMetaConvert handle based on **cfg**

**Parameters**

``VvasContext *vvas_ctx``
  Handle to VVAS context

``VvasMetaConvertConfig *cfg``
  Handle to :c:type:`struct VvasMetaConvertConfig <VvasMetaConvertConfig>`

``VvasLogLevel log_level``
  Log level to be used to dump metaconvert logs

``VvasReturnType *ret``
  Address to store return value. In case of error, **ret** is useful in understanding the root cause

**Return**

Handle to VvasMetaConvert


.. c:function:: VvasReturnType vvas_metaconvert_prepare_overlay_metadata (VvasMetaConvert *meta_convert, VvasTreeNode *parent, VvasOverlayShapeInfo *shape_info)

   Converts Inference prediction tree to structure which can be understood by overlay module

**Parameters**

``VvasMetaConvert *meta_convert``
  Handle to VVAS Meta convert

``VvasTreeNode *parent``
  Handle to parent node of Inference prediction tree

``VvasOverlayShapeInfo *shape_info``
  Handle to overlay information which will be used overlay module to draw bounding box

**Return**

:c:type:`enum VvasReturnType <VvasReturnType>`


.. c:function:: void vvas_metaconvert_destroy (VvasMetaConvert *meta_convert)

   Destorys :c:type:`struct VvasMetaConvert <VvasMetaConvert>` handle

**Parameters**

``VvasMetaConvert *meta_convert``
  Handle to VVAS Meta convert

**Return**

None



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

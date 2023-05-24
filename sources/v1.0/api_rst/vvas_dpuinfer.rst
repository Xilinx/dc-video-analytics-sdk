.. _VVAS DPU Infer APIs:

**VVAS DPU Infer APIs**

This file contains structures and methods related to VVAS Inference.



.. c:struct:: VvasDpuInferConf

   Contains information related to model and configurable parameters

**Definition**

::

  struct VvasDpuInferConf {
    char * model_path;
    char * model_name;
    VvasVideoFormat model_format;
    char * modelclass;
    unsigned int batch_size;
    bool need_preprocess;
    bool performance_test;
    unsigned int objs_detection_max;
    char **filter_labels;
    int num_filter_labels;
    bool float_feature;
    VvasVideoFormat segoutfmt;
    int segoutfactor;
  };

**Members**

``model_path``
  Model path

``model_name``
  Model name

``model_format``
  Color format of the input image, like BGR, RGB etc., expected by the model

``modelclass``
  Model class

``batch_size``
  Batch size

``need_preprocess``
  If this is set to true, then software pre-processing will be performed using Vitis-AI library

``performance_test``
  Performance test

``objs_detection_max``
  Sort the detected objects based on area of the bounding box, from highest to lowest area.

``filter_labels``
  Array of labels to process

``num_filter_labels``
  Number of labels to process

``float_feature``
  Float feature

``segoutfmt``
  Segmentation output format

``segoutfactor``
  Multiplication factor for Y8 output to look bright





.. c:struct:: VvasModelConf

   Contains information related to model requirements

**Definition**

::

  struct VvasModelConf {
    int model_width;
    int model_height;
    unsigned int batch_size;
    float mean_r;
    float mean_g;
    float mean_b;
    float scale_r;
    float scale_g;
    float scale_b;
  };

**Members**

``model_width``
  Model required width

``model_height``
  Model required height

``batch_size``
  Model supported batch size

``mean_r``
  Mean value of R channel

``mean_g``
  Mean value of G channel

``mean_b``
  Mean value of B channel

``scale_r``
  Scale value of R channel

``scale_g``
  Scale value of G channel

``scale_b``
  Scale value of B channel





.. c:type:: VvasDpuInfer

   Holds the reference to dpu instance.


.. c:function:: VvasDpuInfer * vvas_dpuinfer_create (VvasDpuInferConf * dpu_conf, VvasLogLevel log_level)

   Initializes DPU with config parameters and allocates DpuInfer instance

**Parameters**

``VvasDpuInferConf * dpu_conf``
  VvasDpuInferConf structure.

``VvasLogLevel log_level``
  VvasLogLevel enum.
  
  This instance must be freed using **vvas_dpuinfer_destroy**.

**Return**



 * On Success returns VvasDpuInfer handle.
 * On Failure returns NULL.


.. c:function:: VvasReturnType vvas_dpuinfer_process_frames (VvasDpuInfer * dpu_handle, VvasVideoFrame *inputs[MAX_NUM_OBJECT], VvasInferPrediction *predictions[MAX_NUM_OBJECT], int batch_size)

   This API processes frames in a batch.

**Parameters**

``VvasDpuInfer * dpu_handle``
  VvasDpuInfer handle created using **vvas_dpuinfer_create**.

``VvasVideoFrame *inputs[MAX_NUM_OBJECT]``
  Array of **VvasVideoFrame**

``VvasInferPrediction *predictions[MAX_NUM_OBJECT]``
  Array of **VvasInferPrediction**. MAX_NUM_OBJECT is defined as 512.

``int batch_size``
  Batch size.
  
  This API returns VvasInferPrediction to each frame.
  It is user's responsibility to free the VvasInferPrediction of each frame.

**Return**

VvasReturnType


.. c:function:: VvasReturnType vvas_dpuinfer_destroy (VvasDpuInfer * dpu_handle)

   De-initialises the model and free all other resources allocated

**Parameters**

``VvasDpuInfer * dpu_handle``
  VvasDpuInfer handle created using **vvas_dpuinfer_create**.

**Return**

VvasReturnType


.. c:function:: VvasReturnType vvas_dpuinfer_get_config (VvasDpuInfer * dpu_handle, VvasModelConf *model_conf)

   Returns the VvasModelConf structure with all fields populated

**Parameters**

``VvasDpuInfer * dpu_handle``
  VvasDpuInfer handle created using **vvas_dpuinfer_create**.

``VvasModelConf *model_conf``
  VvasModelConf structure

**Return**

VvasReturnType



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

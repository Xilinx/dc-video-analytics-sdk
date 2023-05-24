.. _VVAS Post-processing APIs:

**VVAS Post-processing APIs**

This file contains structures and methods related to VVAS inference.



.. c:type:: VvasPostProcessor

   Holds the reference to post-processing instance.




.. c:struct:: VvasPostProcessConf

   Contains information related to post-processing library configurable parameters

**Definition**

::

  struct VvasPostProcessConf {
    char * model_path;
    char * model_name;
  };

**Members**

``model_path``
  Model path

``model_name``
  Model name



.. c:function:: VvasPostProcessor * vvas_postprocess_create (VvasPostProcessConf * postproc_conf, VvasLogLevel log_level)

   Upon success initializes post-processor instance with config parameters.

**Parameters**

``VvasPostProcessConf * postproc_conf``
  VvasPostProcessConf structure.

``VvasLogLevel log_level``
  VvasLogLevel enum.
  
  This instance must be freed using **vvas_postprocess_destroy**.

**Return**



 * On Success returns VvasPostProcessor handle.
 * On Failure returns NULL.


.. c:function:: VvasInferPrediction * vvas_postprocess_tensor (VvasPostProcessor * postproc_handle, VvasInferPrediction *src)


**Parameters**

``VvasPostProcessor * postproc_handle``
  post-processing handle created using **vvas_postprocess_create**.

``VvasInferPrediction *src``
  Pointer to VvasInferPrediction containing rawtensors.

**Return**

VvasInferPrediction tree with post-processed results


.. c:function:: VvasReturnType vvas_postprocess_destroy (VvasPostProcessor * postproc_handle)

   Free all resources allocated

**Parameters**

``VvasPostProcessor * postproc_handle``
  post-processing handle created using **vvas_postprocess_create**.

**Return**

VvasReturnType



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

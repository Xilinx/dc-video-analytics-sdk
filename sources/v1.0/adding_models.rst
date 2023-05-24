Supporting Deep Learning Models
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vitis AI Library classes natively supported by VVAS
###################################################

The VVAS inference plugin, ``vvas_xinfer`` is designed run inference with the models supported by Vitis AI Library. 

Currently ``vvas_xinfer`` supports most common Vitis AI Library model classes. These supported model classes are mapped to one of the ``enum VvasClass`` type in VVAS source  `vvas_dpucommon.h <https://github.com/Xilinx/vvas-core/blob/master/common/vvas_core/vvas_dpucommon.h>`_. 

Here is a current list of Vitis AI Library model classes and their corresponding ``enum VvasClass`` type. The models belong to these classes are natively supported by the ``vvas_xinfer`` plugin.  

.. list-table:: 
   :widths: 25 25 
   :header-rows: 1

   * - Library model class
     - VvasClass
   * - Classification
     - VVAS_XCLASS_CLASSIFICATION 
   * - Face Detection
     - VVAS_XCLASS_FACEDETECT
   * - Face Landmark Detection
     - VVAS_XCLASS_FACELANDMARK
   * - SSD Detection
     - VVAS_XCLASS_SSD
   * - SSD Detection (Tensorflow)
     - VVAS_XCLASS_TFSSD 
   * - Pose Detection
     - VVAS_XCLASS_POSEDETECT
   * - Semantic Segmentation
     - VVAS_XCLASS_SEGMENTATION
   * - Road Line Detection
     - VVAS_XCLASS_ROADLINE
   * - YOLOv3 Detection
     - VVAS_XCLASS_YOLOV3
   * - YOLOv2 Detection
     - VVAS_XCLASS_YOLOV2
   * - RefineDet Detection
     - VVAS_XCLASS_REFINEDET
   * - ReID Detection
     - VVAS_XCLASS_REID
   * - Face Recognition
     - VVAS_XCLASS_FACEFEATURE
   * - Plate Detection
     - VVAS_XCLASS_PLATEDETECT
   * - Plate Recognition
     - VVAS_XCLASS_PLATENUM
   * - Bayesian Crowd Counting
     - VVAS_XCLASS_BCC
   * - UltraFast Road Line Detection
     - VVAS_XCLASS_ULTRAFAST
   * - Vehicle Classification
     - VVAS_XCLASS_VEHICLECLASSIFICATION
   * - EfficientDet_D2
     - VVAS_XCLASS_EFFICIENTDETD2


V70 and VVAS Supported Model
############################


Currently all the V70 supported models from the Vitis AI Model Zoo are available in  `this link <https://www.xilinx.com/bin/public/openDownload?filename=xilinx_model_zoo_v70_patch.tar.gz>`_. These models are saved in their DPU deployable state, that means these models are already compiled and compiled model artifacts are saved in their respective model directory.  

The current release has been validated with the below models with VVAS on V70 platform 

.. list-table:: 
   :widths: 25 25 
   :header-rows: 1

   * - Model	
     - VVAS Model Class
   * - face_mask_detection_pt	
     - YOLOV3
   * - SemanticFPN_cityscapes_pt	
     - SEGMENTATION
   * - SemanticFPN_Mobilenetv2_pt	
     - SEGMENTATION
   * - semantic_seg_citys_tf2	
     - SEGMENTATION
   * - ssd_inception_v2_coco_tf	
     - TFSSD
   * - ssdlite_mobilenet_v2_coco_tf	
     - TFSSD
   * - ssd_mobilenet_v1_coco_tf	
     - TFSSD
   * - ssd_mobilenet_v2_coco_tf	
     - TFSSD
   * - ssd_resnet_50_fpn_coco_tf	
     - TFSSD  
   * - yolov3_coco_416_tf2	
     - YOLOV3
   * - YOLOV3_VOC	
     - YOLOV3
   * - efficientnet_lite_tf2	
     - CLASSIFICATION
   * - chen_color_resnet18_pt	
     - CLASSIFICATION
   * - vehicle_make_resnet18_pt	
     - VEHICLECLASSIFICATION
   * - vehicle_type_resnet18_pt	
     - VEHICLECLASSIFICATION


Integrating DL Models
#####################

There are few different ways to integrate these models in VVAS flow. 

1. Models natively supported by vvas_xinfer plugin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


The V70 supported models which are supported by one of the ``enum VvasClass`` (as shown in the above table) can be enabled in VVAS flow very easily.  

1. Download the compiled model directory  
2. Copy the model directory inside the VVAS docker container to the path ``/usr/share/vitis_ai_library/models/<model_name>`` 

   - Additionally for the object detection based models, create a ``label.json`` file and place it inside ``/usr/share/vitis_ai_library/models/<model_name>/`` directory.
3. Update ``infer-config`` configuration JSON file for ``vvas_xinfer`` plugin to specify the model attributes such as ``model-name``, ``model-class``, ``model-format``, etc.


2. Models not supported by vvas_xinfer plugin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The V70 supported models which are not supported by one of the ``enum VvasClass`` (as shown in the above table) can be enabled in VVAS flow in a couple of ways based on your preference. 
 
- Method 1: Add support of the model through Vitis AI Library. This requires the change in the VVAS codebase to use Vitis AI Library API. The advantage of this method is that the user can use higher level Vitis AI Library API which leverage post-processing by the Vitis AI Library directly.
- Method 2: Add support of the model without using Vitis AI Library rather through a special class ``RAWTENSOR``. The advantage of this method is that user can implement their own post-processing inside VVAS codebase. 

**Method 1: Adding model support through Vitis AI Library**


The VVAS Codebase requires the following changes to enable a model support through Vitis AI Library. 

1. Download the compiled model directory  

2. Copy the model directory inside the VVAS docker container in the path ``/usr/share/vitis_ai_library/models/<model_name>`` 

     - Additionally for the object detection based models, create a ``label.json`` file and place it inside ``/usr/share/vitis_ai_library/models/<model_name>/`` directory.

3. Create the new model class type in the file  `vvas_dpucommon.h <https://github.com/Xilinx/vvas-core/blob/master/common/vvas_core/vvas_dpucommon.h>`_. 

4. Create implementation files (.cpp and .hpp file) for the new class inside the directory ``vvas/vvas-core/dpuinfer``. You may refer to the existing model class implemetation files for the reference. 

For example the implementation code files for ``VVAS_XCLASS_SEGMENTATION`` class are:
  
- `vvas_segmentation.hpp <https://github.com/Xilinx/vvas-core/blob/master/dpuinfer/vvas_segmentation.hpp>`_
- `vvas_segmentation.cpp <https://github.com/Xilinx/vvas-core/blob/master/dpuinfer/vvas_segmentation.cpp>`_ 


5. Include the implemtation header file inside `vvas_dpuinfer.cpp <https://github.com/Xilinx/vvas-core/blob/master/dpuinfer/vvas_dpuinfer.cpp#L67>`_

For example, the implementation header file ``vvas_segmentation.hpp`` for ``VVAS_XCLASS_SEGMENTATION`` is included inside ``vvas_dpuinfer.cpp``

.. code-block:: c
  
    #ifdef ENABLE_SEGMENTATION
    #include "vvas_segmentation.hpp"
    #endif


6. Create the model inside `vvas_dpuinfer.cpp <https://github.com/Xilinx/vvas-core/blob/master/dpuinfer/vvas_dpuinfer.cpp#L478>`_

.. code-block:: c

    #ifdef ENABLE_SEGMENTATION
    case VVAS_XCLASS_SEGMENTATION:
    {
      model =
          new vvas_segmentation (kpriv, kpriv->elfname, kpriv->need_preprocess);
      break;
    }
    #endif


       
7. Update `vvas_dpumodels.hpp <https://github.com/Xilinx/vvas-core/blob/master/dpuinfer/vvas_dpumodels.hpp#L34>`_ 

.. code-block:: shell

    [VVAS_XCLASS_SEGMENTATION] = "SEGMENTATION",


8. Update `vvas-core/dpuinfer/meson.build <https://github.com/Xilinx/vvas-core/blob/master/dpuinfer/meson.build>`_  for the new class and corresponding Vitis AI library name 

Example with respect to the same  ``VVAS_XCLASS_SEGMENTATION`` class

.. code-block:: shell

   #ADD SEGMENTATION
   if get_option('SEGMENTATION') != '0'
     segmentation_dep = cc.find_library('vitis_ai_library-segmentation')
     dpuinfer_sources += [
         'vvas_segmentation.cpp',
     ]
   else
     segmentation_dep = []
   endif
 
   .....
   .....
   dependencies : [xrt_dep, core_common_dep,...., segmentation_dep,...],


9. Update top-level `meson.build <https://github.com/Xilinx/vvas-core/blob/master/meson.build>`_ file 

.. code-block:: shell

  if get_option('SEGMENTATION') != '0'
  add_project_arguments('-DENABLE_SEGMENTATION', language : 'c')
  add_project_arguments('-DENABLE_SEGMENTATION', language : 'cpp')
  endif

10. Update `meson_options.txt <https://github.com/Xilinx/vvas-core/blob/master/meson_options.txt>`_ file 

.. code-block:: shell

  option('SEGMENTATION', type: 'string', value: '1',
       description: 'Enable disable SEGMENTATION models')



11. In case the new model results are not supported by the existing fields in the VVAS Inference Metadata structure, then it is required to add support of the new inference metadata inside the ``struct VvasInferPrediction`` which is defined inside `vvas_infer_prediction.h <https://github.com/Xilinx/vvas-core/blob/master/common/vvas_core/vvas_infer_prediction.h>`_. 


**Method 2: Adding model support through the ``RAWTENSOR`` class**


The unsupported model can also be supported through a special class ``RAWTENSOR``. This ``RAWTENSOR`` class in registered inside ``enum VvasClass`` as ``VVAS_XCLASS_RAWTENSOR``. 

1. Download the compiled model directory  
2. Copy the model directory inside the VVAS docker container in the path ``/usr/share/vitis_ai_library/models/<model_name>`` 

     - Additionally for the object detection based models, create a ``label.json`` file and place it inside ``/usr/share/vitis_ai_library/models/<model_name>/`` directory.
3. The ``infer-json`` file as below has to be modified by changing the ``model-class`` to ``RAWTENSOR``. Also, as in this case ``vvas_xinfer`` works on the raw tensor instead of through VAI library, the post-processing inference result is not available directly. Hence it may require to perform proper post-processing after the inference inside the VVAS code base. 

Note the changes inside the ``infer-config`` JSON file below

.. code-block:: json

       {
          "inference-level": 1,
          "attach-ppe-outbuf": false,
          "kernel" : {
             "config": {
                "batch-size":14,
                "model-name" : "yolov3_voc_tf",
                "model-class" : "RAWTENSOR",
                "model-format" : "BGR",
                "model-path" : "/usr/share/vitis_ai_library/models/",
                "postprocess-lib-path" : "/opt/xilinx/vvas/lib/libvvascore_postprocessor.so",
                "postprocess-function" : "vvas_postprocess_tensor",
                "performance-test" : false,
                "vitis-ai-preprocess":false,
                "debug-level" : 0,
                "max-objects":3,
                "filter-labels":["car"]
             }
          }
       }



The special configurations in the above ``infer-config`` JSON file

   1. The ``model-class`` specified to ``RAWTENSOR``
   2. The ``postprocess-lib-path`` is specified to a sample VVAS post-processing library ``libvvascore_postprocessor.so``. 
   3. The ``postprocess-function`` is specified to post-processing function ``vvas_postprocess_tensor``
   
.. note::

        The post-processing library shown above ``libvvascore_postprocessor.so`` should only be used as a reference, as it does not support post-processing requirements for all the different types of models. 
        


..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

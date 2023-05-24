.. _faq.rst:

###
FAQ
###

**1. Is VVAS open source?**
 
Answer: Yes.

**2. What platforms and OS are compatible with VVAS?**

Answer: VVAS is tested on PetaLinux for embedded platforms and Ubuntu 20.04 for PCIe based platforms. For more information about supported platforms, refer to :doc:`system_requirements`.

**3. Which Vitis AI classes are supported with VVAS SDK?**

Answer: Below classes are supported.
 
    * YOLOV3
    * FACEDETECT
    * CLASSIFICATION
    * SSD
    * REFINEDET
    * TFSSD
    * YOLOV2
    * VEHICLECLASSIFICATION
    * REID
    * SEGMENTATION
    * PLATEDETECT
    * PLATENUM
    * POSEDETECT
    * BCC
    * EFFICIENTDETD2
    * FACEFEATURE
    * FACELANDMARK
    * ROADLINE
    * ULTRAFAST
    * RAWTENSOR
    
For more information refer to :doc:`adding_models`

**4. How do I enable models that are not officially supported?**

Answer: Refer to How to the page :doc:`adding_models`

**5. Does VVAS compatible with lower versions of Vitis AI tools, such as Vitis-AI v2.5?**

Answer: No, it has dependencies on Vitis AI 3.0.

**6. How can I change the model in the pipeline?**

Answer: The model name to be used for inference has to be provided in the JSON file for vvas_xinfer plug-in. For more details, see vvas_xinfer.

**7. Can the model be changed dynamically?**

Answer: while a pipeline is running, the model parameters cannot be modified. To change the model’s parameters, stop the running pipeline, and then update the JSON file and then re-start the pipeline.

**8. What types of input streams does current VVAS SDK support?**

Answer: 

   - H.264, H.265 encoded video streams
   - Raw video frames in NV12, BGR/RGB formats

**9. Whether VVAS SDK supports input of RTSP streaming?**

Answer: Receiving RTSP stream is supported by an open source plugin.

**10. How do I develop software acceleration libraries?**

Answer: Refer to Acceleration :doc:`common/Acceleration-Software-Library-Development`

**11. How to debug VVAS application if there are any issues?**

Answer: Refer to the :doc:`debugging`

**12. How do I compile and prune the model to be used?**

Answer: Refer to Vitis AI 3.0 documentation.

**12. How can we communicate issues while using VVAS SDK ?**

Answer: Please visit technical support page https://support.xilinx.com/s/article/How-do-I-get-support-for-Xilinx-technical-issues?language=en_US

**13. What if I cannot find the information that i am looking for?**

Answer: Contact vvas_discuss@amd.com.

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

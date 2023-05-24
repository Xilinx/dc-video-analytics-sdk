################################################
Vitis Video Analytics SDK (VVAS) for Data Center 
################################################

The Vitis Video Analytics SDK for Data Center (also known as VVAS for Data Center) is a complete software toolkit providing a fast and easy way to develop AI-powered video analytics applications targeting AMD platforms such as the Alveo™ V70 accelerator card. It is an ideal choice for applications such as traffic analysis and pedestrians recognition in smart cities, health and safety monitoring in hospitals, self-checkout, retail analytics, defect detection, and many others.

With the Vitis Video Analytics SDK for Data Center, developers can use GStreamer or C APIs to create streaming pipelines integrating neural networks trained in TensorFlow or PyTorch and compiled with the Vitis™ AI development platform.

.. image:: images/vvas_landing.PNG

The Vitis Video Analytics SDK provides GStreamer plug-ins and C APIs to very easily interact with optimized hardware accelerators for tasks such as video decoding, resizing, color space conversion, and AI inferencing. 

By performing all the compute-heavy operations of the streaming pipeline in optimized hardware accelerators, the Vitis Video Analytics SDK delivers best-in-class performance for video analytics applications.


*****************
Table of Contents
*****************

Getting Started
===============

* **System & Hardware Requirements**: Refer to :doc:`system_requirements` page to ensure your host system compatibility to use current VVAS Data Center solution. 

* **Installation Guide**: Refer to :doc:`installation` to follow step-by-step directions to install device, runtime, and VVAS related packages.   

* **Quickstart tutorial**: Refer to :doc:`getting_started_tutorial` page to learn the core VVAS GStreamer plug-ins and their usability to built video analytics pipeline. 

* **Features and Capabilities**: V70 Versal ACAP offers best-in-class hardware for efficient video analytic task. To know the details spec, features of VDU, ABR Scaler, AI engine processor and its supported models (for deep learning inference) please refer :doc:`features_and_capabilities` page.


VVAS GStreamer Interface
========================

* **GStreamer Plug-ins**: For complete refernce of VVAS GStreamer plugins, their parameters, capabiltiies refer :doc:`./common/gstreamer_plugins/common_plugins` page. 

* **VVAS Meta Data Structures**: Refer to the :doc:`./common/meta_data/vvas_meta_data_structures` page to understand various GStreamer metadata structures defined by VVAS infrastructure. 


VVAS Core API
=============
 
* **VVAS C API Reference**: For VVAS C API Reference manual, refer :doc:`api_reference` page.  

* **VVAS C API Guide**: For VVAS C API general usage guideline for application development, refer :doc:`api_guide` page. 

* **VVAS C API Samples**: For VVAS C API based sample applications refer :doc:`api_examples` page. 


Additional Information
======================

* **Building and Installing from the VVAS source**: To download, build and install from the VVAS source code for your specific development, refer :doc:`vvas_build`

* **Supporting Deep Learning Models**: To understand the current model support and bring different deep learning models, refer :doc:`adding_models`   

* **Device Management & Utility tools**: To know how to use device specific management and utiliy tools refer :doc:`card_management` page. 

* **Debugging**: Refer to the :doc:`debugging` page for some debugging tips when using VVAS. 

* **FAQ**: Refer to the :doc:`faq` page for frequently asked questions and answers.



.. toctree::
   :maxdepth: 1
   :caption: Getting Started
   :hidden:

   system_requirements.rst
   installation.rst
   getting_started_tutorial.rst
   features_and_capabilities.rst


.. toctree::
   :maxdepth: 1
   :caption: VVAS GStreamer Interface
   :hidden:

   ./common/gstreamer_plugins/common_plugins.rst
   ./common/meta_data/vvas_meta_data_structures.rst
   ./common/for_developers.rst

.. toctree::
   :maxdepth: 1
   :caption: VVAS Core API
   :hidden:

   api_reference.rst
   api_guide.rst
   api_examples.rst

 
.. toctree::
   :maxdepth: 1
   :caption: Additional Information
   :hidden:

   vvas_build.rst
   adding_models.rst
   card_management.rst
   debugging.rst
   faq.rst
   
..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

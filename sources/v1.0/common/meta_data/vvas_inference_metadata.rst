..
   Copyright 2021 Xilinx, Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.


.. _vvas_inference_metadata:


#########################
VVAS Inference Metadata
#########################

The ``GstInferenceMeta`` object, also known as the VVAS inference metadata, serves as a repository for information related to metadata produced by software libraries that accelerate machine learning (ML) inference. It collects data generated from various levels of ML operations and organizes them hierarchically within a single tree structure. Essentially, this data structure consolidates and stores metadata from detection and classification models.

The GStreamer plug-ins can set and get inference metadata from the GstBuffer by using the `gst_buffer_add_meta ()` API and `gst_buffer_get_meta ()` API, respectively.

.. toctree::
   :maxdepth: 1

   GStreamer Inference Metadata <./vvas_gstinference_metadata>

.. toctree::
   :maxdepth: 1

   VVAS Core Inference Metadata <./vvas_core_inference_metadata>

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

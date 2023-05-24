.. _api_examples.rst:

##################
VVAS C API Samples
##################

The VVAS release package contains two sample application code demonstrating the usage of the VVAS Core APIs. 

- Single Stream Car Classification Pipeline Sample Application
- Multiple Streams Car Classification Pipeline Sample Application

.. note::

    These sample applications are merely used to help you to understand the VVAS Core APIs functionalities and how they can be used in code. For that purpose, the implementations such as control flow and data structures used in these applications are just for the sake of API usage demonstration, and not intended to demonstrate an ideal optimized implementation. You, as an application developer, can use your desired control-flow/data structure implementation to use the VVAS Core APIs based on your application requirements. 

Sample Video Preparation
************************

To run the sample application you need a sample video of moving cars. 
    
- Download this free video from https://pixabay.com/videos/traffic-cars-road-street-56696/  in 1920x1080 format. 
- Convert the mp4 video file to h264 file using the below command 

.. code-block:: shell

   gst-launch-1.0 -v filesrc location=/workspace/traffic-56696.mp4 ! \ 
                     qtdemux ! h264parse ! video/x-h264,stream-format=byte-stream ! \
                     filesink location=/workspace/Test.h264


Single Stream Car Classification Pipeline Sample Application
************************************************************

**Sample application code path**: 

The sample application code is present in the `file test_cascade_yolov3_3xresnet.cpp at VVAS github repo. <https://github.com/Xilinx/vvas-core/blob/master/test/app/test_cascade_yolov3_3xresnet.cpp>`_

**Running the application**

The application code is already compiled inside the docker environment. To run the application you can use the following command: 

.. code-block:: shell

   test_video_ml -i /workspace/Test.h264 \
                 -j /opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/cascade_yolov3_3xresnet18.json \
                 -x /opt/xilinx/xclbin/v70.xclbin \
                 -d 0 \
                 -n "kernel_vdu_decoder:{kernel_vdu_decoder_0}"


**Standalone compilation of the sample application**

To compile this sample application standalone you can use the following Makefile (``make app``)

.. code-block:: makefile

   APP =  test_video_ml
   APP_SOURCE_FILES  = test_cascade_yolov3_3xresnet.cpp

   XRT_PKG_CFG=`pkg-config --cflags --libs xrt`
   VVAS_UTILS_PKG_CFG=`pkg-config --cflags --libs vvas-utils`
   VVAS_CORE_PKG_CFG=`pkg-config --cflags --libs vvas-core`
   VVAS_CORE_MACROS=-DVVAS_GLIB_UTILS -DXLNX_PCIe_PLATFORM -DXLNX_V70_PLATFORM

   ${APP}: ${APP_SOURCE_FILES}
        g++ -Wall -g $(APP_SOURCE_FILES) $(XRT_PKG_CFG) $(VVAS_UTILS_PKG_CFG) $(VVAS_CORE_PKG_CFG) $(VVAS_CORE_MACROS) -o $(APP)

   app: 
        make ${APP}

   clean:
        rm ${APP}
        


Multiple Streams Car Classification Pipeline Sample Application
***************************************************************

**Sample application code path**: 

The sample application code is present in the `file test_cascade_yolov3_3xresnet_mt.cpp at VVAS github repo. <https://github.com/Xilinx/vvas-core/blob/master/test/app/test_cascade_yolov3_3xresnet_mt.cpp>`_


**Running the application**: The application code is already compiled inside the docker environment. To run the application you can use the following command: 

Before running the application update the ``/opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/cascade_yolov3_3xresnet18.json`` with the path of downloaded sample video files. We will take 16 input streams with the same video. 

.. code-block:: 

   "input-streams":[
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264",
                    "/workspace/Test.h264"
                 ]


Run the application using the following command:

.. code-block:: bash

   test_video_ml_mt -j /opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/cascade_yolov3_3xresnet18.json
   
**Standalone compilation of the sample application**

To compile this sample application standalone you can use the following Makefile (``make app``)

.. code-block:: makefile

    APP =  test_video_ml_mt
    APP_SOURCE_FILES  = test_cascade_yolov3_3xresnet_mt.cpp

    XRT_PKG_CFG=`pkg-config --cflags --libs xrt`
    VVAS_UTILS_PKG_CFG=`pkg-config --cflags --libs vvas-utils`
    VVAS_CORE_PKG_CFG=`pkg-config --cflags --libs vvas-core`
    VVAS_CORE_MACROS=-DVVAS_GLIB_UTILS -DXLNX_PCIe_PLATFORM -DXLNX_V70_PLATFORM

    ${APP}: ${APP_SOURCE_FILES}
           g++ -Wall -g $(APP_SOURCE_FILES) $(XRT_PKG_CFG) $(VVAS_UTILS_PKG_CFG) $(VVAS_CORE_PKG_CFG) $(VVAS_CORE_MACROS) -o $(APP) -pthread -lvvascore_pool-1.0

    app: 
           make ${APP}

    clean:
           rm ${APP}


**Description of the sample application**

This sample application constructs a car classification pipeline for 16 streams, where 4 streams are fed to each funnel. This application will show car classification data in Car Color, Make and Type order.

Application displays performance in frames per second (FPS) like the GStreamer pipeline.

Below is a sample FPS log.

.. code-block:: shell

   0:00:34.009185754 [Sink_2.0] rendered: 162, current FPS: 16.79, average FPS: 16.79
   0:00:34.009219157 [Sink_2.1] rendered: 144, current FPS: 16.32, average FPS: 16.32
   0:00:34.009236560 [Sink_2.2] rendered: 158, current FPS: 16.37, average FPS: 16.37
   0:00:34.009247114 [Sink_2.3] rendered: 152, current FPS: 15.89, average FPS: 15.89
   0:00:34.021963566 [Sink_3.0] rendered: 158, current FPS: 16.49, average FPS: 16.49
   0:00:34.022015281 [Sink_3.1] rendered: 166, current FPS: 17.21, average FPS: 17.21
   0:00:34.022030713 [Sink_3.2] rendered: 147, current FPS: 15.55, average FPS: 15.55
   0:00:34.022044064 [Sink_3.3] rendered: 146, current FPS: 15.44, average FPS: 15.44
   0:00:34.000343033 [Sink_0.0] rendered: 154, current FPS: 16.22, average FPS: 16.22
   0:00:34.000447190 [Sink_0.1] rendered: 144, current FPS: 16.08, average FPS: 16.08
   0:00:34.000478190 [Sink_0.2] rendered: 165, current FPS: 17.13, average FPS: 17.13
   0:00:34.000499755 [Sink_0.3] rendered: 162, current FPS: 16.82, average FPS: 16.82


Considering the last line of the above log, 
 
- ``0:00:34.000499755`` : This number shows the relative time since the application is started
- ``Sink_0.3``: Shows the sink number. The first number (``0``) shows the funnel number and 2nd number (``3``) shows the sink in that funnel.

Unlike GStreamer pipeline, this application does not have limitation that all streams should have same caps. Users can have streams with different resolution, framerate, and different video codec format as well.

This sample application supports following video file name extensions

- For H.264: ``.h264``, ``.264``, ``.avc`` 
- For H.265: ``.h265``, ``.265``, ``.hevc``

The input argument ``cascade_yolov3_3xresnet18.json`` is the master json file, it has all the configuration needed to run this application. The JSON file content is as below

.. code-block::

   {
   "yolov3-config-path":"/opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/yolov3_voc_tf.json",
   "resnet18-carmake-config-path":"/opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/resnet18_vehicle_make.json",
   "resnet18-cartype-config-path":"/opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/resnet18_vehicle_type.json",
   "resnet18-carcolor-config-path":"/opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/resnet18_vehicle_color.json",
   "metaconvert-config-path":"/opt/xilinx/vvas/share/cascade_yolov3_3xresnet18/metaconvert_config.json",
   "xclbin-location":"/opt/xilinx/xclbin/v70.xclbin",
   "dev-idx" : 0,
   "additional-decoder-buffers": 14,
   "batch-timeout": 400,
   "fps-display-interval": 5,
   "repeat-count":1,
   "sink-type":0,
   "log-level":0,
   "input-streams":[
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264",
      "/workspace/Test.h264"
   ]
   }


Parameters in the master JSON file passed to the sample application

- ``yolov3-config-path``: Yolov3 inference configuration file.
- ``resnet18-carmake-config-path``: Car Make inference configuration file.
- ``resnet18-cartype-config-path``: Car Type inference configuration file.
- ``resnet18-carcolor-config-path``: Car Color inference configuration file.
- ``metaconvert-config-path``: Meta convert configuration file.
- ``xclbin-location``: XCLBIN location.
- ``dev-idx``: Device index
- ``additional-decoder-buffers``: Additional decoder output buffers to allocate to run pipeline efficiently. Refer section Calculating Decoder output buffers for more details. The default value in the JSON is calculated for playing 4 streams in one funnel.
- ``batch-timeout``: Maximum time (in milliseconds) to wait for inference batch to be formed before submitting the batch for inference. The default value is calculated based on batch size of 14 and 30 FPS video.
- ``repeat-count``: Number of times each stream should be repeated.
- ``fps-display-interval``: FPS display interval in seconds (Minimum 1 sec), Default 5 seconds
- ``sink-type``: Sink type, 0 - Fake sink, 1 – File sink
- ``log-level``: Logging level 0 -3 (0 – Error, 1 – Warning, 2 – Info, 3 – Debug)
- ``input-streams``: An array of input streams. Update default strings in above configuration file with the available H264/H265 files.

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

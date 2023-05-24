.. _vvas_xmetaconvert:

vvas_xmetaconvert
=================

The ``vvas_xmetaconvert`` plug-in is used to convert VVAS ML inference metadata, which is attached to an input buffer, into overlay metadata, ``GstVvasOverlayMeta`` that is needed by the ``vvas_xoverlay`` plug-in.

The ``vvas_xmetaconvert`` plug-in requires some static configuration parameters, such as font type and size, which are provided in the configuration file in JSON format. **config-location** property allows you to specify the location of the configuration file that contains the necessary parameters.

By using these two plug-ins together, you can create an overlay, like bounding box, text etc., on a video frame/image that displays ML inference results in real-time. For implementation details, refer to `vvas_xmetaconvert source code <https://github.com/Xilinx/VVAS/tree/master/vvas-gst-plugins/gst/metaconvert>`_

Input and Output
--------------------

This plug-in is format agnostic and can accept any input format as it operates only on metadata attached to input buffer and same will be pushed out of source pad after attaching overlay metadata.

Control Parameters and Plug-in Properties
------------------------------------------------

The following table lists the GStreamer plug-in properties supported by the vvas_xmetaconvert plug-in.

Table 1: vvas_xmetaconvert Plug-in Properties

+--------------------+-------------+---------------+------------------------+----------------------------------------------------------------+
|                    |             |               |                        |                                                                |
|  **Property Name** |   **Type**  | **Range**     | **Default**            | **Description**                                                |
|                    |             |               |                        |                                                                |
+====================+=============+===============+========================+================================================================+
| config-location    | String      | NA            | NULL                   | Location of the metaconvert configuration in JSON format which |
|                    |             |               |                        | will be used to convert inference metadata to overlay metadata |
+--------------------+-------------+---------------+------------------------+----------------------------------------------------------------+


JSON File format to be provided as input to **config-location** property
-----------------------------------------------------------------------------

This section describes the JSON file format and configuration parameters for the vvas_xmetaconvert plug-in. 

The following example is of a JSON file to pass to the vvas_xmetaconvert using **config-location** property.

.. code-block::

      {
        "config": {
          "display-level": 0,
          "font-size" : 0.5,
          "font" : 3,
          "thickness" : 2,
          "radius": 5,
          "mask-level" : 0,
          "y-offset" : 0,
          "label-filter" : [ "class", "probability" ],
          "classes" : [
            {
              "name" : "car",
              "blue" : 255,
              "green" : 0,
              "red"  : 0,
              "masking"  : 0
            },
            {
              "name" : "person",
              "blue" : 0,
              "green" : 255,
              "red"  : 0,
              "masking"  : 0
            },
            {
              "name" : "bus",
              "blue" : 0,
              "green" : 0,
              "red"  : 255,
              "masking"  : 0
            },
            {
              "name" : "bicycle",
              "blue" : 0,
              "green" : 0,
              "red"  : 255,
              "masking"  : 0
            }
          ]
        }
      }


Various configuration parameters passed to vvas_xmetaconvert via json file are described in the following table.

Table 2: vvas_xmetaconvert Parameters

+----------------------+----------------------+-----------------------------------------------------------------+
|    **Parameter**     | **Expected Values**  |    **Description**                                              |
|                      |                      |                                                                 |
+======================+======================+=================================================================+
| font                 |    0 to 7            |Below is the list of text font values and its description.       |
|                      |                      | - 0: Hershey Simplex (default)                                  |
|                      |                      | - 1: Hershey Plain                                              |
|                      |                      | - 2: Hershey Duplex                                             |
|                      |                      | - 3: Hershey Complex                                            |
|                      |                      | - 4: Hershey Triplex                                            |
|                      |                      | - 5: Hershey Complex Small                                      |
|                      |                      | - 6: Hershey Script Simplex                                     |
|                      |                      | - 7: Hershey Script Complex                                     |
+----------------------+----------------------+-----------------------------------------------------------------+
| font-size            |    0.5 to 1          |Font fraction scale factor that is multiplied by the             |
|                      |                      |font-specific base size. Default value is 0.5                    |
+----------------------+----------------------+-----------------------------------------------------------------+
| thickness            |    Integer 1 to 3    |The thickness of the line that makes up the rectangle. Negative  |
|                      |                      |values like -1, signify that the function draws a filled         |
|                      |                      |rectangle. The recommended value is between 1 and 3.             |
|                      |                      |Default line thickness value is 1.                               |
+----------------------+----------------------+-----------------------------------------------------------------+
| mask-level           |    Integer           |In case of cascaded ML pipeline, user can use this field to mask |
|                      |                      |out the results of a particular level in inference results tree. |
|                      |                      |All bounding boxes in that level will be masked with black color.|
|                      |                      |                                                                 |
|                      |                      |When set to 0(default), none of the levels are masked.           |
+----------------------+----------------------+-----------------------------------------------------------------+
| label-filter         |["class",             |This field controls what should be displayed in label string.    |
|                      |"probability",        |The addition of "class" in the array adds the ML classification  |
|                      |"tracker-id"]         |name. For example, car, person, etc.                             |
|                      |                      |                                                                 |
|                      |                      |The addition of "probability" in the array adds the probability  |
|                      |                      |of a positive object identification.                             |
|                      |                      |                                                                 |
|                      |                      |The addition of "tracker-id"  in the array adds unique id for    |
|                      |                      |for each object generated by vvas_xtracker plugin                |
+----------------------+----------------------+-----------------------------------------------------------------+
| y-offset             |Integer 0 to height   |'y' offset to be  added along height for label in case of        |
|                      |                      |classification model                                             |
+----------------------+----------------------+-----------------------------------------------------------------+
| classes              |{"name":"car",        |This is a filtering option when using the vvas_xoverlay. The     |
|                      |"blue":255,           |bounding box is only drawn for the classes that are listed in    |
|                      |"green":0,            |this configuration and other classes are ignored. For instance,  |
|                      |"red" : 0,            |if "car", "person", "bicycle" is entered under "classes", then   |
|                      |"masking" : 0}        |the bounding box is only drawn for these three classes, and other|
|                      |                      |classes like horse, motorbike, etc. are ignored.                 |
|                      |                      |                                                                 |
|                      |                      |The expected value columns show an example of how each class     |
|                      |                      |should be described. All objects in this example, by class, are  |
|                      |                      |using the color combination listed.                              |
|                      |                      |                                                                 |
|                      |                      |The class names in this list matches the class names assigned    |
|                      |                      |by the vvas_xdpuinfer. Otherwise, the bounding box is not drawn. |
|                      |                      |                                                                 |
|                      |                      |"masking" flag can be used to mask all objects of a class Set    |
|                      |                      |it to 1 for enabling masking. This flag will override            |
|                      |                      |"mask_level" field.                                              |
|                      |                      |                                                                 |
|                      |                      |For instance, if "mask_level" is set 1 and "masking" for "car"   |
|                      |                      |is set 1 and if level 1 has cars and busses, then only cars are  |
|                      |                      |masked not the entire level.                                     |
|                      |                      |For face detect, keep the "classes" array empty.                 |
+----------------------+----------------------+-----------------------------------------------------------------+
| display-level        | | Integer 0 to N     |Display bounding box of one particular level or all levels       |
|                      | | 0 => all levels    |                                                                 |
|                      | | N => specific level|                                                                 |
+----------------------+----------------------+-----------------------------------------------------------------+
| draw_above_bbox_flag | True/False           |Label will be displayed on top of the bounding box if set to     |
|                      |                      |True. Default value is True                                      |
+----------------------+----------------------+-----------------------------------------------------------------+
| radius               |  Integer             |Represents Radius of circle, also used for point. Default value  |
|                      |                      |is 3                                                             |
+----------------------+----------------------+-----------------------------------------------------------------+

Example Pipelines
---------------------

The following example demonstrates use of vvas_xmetaconvert with :ref:`vvas_xoverlay` plug-in for drawing bounding boxes.
 
.. code-block::

    gst-launch-1.0 filesrc location="<PATH>/001.bgr" blocksize=150528 numbuffers=1
    ! videoparse width=224 height=224 framerate=30/1 format=16
    ! vvas_xinfer infer-config="<PATH>/kernel_resnet50.json"
    ! vvas_xmetaconvert config-location="<PATH>/metaconvert.json"
    ! vvas_xoverlay ! filesink location=output.bgr

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

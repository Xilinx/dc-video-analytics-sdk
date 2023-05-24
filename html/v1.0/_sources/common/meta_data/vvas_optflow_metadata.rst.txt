.. _vvas_optflow_metadata:

*************************
VVAS Opticalflow Metadata
*************************

VVAS optical flow metadata structure hold the information of motion of frame in x and y direction and object motion information. VVAS optical flow plugin set the optical flow meta data of frame. This metadata structure also supports storing of motion information in object level for further analysis by downstream plugins.  The GStreamer plug-ins can set and get optical flow metadata from the GstBuffer by using the gst_buffer_add_meta () API and gst_buffer_get_meta () API respectively.

================
 GstOptflowMeta
================

GstOptflowMeta stores the information of optical flow of frames and object motion information.

.. code-block::


      struct _vvas_obj_motinfo
      {
        float mean_x_displ;
        float mean_y_displ;
        float angle;
        float dist;
        char dirc_name[DIR_NAME_SZ];
        BoundingBox bbox;
      };


      /**
      * GstVvasOverlayMeta:
      * @num_objs: number of objects with motion information
      * @obj_mot_infos: list of objects
      * @x_displ: pointer to motion data of frame in x-direction
      * @y_displ: pointer to motion data of frame in y-directiont
      */
      struct _GstVvasOFMeta
      {
        GstMeta meta;

        guint num_objs;
        GList *obj_mot_infos;

        GstBuffer *x_displ;
        GstBuffer *y_displ;

      };


..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

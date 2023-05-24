.. _vvas_xmulticrop:

vvas_xmulticrop
================

In machine learning applications, it is common to extract specific objects or regions from images or video frames for processing, and the number of objects to be cropped in each frame may vary. Preprocessing may also be required for the cropped object to be suitable for machine learning algorithms. The ``vvas_xmulticrop`` plugin is capable of resizing, color space conversion, preprocessing, and cropping one or multiple objects from a single input frame.

The vvas_xmulticrop plugin supports two types of cropping Static cropping and Dynamic cropping. In static cropping, the user specifies a fixed region in the frame to be cropped via gstreamer properties, and the cropped buffer is pushed as an output buffer(main buffer) onto the source pad of the plugin. In dynamic cropping, multiple objects or regions are cropped from a frame, and the cropped objects or buffers are attached as metadata to the output buffer pushed onto the source pad. The regions to be dynamically cropped are specified as part of the metadata attached to the input buffer. Both static and dynamic cropping can be used together.

In summary, video frames often need to be cropped in machine learning applications to process objects, and the number of objects to be cropped may vary. Preprocessing may also be required. The vvas_xmulticrop plugin is capable of performing resizing, color space conversion, preprocessing, and both static and dynamic cropping to streamline the workflow for machine learning developers. For more implementation details, refer to `vvas_xmulticrop source code <https://github.com/Xilinx/VVAS/tree/master/vvas-gst-plugins/sys/multicrop>`_.

This plug-in supports:

* Single sink pad, single source pad

* Color space conversion

* Resize

* Pre-processing

* Static and Dynamic cropping

vvas_xmulticrop plug-in is similar to ``vvas_xabrscaler`` excepts below features:

* It has only one source pad

* It supports dynamic cropping.


Static Cropping
----------------

Static cropping can be used for cropping only one object. The cropped object/buffer is sent onto the source pad. `s-crop-x`, `s-crop-y`, `s-crop-width`, `s-crop-height` are the plug-in properties to set the static crop parameters.


Dynamic Cropping
-----------------

Dynamic cropping is for cropping multiple objects from the input frame. Dynamic crop coordinates must be attached to the input frame as GstVideoRegionOfInterestMeta metadata, and GstVideoRegionOfInterestMeta->roi_type must be set to "roi-crop-meta". It's important to note that each instance of GstVideoRegionOfInterestMeta in the buffer represents a single object for dynamic crop.

``vvas_xmulticrop`` plugin dynamically crops the object and attaches the cropped objects/buffers to the output buffer in GstVideoRegionOfInterestMeta->params. GstVideoRegionOfInterestMeta->params is a GList* of GstStructure. The dynamically cropped buffer is attached to this field, with the name of the GstStructure as "roi-buffer". This GstStructure has only one field "sub-buffer", which is of type GST_TYPE_BUFFER. The user must extract this cropped buffer, use it, and then unref it.

User can choose to resize these cropped buffers to some width and height by setting **d-height** and **d-width** properties. If these properties are not set, then cropped buffers will not be resized.

User can also decide the format of dynamically cropped buffers by setting **d-format** GStreamer property. If this property is not set, then all cropped buffers will have the same format as of the input buffer format.

The user-specified pre-processing is applied only to dynamically cropped buffers. If the user wants it to be applied to the output buffer/statically cropped buffer as well, they can set the **ppe-on-main buffer** GStreamer property.

Dynamic object is not cropped when crop coordinates or crop resolution is not proper in the attached GstVideoRegionOfInterestMeta metadata and that metadata is skipped in dynamic cropping. `vvas_xmulticrop` plugin may align the crop parameters as per the IP requirement, aligned values are updated in GstVideoRegionOfInterestMeta. GstVideoRegionOfInterestMeta which are skipped will have GstVideoRegionOfInterestMeta->params as NULL.

It is possible to perform both static and dynamic cropping simultaneously. As previously explained, the statically cropped buffer is sent on the source pad, while the dynamically cropped buffers are attached as metadata to the output buffer.

`vvas_xmulticrop` supports at max 39 dynamic crops.
The memory for dynamically cropped buffers is allocated from a GStreamer buffer pool, and there is no upper limit on this buffer pool. However, if the buffers are not freed, new buffers will be allocated, potentially leading to increased memory consumption.

.. important:: The `vvas_xmulticrop` plug-in controls the image-processing kernel. If your application uses this plug-in, then make sure that image-processing kernel is included in your hardware design.

.. important:: Ensure that the image-processing hardware kernel supports maximum resolution required by your application.


Prerequisite
----------------

`vvas_xmulticrop` plug-in is dependent on the ``image-processing`` kernel. If your application uses this plug-in, then make sure that ``image-processing`` kernel is included in your hardware design. Also make sure that the ``image-processing`` hardware kernel supports maximum resolution and required color formats by your application.

Maximum resolution and various color formats supported by ``image-processing`` kernel can be found in `image-processing kernel config <https://github.com/Xilinx/VVAS/blob/master/vvas-accel-hw/image_processing/image_processing_config.h>`_

Input and Output
------------------------

This plug-in accepts buffers with the following color format standards:

* RGBx
* YUY2
* r210
* Y410
* NV16
* NV12
* RGB
* v308
* I422_10LE
* GRAY8
* NV12_10LE32
* BGRx
* GRAY10_LE32
* BGRx
* UYVY
* BGR
* RGBA
* BGRA
* I420
* GBR


Control Parameters and Plug-in Properties
------------------------------------------------

The following table lists the GStreamer plug-in properties supported by the vvas_xmulticrop plug-in.

Table 1: vvas_xmulticrop Plug-in Properties

+--------------------+--------------+---------------+------------------------+-------------------+
|                    |              |               |                        |                   |
|  **Property Name** |   **Type**   | **Range**     | **Default**            | **Description**   |
|                    |              |               |                        |                   |
+====================+==============+===============+========================+===================+
| avoid-output-copy  |   Boolean    | true/false    | False                  | Avoid output      |
|                    |              |               |                        | frames copy even  |
|                    |              |               |                        | when downstream   |
|                    |              |               |                        | does not support  |
|                    |              |               |                        | GstVideoMeta      |
|                    |              |               |                        | metadata          |
+--------------------+--------------+---------------+------------------------+-------------------+
| enable-pipeline    |    Boolean   |  true/false   | false                  | Enable buffer     |
|                    |              |               |                        | pipelining to     |
|                    |              |               |                        | improve           |
|                    |              |               |                        | performance in    |
|                    |              |               |                        | non zero-copy     |
|                    |              |               |                        | use cases         |
+--------------------+--------------+---------------+------------------------+-------------------+
| in-mem-bank        | Unsigned int |  0 - 65535    | 0                      | VVAS input memory |
|                    |              |               |                        | bank to allocate  |
|                    |              |               |                        | memory            |
+--------------------+--------------+---------------+------------------------+-------------------+
| out-mem-bank       | Unsigned int |  0 - 65535    | 0                      | VVAS o/p memory   |
|                    |              |               |                        | bank to allocate  |
|                    |              |               |                        | memory            |
+--------------------+--------------+---------------+------------------------+-------------------+
|                    |    string    |    N/A        |         NULL           | The               |
| xclbin-location    |              |               |                        | location of       |
|                    |              |               |                        | xclbin.           |
+--------------------+--------------+---------------+------------------------+-------------------+
|                    |    string    |    N/A        |                        | Kernel name       |
| kernel-name        |              |               | image_processing:      | and               |
|                    |              |               | {image_processing_1}   | instance          |
|                    |              |               |                        | separated         |
|                    |              |               |                        | by a colon.       |
+--------------------+--------------+---------------+------------------------+-------------------+
|    dev-idx         |    integer   | -1 to 31      |    -1                  | Device index      |
|                    |              |               |                        | This is valid     |
|                    |              |               |                        | only in PCIe/     |
|                    |              |               |                        | Data Center       |
|                    |              |               |                        | platforms.        |
|                    |              |               |                        | Default value is  |
|                    |              |               |                        | set to -1         |
|                    |              |               |                        | intentionally so  |
|                    |              |               |                        | that user         |
|                    |              |               |                        | provides the      |
|                    |              |               |                        | correct device    |
|                    |              |               |                        | index.            |
+--------------------+--------------+---------------+------------------------+-------------------+
|    ppc             |    integer   | 1, 2, 4       |     4                  | Pixel per         |
|                    |              |               |                        | clock             |
|                    |              |               |                        | supported         |
|                    |              |               |                        | by a image-       |
|                    |              |               |                        | processing        |
|                    |              |               |                        | kernel. Default   |
|                    |              |               |                        | value 2 for Edge, |
|                    |              |               |                        | 4 for PCIe        |
|                    |              |               |                        | platform.         |
+--------------------+--------------+---------------+------------------------+-------------------+
|   scale-mode       |    integer   | 0, 1, 2       |     0                  | Scale algorithm   |
|                    |              |               |                        | to use:           |
|                    |              |               |                        | 0:BILINEAR        |
|                    |              |               |                        | 1:BICUBIC         |
|                    |              |               |                        | 2:POLYPHASE       |
|                    |              |               |                        | Default value     |
|                    |              |               |                        | 0 for Edge,       |
|                    |              |               |                        | 2 for PCIe        |
|                    |              |               |                        | platform.         |
+--------------------+--------------+---------------+------------------------+-------------------+
|    coef-load-type  |  integer     | 0 => Fixed    |    0                   | Type of filter    |
|                    |              | 1 => Auto     |                        | Coefficients to   |
|                    |              |               |                        | be used: Fixed    |
|                    |              |               |                        | or Auto           |
|                    |              |               |                        | generated.        |
|                    |              |               |                        | Default value     |
|                    |              |               |                        | 0 for Edge,       |
|                    |              |               |                        | 1 for PCIe        |
|                    |              |               |                        | platform.         |
+--------------------+--------------+---------------+------------------------+-------------------+
|    num-taps        |  integer     | 6=>6 taps     |    12                  | Number of filter  |
|                    |              | 8=>8 taps     |                        | taps to be used   |
|                    |              | 10=>10 taps   |                        | for scaling.      |
|                    |              | 12=>12 taps   |                        | Default value     |
|                    |              |               |                        | 6 for Edge,       |
|                    |              |               |                        | 12 for PCIe       |
|                    |              |               |                        | platform.         |
|                    |              |               |                        | BILINEAR          |
|                    |              |               |                        | scale-mode uses   |
|                    |              |               |                        | 2 taps            |
+--------------------+--------------+---------------+------------------------+-------------------+
|    alpha-b         |  float       | 0 to 128      |    0                   | Mean subtraction  |
|                    |              |               |                        | for blue channel  |
|                    |              |               |                        | , needed only if  |
|                    |              |               |                        | PPE is required   |
+--------------------+--------------+---------------+------------------------+-------------------+
|    alpha-g         |  float       | 0 to 128      |    0                   | Mean subtraction  |
|                    |              |               |                        | for green channel |
|                    |              |               |                        | , needed only if  |
|                    |              |               |                        | PPE is required   |
+--------------------+--------------+---------------+------------------------+-------------------+
|    alpha-r         |  float       | 0 to 128      |    0                   | Mean subtraction  |
|                    |              |               |                        | for red  channel  |
|                    |              |               |                        | , needed only if  |
|                    |              |               |                        | PPE is required   |
+--------------------+--------------+---------------+------------------------+-------------------+
|    beta-b          |  float       | 0 to 1        |    1                   | Scaling for blue  |
|                    |              |               |                        | channel, needed   |
|                    |              |               |                        | only if PPE is    |
|                    |              |               |                        | required          |
+--------------------+--------------+---------------+------------------------+-------------------+
|    beta-g          |  float       | 0 to 1        |    1                   | scaling for green |
|                    |              |               |                        | channel, needed   |
|                    |              |               |                        | only if PPE is    |
|                    |              |               |                        | required          |
+--------------------+--------------+---------------+------------------------+-------------------+
|    beta-r          |  float       | 0 to 1        |    1                   | scaling for red   |
|                    |              |               |                        | channel, needed   |
|                    |              |               |                        | only if PPE is    |
|                    |              |               |                        | required          |
+--------------------+--------------+---------------+------------------------+-------------------+
|    s-crop-x        | unsigned int | 0 to          |    0                   | Crop X coordinate |
|                    |              | 4294967925    |                        | for static        |
|                    |              |               |                        | cropping          |
+--------------------+--------------+---------------+------------------------+-------------------+
|    s-crop-y        | unsigned int | 0 to          |    0                   | Crop Y coordinate |
|                    |              | 4294967925    |                        | for static        |
|                    |              |               |                        | cropping          |
+--------------------+--------------+---------------+------------------------+-------------------+
|   s-crop-width     | unsigned int | 0 to          |    0                   | Crop width for    |
|                    |              | 4294967925    |                        | static cropping   |
|                    |              |               |                        | (minimum: 16),    |
|                    |              |               |                        | when this is 0    |
|                    |              |               |                        | or not set, it    |
|                    |              |               |                        | will be           |
|                    |              |               |                        | calculated as     |
|                    |              |               |                        | input width -     |
|                    |              |               |                        | `s-crop-x`        |
+--------------------+--------------+---------------+------------------------+-------------------+
|  s-crop-height     | unsigned int | 0 to          |    0                   | Crop height for   |
|                    |              | 4294967925    |                        | static cropping   |
|                    |              |               |                        | (minimum: 16),    |
|                    |              |               |                        | when this is 0    |
|                    |              |               |                        | or not set, it    |
|                    |              |               |                        | will be           |
|                    |              |               |                        | calculated as     |
|                    |              |               |                        | input height -    |
|                    |              |               |                        | `s-crop-y`        |
+--------------------+--------------+---------------+------------------------+-------------------+
|     d-width        | unsigned int | 0 to          |    0                   | Width of          |
|                    |              | 4294967925    |                        | dynamically       |
|                    |              |               |                        | cropped buffers   |
+--------------------+--------------+---------------+------------------------+-------------------+
|     d-height       | unsigned int | 0 to          |    0                   | Height of         |
|                    |              | 4294967925    |                        | dynamically       |
|                    |              |               |                        | cropped buffers   |
+--------------------+--------------+---------------+------------------------+-------------------+
|     d-format       |   integer    | 0,2,4,5,7,8,  |    0                   | Format of         |
|                    |              | 11,12,15,16,  |                        | dynamically       |
|                    |              | 23,25,41,45,  |                        | cropped buffers   |
|                    |              | 48,51,78,79,  |                        |                   |
|                    |              | 83            |                        |                   |
+--------------------+--------------+---------------+------------------------+-------------------+
| ppe-on-main-buffer |   boolean    |   true/false  |    0                   | Apply pre-        |
|                    |              |               |                        | processing on     |
|                    |              |               |                        | main buffer also  |
+--------------------+--------------+---------------+------------------------+-------------------+
| software-scaling   |    Boolean   |  true/false   | false                  | Enable software   |
|                    |              |               |                        | scaling instead   |
|                    |              |               |                        | of accelerated    |
|                    |              |               |                        | scaling.          |
+--------------------+--------------+---------------+------------------------+-------------------+

.. note::

       Image-processing IP has some alignment requirement, hence user given parameters for crop are aligned as per the IP requirement, alignment ensures that it covers the region of crop specified by user, hence final cropped image may have extra pixels cropped. Crop width and height must be at least 16.

       The supported video formats being displayed in sink/src caps are the formats supported by ``vvas-core`` hardware(Image-processing) scaler.

Example Pipelines
--------------------

The pipeline mentioned below is for PCIe/Data Center platform. For Embedded platform remove **dev-idx** property from the pipelines mentioned below.

* Below pipeline converts NV12 to RGB and performs scaling from 1920x1080 to 640x480. The pipeline mentioned below is for PCIe/Data Center platform.


.. code-block::

        gst-launch-1.0 -v \
        videotestsrc num-buffers=10 ! video/x-raw,format=NV12,width=1920,height=1080 \
        ! vvas_xmulticrop dev-idx=<device-index> xclbin-location=<xclbin path> \
        ! video/x-raw,format=RGB,width=640,height=480 ! filesink location=out.yuv

* Below pipeline performs pre-processing along with color space conversion and scaling on output buffers

.. code-block::

        gst-launch-1.0 -v \
        videotestsrc num-buffers=10 ! video/x-raw,format=NV12,width=1920,height=1080 \
        ! vvas_xmulticrop dev-idx=<device-index> ppe-on-main-buffer=true alpha-r=124 alpha-g=116 alpha-b=104 beta-r=0.547 beta-g=0.56 beta-b=0.557 xclbin-location=<xclbin path> \
        ! video/x-raw,format=RGB,width=640,height=480 ! filesink location=out.yuv

* Below pipeline performs static cropping at (x,y) = (100,80) and (width,height)= (1280,720), this cropped buffers gets scaled to 640x480 and converted to RGB.

.. code-block::

        gst-launch-1.0 -v \
        videotestsrc num-buffers=10 ! video/x-raw,format=NV12,width=1920,height=1080 \
        ! vvas_xmulticrop dev-idx=<device-index> s-crop-x=100 s-crop-y=80 s-crop-width=1280 s-crop-height=720 xclbin-location=<xclbin path> \
        ! video/x-raw,format=RGB,width=640,height=480 ! filesink location=out.yuv

* Below code shows how to add GstVideoRegionOfInterestMeta for dynamic cropping.

.. code-block::

    GstVideoRegionOfInterestMeta *meta;
    meta = gst_buffer_add_video_region_of_interest_meta (buffer, "roi-crop-meta", 0, 0, 0, 0);
    if (meta) {
      meta->id = id;
      meta->parent_id = p_id;
      meta->x =  x;
      meta->y =  y;
      meta->w = w;
      meta->h = h;
      printf("meta: x:%u y:%u, w:%u h:%u", meta->x, meta->y, meta->w, meta->h);
    }

* Below code shows how to read GstVideoRegionOfInterestMeta and how to extract dynamically cropped buffer/object

.. code-block::

     read_crop_meta (GstBuffer *buf) {
       gpointer state = NULL;
       GstMeta *_meta;
       while ((_meta = gst_buffer_iterate_meta_filtered (buf, &state,
                   GST_VIDEO_REGION_OF_INTEREST_META_API_TYPE))) {
         GstStructure *s = NULL;
         GstVideoRegionOfInterestMeta *roi_meta =
                               (GstVideoRegionOfInterestMeta  *) _meta;
         if (g_strcmp0("roi-crop-meta", g_quark_to_string (roi_meta->roi_type))) {
           //This is not the metadata we are looking for
           continue;
         }
         //Got the ROI crop metadata, prepare output buffer
         //Extract dynamically cropped buffer from this meta
         s = gst_video_region_of_interest_meta_get_param (roi_meta, "roi-buffer");
         if (s) {
           GstBuffer *sub_buffer = NULL;
           gst_structure_get (s, "sub-buffer", GST_TYPE_BUFFER, &sub_buffer, NULL);
           if (sub_buffer) {
             //use sub_buffer and unref it
             dump_dynamically_cropped_buffer (sub_buffer);
           } else {
             printf("couldn't get sub buffer");
           }
         } else {
           printf("couldn't get expected struct");
         }
       }
       return TRUE;
     }

* Below code shows how to read/dump dynamically cropped buffers

.. code-block::

     static gboolean
     dump_dynamically_cropped_buffer (GstBuffer *sub_buffer)
     {
       //Read GstVideoMeta from the buffer, dump the buffer to file
       GstVideoMeta *vmeta = NULL;
       FILE *fp;
       gchar name[256] = { 0 };
       guint i, j, n_planes;
       GstVideoFrame out_frame = { 0 };
       GstVideoFrame new_frame = { 0 };
       GstVideoInfo *vinfo;
       GstBuffer *new_outbuf;
       guint8 *data_ptr, *out_ptr;
       guint w, h;
       gint src_stride;
       const GstVideoFormatInfo *finfo;
       gint comp[GST_VIDEO_MAX_COMPONENTS];
       const GstVideoInfo *sinfo;

       if (!sub_buffer) {
         return FALSE;
       }

       vmeta = gst_buffer_get_video_meta (sub_buffer);
       if (!vmeta) {
         printf ("couldn't get video meta\n");
         return FALSE;
       }

       sprintf (name, "dynbuf_%ux%u_%s.yuv", vmeta->width, vmeta->height,
           gst_video_format_to_string (vmeta->format));
       fp = fopen (name, "wb");
       if (!fp) {
         return FALSE;
       }

       vinfo = gst_video_info_new ();
       gst_video_info_set_format (vinfo, vmeta->format, vmeta->width, vmeta->height);

       new_outbuf = gst_buffer_new_and_alloc (GST_VIDEO_INFO_SIZE (vinfo));
       if (!new_outbuf) {
         printf ("couldn't allocate buffer\n");
         gst_video_info_free (vinfo);
         fclose (fp);
         return FALSE;
       }

       gst_video_frame_map (&out_frame, vinfo, sub_buffer, GST_MAP_READ);
       gst_video_frame_map (&new_frame, vinfo, new_outbuf,
           GST_MAP_READ | GST_MAP_WRITE);

       sinfo = &out_frame.info;
       finfo = sinfo->finfo;
       n_planes = finfo->n_planes;

       for (i = 0; i < n_planes; i++) {
         gst_video_format_info_component (finfo, i, comp);
         data_ptr = out_frame.data[i];
         out_ptr = new_frame.data[i];

         w = GST_VIDEO_FRAME_COMP_WIDTH (&out_frame, comp[0])
             * GST_VIDEO_FRAME_COMP_PSTRIDE (&out_frame, comp[0]);

         h = GST_VIDEO_FRAME_COMP_HEIGHT (&out_frame, comp[0]);
         src_stride = GST_VIDEO_INFO_PLANE_STRIDE (sinfo, i);
         for (j = 0; j < h; j++) {
           memcpy (out_ptr, data_ptr, w);
           data_ptr += src_stride;
           out_ptr += w;
         }
         fwrite (new_frame.data[i], 1, w * h, fp);
       }

       gst_video_frame_unmap (&out_frame);
       gst_video_frame_unmap (&new_frame);
       gst_video_info_free (vinfo);
       gst_buffer_unref (new_outbuf);
       fclose (fp);
       gst_buffer_unref (sub_buffer);
       return TRUE;
     }

vvas_xmulticrop with software scaling kernel
------------------------------------------------

VVAS plugin "vvas_xmulticrop" can also work with software implementation of the IP. User has to set "software-scaling" property to "true", set the "kernel-name" to "image_processing_sw:{image_processing_sw}",
also set "coef-load-type" to "fixed" type and set "num-taps" to 12. Below are the formats supported by the current implementation.

* NV12
* RGB
* GRAY8
* BGR
* I420

Note: For GRAY8, only scaling is supported, cross format conversion is not supported.

Example pipeline:
^^^^^^^^^^^^^^^^^^^

.. code-block::

        gst-launch-1.0 -v \
        videotestsrc num-buffers=10 ! video/x-raw,format=NV12,width=1920,height=1080 \
        ! vvas_xmulticrop kernel-name="image_processing_sw:{image_processing_sw_1}" software-scaling=true coef-load-type=0 num-taps=12 \
        ! video/x-raw,format=RGB,width=640,height=480 ! filesink location=out.yuv

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

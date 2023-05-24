.. _VVAS Video Common APIs:

**VVAS Video Common APIs**

This file contains structures and methods related to VVAS Video Frame.



.. c:enum:: VvasCodecType

   Codec types supported by VVAS Core APIs

**Constants**

``VVAS_CODEC_UNKNOWN``
  Unknown codec type

``VVAS_CODEC_H264``
  H264/AVC codec type

``VVAS_CODEC_H265``
  H265/HEVC codec type




.. c:enum:: VvasVideoFormat

   Represents video color formats supported by VVAS core APIs

**Constants**

``VVAS_VIDEO_FORMAT_UNKNOWN``
  Unknown color format

``VVAS_VIDEO_FORMAT_Y_UV8_420``
  planar 4:2:0 YUV with interleaved UV plane

``VVAS_VIDEO_FORMAT_RGBx``
  Packed RGB, 4 bytes per pixel

``VVAS_VIDEO_FORMAT_r210``
  Packed 4:4:4 RGB, 10 bits per channel

``VVAS_VIDEO_FORMAT_Y410``
  Packed 4:4:4 YUV, 10 bits per channel

``VVAS_VIDEO_FORMAT_BGRx``
  Packed BGR, 4 bytes per pixel

``VVAS_VIDEO_FORMAT_BGRA``
  Reverse rgb with alpha channel last

``VVAS_VIDEO_FORMAT_RGBA``
  RGB with alpha channel last

``VVAS_VIDEO_FORMAT_YUY2``
  Packed 4:2:2 YUV (Y0-U0-Y1-V0, Y2-U2-Y3-V2 Y4...)

``VVAS_VIDEO_FORMAT_NV16``
  Planar 4:2:2 YUV with interleaved UV plane

``VVAS_VIDEO_FORMAT_RGB``
  RGB packed into 24 bits without padding

``VVAS_VIDEO_FORMAT_v308``
  Packed 4:4:4 YUV

``VVAS_VIDEO_FORMAT_BGR``
  BGR packed into 24 bits without padding

``VVAS_VIDEO_FORMAT_I422_10LE``
  Planar 4:2:2 YUV, 10 bits per channel

``VVAS_VIDEO_FORMAT_NV12_10LE32``
  10-bit variant of GST_VIDEO_FORMAT_NV12, packed into 32bit words (MSB 2 bits padding)

``VVAS_VIDEO_FORMAT_GRAY8``
  8-bit grayscale

``VVAS_VIDEO_FORMAT_GRAY10_LE32``
  10-bit grayscale, packed into 32bit words (2 bits padding)

``VVAS_VIDEO_FORMAT_I420``
  Planar 4:2:0 YUV




.. c:struct:: VvasVideoAlignment

   Contains video alignment information

**Definition**

::

  struct VvasVideoAlignment {
    uint32_t padding_right;
    uint32_t padding_left;
    uint32_t padding_top;
    uint32_t padding_bottom;
    uint32_t stride_align[VVAS_VIDEO_MAX_PLANES];
  };

**Members**

``padding_right``
  Padding to the right

``padding_left``
  Padding to the left

``padding_top``
  Padding to the top

``padding_bottom``
  Padding to the bottom

``stride_align``
  Extra alignment requirement for strides (which is in bytes)





.. c:struct:: VvasVideoInfo

   Contains infomation related to a video frame

**Definition**

::

  struct VvasVideoInfo {
    int32_t width;
    int32_t height;
    VvasVideoFormat fmt;
    uint32_t n_planes;
    size_t stride[VVAS_VIDEO_MAX_PLANES];
    size_t elevation[VVAS_VIDEO_MAX_PLANES];
    VvasVideoAlignment alignment;
  };

**Members**

``width``
  Width of a video frame

``height``
  Height of a video frame

``fmt``
  Video frame color format

``n_planes``
  Number of planes in video frame color format

``stride``
  Array of stride values

``elevation``
  Array of elevation values

``alignment``
  Video frame's alignment information





.. c:struct:: VvasVideoPlaneInfo

   Structure contains information specific to a video frame plane

**Definition**

::

  struct VvasVideoPlaneInfo {
    uint8_t *data;
    size_t size;
    size_t offset;
    int32_t stride;
    int32_t elevation;
  };

**Members**

``data``
  Pointer to a video frame plane data

``size``
  Size of a video plane

``offset``
  Offset of the first valid data from the **data** pointer

``stride``
  Stride of a video plane

``elevation``
  Elevation (in height direction) of a video plane





.. c:struct:: VvasVideoFrameMapInfo

   Structure contains information specific to a video frame after mapping operation

**Definition**

::

  struct VvasVideoFrameMapInfo {
    uint8_t nplanes;
    size_t size;
    int32_t width;
    int32_t height;
    VvasVideoFormat fmt;
    VvasVideoAlignment alignment;
    VvasVideoPlaneInfo planes[VVAS_VIDEO_MAX_PLANES];
  };

**Members**

``nplanes``
  Number of planes in a video frame

``size``
  Video frame size

``width``
  Width of the mapped video frame

``height``
  Height of the mapped video frame

``fmt``
  Video frame color format

``alignment``
  Video frame's Alignment information

``planes``
  Array containing video plane specific information



.. c:macro:: VvasVideoFrameDataFreeCB

   **Typedef**: Callback function to be called to free memory pointed by **data**, when VvasMemory handle is getting freed using **vvas_video_frame_free\(\)** API.


**Syntax**

  ``void VvasVideoFrameDataFreeCB (void *data[VVAS_VIDEO_MAX_PLANES], void *user_data)``

**Parameters**

``void *data[VVAS_VIDEO_MAX_PLANES]``
  Array of data pointers to video planes

``void *user_data``
  User data pointer sent via **vvas_video_frame_alloc_from_data\(\)** API

**Return**

None


.. c:function:: VvasVideoFrame* vvas_video_frame_alloc (VvasContext *vvas_ctx, VvasAllocationType alloc_type, VvasAllocationFlags alloc_flags, uint8_t mbank_idx, VvasVideoInfo *vinfo, VvasReturnType *ret)

   Allocates memory based on VvasVideoInfo structure

**Parameters**

``VvasContext *vvas_ctx``
  Address of VvasContext handle created using vvas_context_create()

``VvasAllocationType alloc_type``
  Type of the memory need to be allocated

``VvasAllocationFlags alloc_flags``
  Allocation flags used to allocate video frame

``uint8_t mbank_idx``
  Index of the memory bank on which memory need to be allocated

``VvasVideoInfo *vinfo``
  Address of VvasVideoInfo which contains video frame specific information

``VvasReturnType *ret``
  Address to store return value. In case of error, **ret** is useful in understanding the root cause

**Return**



* On success, returns VvasVideoFrame handle and
* On failure, returns NULL


.. c:function:: VvasVideoFrame* vvas_video_frame_alloc_from_data (VvasContext *vvas_ctx, VvasVideoInfo *vinfo, void *data[VVAS_VIDEO_MAX_PLANES], VvasVideoFrameDataFreeCB free_cb, void *user_data, VvasReturnType *ret)

   Allocates memory based on data pointers provided by user

**Parameters**

``VvasContext *vvas_ctx``
  Address of VvasContext handle created using vvas_context_create()

``VvasVideoInfo *vinfo``
  Video information related a frame

``void *data[VVAS_VIDEO_MAX_PLANES]``
  Array of data pointers to each plane

``VvasVideoFrameDataFreeCB free_cb``
  Pointer to callback function to be called when :c:type:`struct VvasVideoFrame <VvasVideoFrame>` is freed

``void *user_data``
  User data to be passed to callback function **free_cb**

``VvasReturnType *ret``
  Address to store return value. Upon case of error, **ret** is useful in understanding the root cause

**Return**



* On success, returns :c:type:`struct VvasVideoFrame <VvasVideoFrame>` handle and
* On failure, returns NULL


.. c:function:: VvasReturnType vvas_video_frame_map (VvasVideoFrame* vvas_vframe, VvasDataMapFlags map_flags, VvasVideoFrameMapInfo *info)

   Maps **vvas_vframe** to user space using **map_flags**. Based on :c:type:`struct VvasMemory <VvasMemory>`->sync_flags, data will be synchronized between host and the device.

**Parameters**

``VvasVideoFrame* vvas_vframe``
  Address of :c:type:`struct VvasVideoFrame <VvasVideoFrame>`

``VvasDataMapFlags map_flags``
  Flags used to map **vvas_vframe**

``VvasVideoFrameMapInfo *info``
  Structure which gets populated after mapping is successful

**Return**

:c:type:`struct VvasReturnType <VvasReturnType>`


.. c:function:: VvasReturnType vvas_video_frame_unmap (VvasVideoFrame* vvas_vframe, VvasVideoFrameMapInfo *info)

   Unmaps **vvas_vframe** which was mapped earlier

**Parameters**

``VvasVideoFrame* vvas_vframe``
  Address of :c:type:`struct VvasVideoFrame <VvasVideoFrame>`

``VvasVideoFrameMapInfo *info``
  Pointer to information which was populated during vvas_video_frame_map() API

**Return**

:c:type:`struct VvasReturnType <VvasReturnType>`


.. c:function:: void vvas_video_frame_free (VvasVideoFrame* vvas_vframe)

   Frees the video frame allocated during vvas_video_frame_alloc() API

**Parameters**

``VvasVideoFrame* vvas_vframe``
  Address of :c:type:`struct VvasVideoFrame <VvasVideoFrame>`

**Return**

None


.. c:function:: void vvas_video_frame_set_metadata (VvasVideoFrame* vvas_mem, VvasMetadata *meta_data)

   Sets metadata on VvasVideoFrame

**Parameters**

``VvasVideoFrame* vvas_mem``
  Address of :c:type:`struct VvasVideoFrame <VvasVideoFrame>`

``VvasMetadata *meta_data``
  Address of :c:type:`struct VvasMetadata <VvasMetadata>` to be set on **vvas_mem**

**Return**

None


.. c:function:: void vvas_video_frame_get_metadata (VvasVideoFrame* vvas_mem, VvasMetadata *meta_data)

   Gets metadata on VvasVideoFrame

**Parameters**

``VvasVideoFrame* vvas_mem``
  Address of :c:type:`struct VvasVideoFrame <VvasVideoFrame>`

``VvasMetadata *meta_data``
  Address of :c:type:`struct VvasMetadata <VvasMetadata>` to store metadata from **vvas_mem**

**Return**

None


.. c:function:: void vvas_video_frame_get_videoinfo (VvasVideoFrame* vvas_mem, VvasVideoInfo *vinfo)

   Gets video frame information from VvasVideoFrame

**Parameters**

``VvasVideoFrame* vvas_mem``
  Address of :c:type:`struct VvasVideoFrame <VvasVideoFrame>`

``VvasVideoInfo *vinfo``
  Video frame information of :c:type:`struct VvasVideoInfo <VvasVideoInfo>`

**Return**

None



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

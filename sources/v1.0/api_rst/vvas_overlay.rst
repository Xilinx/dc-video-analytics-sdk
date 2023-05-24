.. _VVAS Overlay APIs:

**VVAS Overlay APIs**

This file contains public methods and data structures related to VVAS Overlay.



.. c:struct:: VvasFrameInfo

   Structure represents input frame information on which overlay has to be performed.

**Definition**

::

  struct VvasFrameInfo {
    uint32_t stride;
    uint32_t height;
    uint32_t width;
    VvasVideoFormat fmt;
    uint8_t *buf_addr;
  };

**Members**

``stride``
  stride information

``height``
  height of the frame

``width``
  width of the frame

``fmt``
  Specify input frame color format

``buf_addr``
  Address of frame on which overlay operation to be performed





.. c:struct:: VvasOverlayClockInfo

   Structure represents Clock information to be display on frame.

**Definition**

::

  struct VvasOverlayClockInfo {
    bool display_clock;
    uint32_t clock_font_name;
    float clock_font_scale;
    uint32_t clock_font_color;
    uint32_t clock_x_offset;
    uint32_t clock_y_offset;
  };

**Members**

``display_clock``
  display clock true or false

``clock_font_name``
  font style name

``clock_font_scale``
  font scale

``clock_font_color``
  font color

``clock_x_offset``
  clock x offset

``clock_y_offset``
  clock y offset





.. c:struct:: VvasOverlayFrameInfo

   This is the main structure to be passed for processing overlay onto a frame.

**Definition**

::

  struct VvasOverlayFrameInfo {
    VvasVideoFrame *frame_info;
    VvasOverlayClockInfo clk_info;
    VvasOverlayShapeInfo shape_info;
  };

**Members**

``frame_info``
  frame information

``clk_info``
  clock overlay information

``shape_info``
  Overlay information



.. c:function:: VvasReturnType vvas_overlay_process_frame (VvasOverlayFrameInfo *pFrameInfo)


**Parameters**

``VvasOverlayFrameInfo *pFrameInfo``
  Address of VvasOverlayFrameInfo

**Context**

Drawing is performed on the given frame.

**Return**



* On Success, returns VVAS_SUCCESS.
* On Failure, returns VVAS_ERROR_*



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

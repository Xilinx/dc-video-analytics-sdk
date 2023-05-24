.. _VVAS Scaler APIs:

**VVAS Scaler APIs**

This file contains public methods and data structures related to VVAS scaler.



.. c:enum:: VvasScalerCoefLoadType

   Enum for holding type of filter coefficients loading type

**Constants**

``VVAS_SCALER_COEF_FIXED``
  Fixed filter coefficients type

``VVAS_SCALER_COEF_AUTO_GENERATE``
  Auto generate filter coefficients type




.. c:enum:: VvasScalerMode

   Enum for holding scaling modes.

**Constants**

``VVAS_SCALER_MODE_BILINEAR``
  Bilinear scaling mode

``VVAS_SCALER_MODE_BICUBIC``
  BiCubic scaling mode

``VVAS_SCALER_MODE_POLYPHASE``
  PolyPhase scaling mode




.. c:enum:: VvasScalerType

   Enum for holding scaling types.

**Constants**

``VVAS_SCALER_DEFAULT``
  Default Scale Type

``VVAS_SCALER_LETTERBOX``
  LetterBox Scale which maintain aspect ratio

``VVAS_SCALER_ENVELOPE_CROPPED``
  Envelope scale and center cropped




.. c:enum:: VvasScalerHorizontalAlign

   Enum for holding horizontal alignment options.

**Constants**

``VVAS_SCALER_HORZ_ALIGN_CENTER``
  Center Alignment into output frame

``VVAS_SCALER_HORZ_ALIGN_LEFT``
  Left Alignment into output frame

``VVAS_SCALER_HORZ_ALIGN_RIGHT``
  Right Alignment into output frame




.. c:enum:: VvasScalerVerticalAlign

   Enum for holding vertical alignment options.

**Constants**

``VVAS_SCALER_VERT_ALIGN_CENTER``
  Center Alignment into output frame

``VVAS_SCALER_VERT_ALIGN_TOP``
  Top Alignment into output frame

``VVAS_SCALER_VERT_ALIGN_BOTTOM``
  Bottom Alignment into output frame




.. c:struct:: VvasScalerParam

   Contains Information related to Scaler Parameters

**Definition**

::

  struct VvasScalerParam {
    VvasScalerType type;
    VvasScalerHorizontalAlign horz_align;
    VvasScalerVerticalAlign vert_align;
    uint16_t smallest_side_num;
  };

**Members**

``type``
  Scale Type

``horz_align``
  Horizontal Alignment

``vert_align``
  Vertical Alignment

``smallest_side_num``
  Smallest side numerator to calculate scale ratio for envelope scale





.. c:enum:: VvasScalerFilterTaps

   Enum for holding number of filter taps.

**Constants**

``VVAS_SCALER_FILTER_TAPS_6``
  6 filter taps

``VVAS_SCALER_FILTER_TAPS_8``
  8 filter taps

``VVAS_SCALER_FILTER_TAPS_10``
  10 filter taps

``VVAS_SCALER_FILTER_TAPS_12``
  12 filter taps




.. c:struct:: VvasScalerProp

   Contains Scaler Properties.

**Definition**

::

  struct VvasScalerProp {
    VvasScalerCoefLoadType coef_load_type;
    VvasScalerMode smode;
    VvasScalerFilterTaps ftaps;
    uint32_t ppc;
    uint32_t mem_bank;
    uint8_t n_fmts;
    VvasVideoFormat supported_fmts[VVAS_SCALER_MAX_SUPPORT_FMT];
  };

**Members**

``coef_load_type``
  Coefficient loading type

``smode``
  Scaling mode

``ftaps``
  Filter taps

``ppc``
  Pixel per clock

``mem_bank``
  Memory bank on which the internal buffers should be allocated

``n_fmts``
  Number of color formats supported by scaler

``supported_fmts``
  Array of video formats supported by scaler (valid from 0 **n_fmts**-1)





.. c:enum:: VvasScalerFilterCoefType

   Enum for holding filter coefficients type.

**Constants**

``VVAS_SCALER_FILTER_COEF_SR13``
  Scaling ration 1.3

``VVAS_SCALER_FILTER_COEF_SR15``
  Scaling ration 1.5

``VVAS_SCALER_FILTER_COEF_SR2``
  Scaling ration 2, 8 tap

``VVAS_SCALER_FILTER_COEF_SR25``
  Scaling ration 2.5

``VVAS_SCALER_FILTER_COEF_TAPS_10``
  10 tap

``VVAS_SCALER_FILTER_COEF_TAPS_12``
  12 tap

``VVAS_SCALER_FILTER_COEF_TAPS_6``
  6 tap, Always used for up scale




.. c:struct:: VvasScalerRect

   Contains Information related to frame region of interest.

**Definition**

::

  struct VvasScalerRect {
    VvasVideoFrame *frame;
    uint16_t x;
    uint16_t y;
    uint16_t width;
    uint16_t height;
  };

**Members**

``frame``
  VvasVideoFrame

``x``
  X coordinate

``y``
  Y coordinate

``width``
  Width of Rect

``height``
  Height of Rect





.. c:struct:: VvasScalerPpe

   Contains Information related to Pre-processing parameters

**Definition**

::

  struct VvasScalerPpe {
    float mean_r;
    float mean_g;
    float mean_b;
    float scale_r;
    float scale_g;
    float scale_b;
  };

**Members**

``mean_r``
  PreProcessing parameter alpha/mean red channel value

``mean_g``
  PreProcessing parameter alpha/mean green channel value

``mean_b``
  PreProcessing parameter alpha/mean blue channel value

``scale_r``
  PreProcessing parameter beta/scale red channel value

``scale_g``
  PreProcessing parameter beta/scale green channel value

``scale_b``
  PreProcessing parameter beta/scale blue channel value





.. c:type:: VvasScaler

   Opaque handle for the VvasScaler instance


.. c:function:: VvasScaler * vvas_scaler_create (VvasContext * ctx, const char * kernel_name, VvasLogLevel log_level)

   Creates Scaler's instance.

**Parameters**

``VvasContext * ctx``
  VvasContext handle created using **vvas_context_create**

``const char * kernel_name``
  Scaler kernel name

``VvasLogLevel log_level``
  Logging level

**Return**

On Success returns VvasScaler handle pointer, on Failure returns NULL


.. c:function:: VvasReturnType vvas_scaler_channel_add (VvasScaler * hndl, VvasScalerRect * src_rect, VvasScalerRect * dst_rect, VvasScalerPpe * ppe, VvasScalerParam * param)

   This API adds one processing channel configuration. One channel represents a set of operations, like resize, color space conversion, PPE etc. to be performed on the input buffer. Hardware Scaler may have alignment requirement. In such case this API will adjust x, y, width and height of src_rect and dst_rect. Adjusted values will be updated in the src_rect and dst_rect.

**Parameters**

``VvasScaler * hndl``
  VvasContext handle created using **vvas_context_create**

``VvasScalerRect * src_rect``
  Source Rect **VvasScalerRect**

``VvasScalerRect * dst_rect``
  Destination Rect **VvasScalerRect**

``VvasScalerPpe * ppe``
  Preprocessing parameters **VvasScalerPpe**, NULL if no PPE is needed

``VvasScalerParam * param``
  Scaler type and Alignment parameters **VvasScalerParam**

**Return**

VvasReturnType


.. c:function:: VvasReturnType vvas_scaler_process_frame (VvasScaler * hndl)

   This API does processing of channels added using **vvas_scaler_channel_add** There can be multiple channels added to perform different operations on the input frame. All these operations are performed in context of this API call.

**Parameters**

``VvasScaler * hndl``
  VvasScaler handle pointer created using **vvas_scaler_create**

**Return**

VvasReturnType


.. c:function:: VvasReturnType vvas_scaler_destroy (VvasScaler * hndl)

   This API destroys the scaler instance created using **vvas_scaler_create**

**Parameters**

``VvasScaler * hndl``
  VvasScaler handle pointer created using **vvas_scaler_create**

**Return**

VvasReturnType


.. c:function:: VvasReturnType vvas_scaler_set_filter_coef (VvasScaler * hndl, VvasScalerFilterCoefType coef_type, const int16_t tbl[VVAS_SCALER_MAX_PHASES][VVAS_SCALER_FILTER_TAPS_12])

   This API can be used to overwrite default filter coefficients.

**Parameters**

``VvasScaler * hndl``
  VvasScaler handle pointer created using **vvas_scaler_create**

``VvasScalerFilterCoefType coef_type``
  Filter coefficients type **VvasScalerFilterCoefType**

``const int16_t tbl[VVAS_SCALER_MAX_PHASES][VVAS_SCALER_FILTER_TAPS_12]``
  Filter coefficients, Reference of VVAS_SCALER_MAX_PHASESxVVAS_SCALER_FILTER_TAPS_12 array of short

**Return**

VvasReturnType


.. c:function:: VvasReturnType vvas_scaler_prop_get (VvasScaler * hndl, VvasScalerProp * prop)

   This API will fill current scaler properties. This API returns the default properties if called before setting these properties.

**Parameters**

``VvasScaler * hndl``
  VvasScaler handle pointer created using **vvas_scaler_create**.
  If **hndl** is null, then static configurations will be returned in **prop** by parsing scaler config file "/opt/xilinx/vvas/share/image_processing.cfg"

``VvasScalerProp * prop``
  Scaler properties **VvasScalerProp**

**Return**

VvasReturnType


.. c:function:: VvasReturnType vvas_scaler_prop_set (VvasScaler * hndl, VvasScalerProp * prop)

   This API is used to set properties of VvasScaler

**Parameters**

``VvasScaler * hndl``
  VvasScaler handle pointer created using **vvas_scaler_create**

``VvasScalerProp * prop``
  Scaler properties **VvasScalerProp**

**Return**

VvasReturnType



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.. _VVAS Overlay Shape Info APIs:

**VVAS Overlay Shape Info APIs**

This file contains public methods and data structures related to VVAS Overlay Shape Info.



.. c:enum:: VvasOverlayArrowDirection

   Structure representing Arrow Direction information

**Constants**

``ARROW_DIRECTION_START``
  START

``ARROW_DIRECTION_END``
  END

``ARROW_DIRECTION_BOTH_ENDS``
  BOTH_ENDS




.. c:struct:: VvasOverlayCoordinates

   Structure representing Coordinate information

**Definition**

::

  struct VvasOverlayCoordinates {
    int32_t x;
    int32_t y;
  };

**Members**

``x``
  x offset

``y``
  y offset





.. c:struct:: VvasOverlayColorData

   Structure representing Color information

**Definition**

::

  struct VvasOverlayColorData {
    uint8_t red;
    uint8_t green;
    uint8_t blue;
    uint8_t alpha;
  };

**Members**

``red``
  red value

``green``
  green value

``blue``
  blue value

``alpha``
  alpha value





.. c:struct:: VvasOverlayFontData

   Structure representing Font information

**Definition**

::

  struct VvasOverlayFontData {
    uint32_t font_num;
    float font_size;
    VvasOverlayColorData font_color;
  };

**Members**

``font_num``
  font style number from openCV

``font_size``
  font size

``font_color``
  font color





.. c:struct:: VvasOverlayRectParams

   Structure representing information to draw rectangle on frame.

**Definition**

::

  struct VvasOverlayRectParams {
    VvasOverlayCoordinates points;
    uint32_t width;
    uint32_t height;
    uint32_t thickness;
    uint32_t apply_bg_color;
    VvasOverlayColorData rect_color;
    VvasOverlayColorData bg_color;
  };

**Members**

``points``
  frame coordinate info

``width``
  width of the rectangle

``height``
  height of the rectangle

``thickness``
  thickness of rectangle

``apply_bg_color``
  flag to apply bg color

``rect_color``
  color information of rectangle

``bg_color``
  color information of background





.. c:struct:: VvasOverlayTextParams

   Structure representing Text information

**Definition**

::

  struct VvasOverlayTextParams {
    VvasOverlayCoordinates points;
    char *disp_text;
    uint32_t bottom_left_origin;
    uint32_t apply_bg_color;
    VvasOverlayFontData text_font;
    VvasOverlayColorData bg_color;
  };

**Members**

``points``
  text coordinate info

``disp_text``
  display text

``bottom_left_origin``
  display text position

``apply_bg_color``
  display text background color

``text_font``
  display text font

``bg_color``
  background color information





.. c:struct:: VvasOverlayLineParams

   Structure representing Line information

**Definition**

::

  struct VvasOverlayLineParams {
    VvasOverlayCoordinates start_pt;
    VvasOverlayCoordinates end_pt;
    uint32_t thickness;
    VvasOverlayColorData line_color;
  };

**Members**

``start_pt``
  line start coordinate info

``end_pt``
  line end coordinate info

``thickness``
  Thickness in units of Pixels

``line_color``
  color information





.. c:struct:: VvasOverlayArrowParams

   Structure representing Arrow information

**Definition**

::

  struct VvasOverlayArrowParams {
    VvasOverlayCoordinates start_pt;
    VvasOverlayCoordinates end_pt;
    VvasOverlayArrowDirection arrow_direction;
    uint32_t thickness;
    float tipLength;
    VvasOverlayColorData line_color;
  };

**Members**

``start_pt``
  arrow start coordinate info

``end_pt``
  arrow end coordinate info

``arrow_direction``
  arrow direction

``thickness``
  thickness in units of Pixels

``tipLength``
  tip length

``line_color``
  color information





.. c:struct:: VvasOverlayCircleParams

   Structure representing Circle Information

**Definition**

::

  struct VvasOverlayCircleParams {
    VvasOverlayCoordinates center_pt;
    uint32_t thickness;
    uint32_t radius;
    VvasOverlayColorData circle_color;
  };

**Members**

``center_pt``
  circle coordinate info

``thickness``
  circle thickness

``radius``
  circle radius

``circle_color``
  color information





.. c:struct:: VvasOverlayPolygonParams

   Structure representing Polygon information

**Definition**

::

  struct VvasOverlayPolygonParams {
    VvasList *poly_pts;
    uint32_t thickness;
    int32_t num_pts;
    VvasOverlayColorData poly_color;
  };

**Members**

``poly_pts``
  polygon coordinate info

``thickness``
  polygon thickness

``num_pts``
  number of points

``poly_color``
  polygon color information





.. c:struct:: VvasOverlayShapeInfo

   Structure representing Overlay Shape information

**Definition**

::

  struct VvasOverlayShapeInfo {
    uint32_t num_rects;
    uint32_t num_text;
    uint32_t num_lines;
    uint32_t num_arrows;
    uint32_t num_circles;
    uint32_t num_polys;
    VvasList *rect_params;
    VvasList *text_params;
    VvasList *line_params;
    VvasList *arrow_params;
    VvasList *circle_params;
    VvasList *polygn_params;
  };

**Members**

``num_rects``
  number of rectangles to be displayed

``num_text``
  number of texts to be displayed

``num_lines``
  number of lines to be displayed

``num_arrows``
  number of arrows to be displayed

``num_circles``
  number of circles to be displayed

``num_polys``
  number of polygons to be displayed

``rect_params``
  rectangle information

``text_params``
  text meta information

``line_params``
  line meta information

``arrow_params``
  arrow meta information

``circle_params``
  circle meta information

``polygn_params``
  polygon meta information



.. c:function:: void vvas_overlay_shape_info_init (VvasOverlayShapeInfo *shape_info)

   Initializes shape_info parameters

**Parameters**

``VvasOverlayShapeInfo *shape_info``
  Pointer to shape info structure

**Return**

none


.. c:function:: void vvas_overlay_shape_info_copy (VvasOverlayShapeInfo *dest_shape_info, VvasOverlayShapeInfo *src_shape_info)

   Copies shape information from src to dst

**Parameters**

``VvasOverlayShapeInfo *dest_shape_info``
  Destination shape info structure

``VvasOverlayShapeInfo *src_shape_info``
  Source shape info structure

**Return**

none


.. c:function:: void vvas_overlay_shape_info_free (VvasOverlayShapeInfo *shape_info)

   Deinitializes shape_info parameters

**Parameters**

``VvasOverlayShapeInfo *shape_info``
  Pointer to shape info structure

**Return**

none



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

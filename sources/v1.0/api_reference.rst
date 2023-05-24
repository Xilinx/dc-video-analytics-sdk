.. _api_reference.rst:


####################
VVAS C API Reference
####################

***********
Common APIs
***********

VVAS Common APIs
================

.. include:: api_rst/vvas_common.rst

Device Context APIs
===================

.. include:: api_rst/vvas_context.rst

Logging APIs
============

.. include:: api_rst/vvas_log.rst

Memory APIs
===========

.. include:: api_rst/vvas_memory.rst

Video Common APIs
=================

.. include:: api_rst/vvas_video.rst

DPU Common APIs
===============

.. include:: api_rst/vvas_dpucommon.rst

Infer Classification APIs
=========================

.. include:: api_rst/vvas_infer_classification.rst

Infer Prediction APIs
=====================

.. include:: api_rst/vvas_infer_prediction.rst

***********
Parser APIs
***********

Core APIs

  * Creating Parser Instance: :c:func:`vvas_parser_create()`
  * Getting Stream Parameters (Decode input configuration) and Acces Unit Frame: :c:func:`vvas_parser_get_au()`
  * Destroying Parser Instance: :c:func:`vvas_parser_destroy()`

Details of API and its parameter description 

.. include:: api_rst/vvas_parser.rst

************
Decoder APIs
************

Core APIs

  * Creating Decoder Instance: :c:func:`vvas_decoder_create()` 
  * Configuring Decoder and getting decoder's output configuration: :c:func:`vvas_decoder_config()`
  * Submit Parsed Frame and List of output video frames to the decoder: :c:func:`vvas_decoder_submit_frames()`
  * Get Decoded frame from the Decoder: :c:func:`vvas_decoder_get_decoded_frame()`
  * Destroy Decoder instance: :c:func:`vvas_decoder_destroy()`

Details of API and its parameter description 

.. include:: api_rst/vvas_decoder.rst

*******************************
Scaler APIs/Pre-processing APIs
*******************************

Core APIs

   * Create Scaler instance: :c:func:`vvas_scaler_create()`
   * Adding processing channel into the Scaler: :c:func:`vvas_scaler_channel_add()`
   * Processing all the added channels: :c:func:`vvas_scaer_process_frame()`
   * Configuring Scaler: :c:func:`vvas_scaler_prop_set()`
   * Destroy Scaler instance: :c:func:`vvas_scaler_destroy()`

Details of API and its parameter description 

.. include:: api_rst/vvas_scaler.rst


**************
Inference APIs
**************

Core APIs

  * Create DPU instance: :c:func:`vvas_dpuinfer_create()` 
  * Get DPU configuration: :c:func:`vvas_dpuinfer_get_config()` 
  * Do inferencing: :c:func:`vvas_dpuinfer_process_frames()` 
  * Destroy DPU instance: :c:func:`vvas_dpuinfer_destroy()`

Details of API and its parameter description 

.. include:: api_rst/vvas_dpuinfer.rst

******************************
Inference Post-processing APIs
******************************

.. include:: api_rst/vvas_postprocessor.rst

************
Tracker APIs
************

.. include:: api_rst/vvas_tracker.rst


*****************
Meta Convert APIs
*****************

Core APIs

   * Create MetaConvert instance: :c:func:`vvas_metaconvert_create()` 
   * Convert DPU detected data to Overlay data format: :c:func:`vvas_metaconvert_prepare_overlay_metadata()`
   * Destroy MetaConvert instance: :c:func:`vvas_metaconvert_destroy()`

Details of API and its parameter description 

.. include:: api_rst/vvas_metaconvert.rst

************
Overlay APIs
************

Core APIs

   * Draw Infer data onto the Video: :c:func:`vvas_overlay_process_frame()` 

Details of API and its parameter description 

.. include:: api_rst/vvas_overlay_shape_info.rst

.. include:: api_rst/vvas_overlay.rst

****************
Metaaffixer APIs
****************

.. include:: api_rst/vvas_metaaffixer.rst

************
Utility APIs
************

Mutex APIs
==========

.. include:: api_rst/vvas_mutex.rst

List APIs
=========

.. include:: api_rst/vvas_list.rst

Queue APIs
==========

.. include:: api_rst/vvas_queue.rst

Tree Node APIs
==============

.. include:: api_rst/vvas_node.rst

Hash APIs
=========

.. include:: api_rst/vvas_hash.rst

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.. _VVAS Metaaffixer APIs:

**VVAS Metaaffixer APIs**

This file describes APIs for metaaffixer that can be used to scale the
inference metadata as per the different resolution than the original resolution.
The infer meta data to be scaled and attached is decided based on matching the
PTS of the source and the destination frames.



.. c:enum:: VvasMetaAffixerRespCode

   This enum represents Metaaffixer response code.

**Constants**

``VVAS_METAAFFIXER_PASS``
  Indicates operation is success. 

``VVAS_METAAFFIXER_NO_FRAME_OVERLAP``
  Indicates no frame overlap occured. 

``VVAS_METAAFFIXER_NULL_VALUE``
  Indicates NULL value received. 


.. c:function:: VvasMetaAffixer* vvas_metaaffixer_create (uint64_t inferframe_dur, uint32_t infer_queue_size, VvasLogLevel loglevel)

   Creates metaaffixer handle

**Parameters**

``uint64_t inferframe_dur``
  Duration of the infer frame.                                                  

``uint32_t infer_queue_size``
  Represents Max queue size of the infer frame

``VvasLogLevel loglevel``
  Indicates log level

**Context**

This function will allocate internal resources and  
return the handle.

**Return**



 * On Sucess returns handle of Metaaffixer handle
 * On Failure returns NULL


.. c:function:: void vvas_metaaffixer_destroy (VvasMetaAffixer *handle)

   Destroys metaaffixer handle

**Parameters**

``VvasMetaAffixer *handle``
  MetaAffixer handle to be destroyed 

**Context**

This function will destroy all memory allocated for handle instanced passed 

**Return**

None


.. c:function:: VvasReturnType vvas_metaaffixer_get_frame_meta (VvasMetaAffixer *handle, bool sync_pts, VvasVideoInfo *vinfo, VvasMetadata *metadata, VvasMetaAffixerRespCode *respcode, VvasInferPrediction **ScaledMetaData)

   Provides scaled metadata.

**Parameters**

``VvasMetaAffixer *handle``
  Address of context handle **ref** VvasMetaAffixer

``bool sync_pts``
  if FALSE then last received infer meta data
  is used for scaling. Else reference infer metadata is
  chosen based on PTS of input frame.

``VvasVideoInfo *vinfo``
  Input Frame Information

``VvasMetadata *metadata``
  Metadata of input frame

``VvasMetaAffixerRespCode *respcode``
  Metaaffixer response code.

``VvasInferPrediction **ScaledMetaData``
  Scaled meta data is updated here.

**Context**

This function returns scaled metadata based on input frame info

**Return**

 * On Success returns VVAS_SUCCESS
 * On Failure returns VVAS_RET_ERROR 


.. c:function:: VvasReturnType vvas_metaaffixer_submit_infer_meta (VvasMetaAffixer *handle, VvasVideoInfo *vinfo, VvasMetadata *metadata, VvasInferPrediction *infer)

   Submit infer metadata.

**Parameters**

``VvasMetaAffixer *handle``
  Context handle **ref** VvasMetaAffixer

``VvasVideoInfo *vinfo``
  Address of frame info

``VvasMetadata *metadata``
  Metadata of frame

``VvasInferPrediction *infer``
  Infer metadata associated with infer frame

**Context**

This function will submit meta data information.

**Return**

 * On Success returns VVAS_RET_SUCCESS
 * On Failure returns VVAS_RET_ERROR



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.. _VVAS Decoder APIs:

**VVAS Decoder APIs**

This file contains the public methods related to VVAS decoder. These
functions can be used to implement decode of avc/h264 and hevc/h265 encoded
stream(s). User need to pass one access-unit(au) at a time for decoding.



.. c:type:: VvasDecoder

   Holds the reference to decoder instance.




.. c:struct:: VvasDecoderInCfg

   Holds decoder input configuration

**Definition**

::

  struct VvasDecoderInCfg {
    uint32_t width;
    uint32_t height;
    uint32_t frame_rate;
    uint32_t clk_ratio;
    uint32_t codec_type;
    uint32_t profile;
    uint32_t level;
    uint32_t bitdepth;
    uint32_t chroma_mode;
    uint32_t scan_type;
    uint32_t splitbuff_mode;
    uint32_t low_latency;
    uint32_t entropy_buffers_count;
    uint32_t i_frame_only;
  };

**Members**

``width``
  width of frame in pixel

``height``
  Height of frame in pixel

``frame_rate``
  Frame rate

``clk_ratio``
  Clock Ratio

``codec_type``
  Codec Type, AVC - 0 or HEVC - 1

``profile``
  Encoding profile

``level``
  Encoding level

``bitdepth``
  Bit depth of each pixel 8 or 10 bit

``chroma_mode``
  Chroma Mode

``scan_type``
  Scan Type, Interlaced(0) or Progressive(1)

``splitbuff_mode``
  Split Buffer Mode

``low_latency``
  Low Latency, Disabled(0) or Enabled(1)

``entropy_buffers_count``
  Number of Entropy Buffers

``i_frame_only``
  I frame only decode, Disabled(0) or Enabled(1)





.. c:struct:: VvasDecoderOutCfg

   Holds the configuration information for decoder output

**Definition**

::

  struct VvasDecoderOutCfg {
    VvasVideoInfo vinfo;
    uint32_t mem_bank_id;
    uint32_t min_out_buf;
  };

**Members**

``vinfo``
  VvasVideoInfo represents decoder output frame properties

``mem_bank_id``
  Memory bank on which video frame should be allocated

``min_out_buf``
  Minimum number of output buffers required for decoder



.. c:function:: VvasDecoder* vvas_decoder_create (VvasContext *vvas_ctx, uint8_t *dec_name, VvasCodecType dec_type, uint8_t hw_instance_id, VvasLogLevel log_level)

   Creates decoder's instance handle

**Parameters**

``VvasContext *vvas_ctx``
  Address of VvasContext handle created using vvas_context_create

``uint8_t *dec_name``
  Name of the decoder to be used for decoding

``VvasCodecType dec_type``
  Type of the decoder to be used (i.e. H264/H265)

``uint8_t hw_instance_id``
  Decoder instance index in a multi-instance decoder.
  Incase of V70, this represents HW instance index and can have
  any value from 0 to 3.

``VvasLogLevel log_level``
  Logging level

**Context**

This function will allocate internal decoder resources and return the
handle.

**Return**



* VvasDecoder handle pointer on success.
* NULL on failure.


.. c:function:: VvasReturnType vvas_decoder_config (VvasDecoder* dec_handle, VvasDecoderInCfg *icfg, VvasDecoderOutCfg *ocfg)

   Configures decoder with VvasDecoderInCfg and produces VvasDecoderOutCfg. Applications or parser can populate VvasDecoderInCfg

**Parameters**

``VvasDecoder* dec_handle``
  Decoder handle pointer

``VvasDecoderInCfg *icfg``
  Decoder input configuration

``VvasDecoderOutCfg *ocfg``
  Decoder output configuration

**Context**

This fucntion configures the decoder hardware for stream to be
decoded. User need to allocate alteast suggested min_out_buf each with
properties as in vinfo of ocfg. List if these allocated buffers are required
to be passed to decoder in the fist invocation of function
vvas_decoder_submit_frames along with the first access-unit.

**Return**



* :c:type:`enum VvasReturnType <VvasReturnType>`


.. c:function:: VvasReturnType vvas_decoder_submit_frames (VvasDecoder* dec_handle, VvasMemory *au, VvasList *loutframes)

   Submits one Access Unit/Frame and free output buffers to decoder for decoding

**Parameters**

``VvasDecoder* dec_handle``
  Decoder handle pointer

``VvasMemory *au``
  Complete access unit/frame. send NULL pointer on End of stream

``VvasList *loutframes``
  List of free output frames for decoding process

**Context**

This function submits the encoded access-unit(au) and a list of
free output buffers. These output buffers are used by decoder to output decoded frames.
Once user has consumed the output buffer, then this free output buffer is sent back to
decoder in successive invocation. In first invocation of
this function user need to pass the list of atleast as many free outout buffers as
suggested in :c:type:`ocfg` output parameter of vvas_decoder_config API. At the end of
stream, user need to pass au=NULL and drain/flush the decoder by calling
vvas_decoder_get_decoded_frame several times till we get :c:type:`VVAS_RET_EOS`. User need to send free output buffers
to decoder even during the draining/flushing of remaining decoded frame.

**Return**



* VVAS_RET_SUCCESS if success.
* VVAS_RET_INVALID_ARGS if parameter is not valid or not in  expeceted range.
* VVAS_RET_SEND_AGAIN if nalu is not consumed completely. In this case, send same NALU again.
* VVAS_RET_ERROR if any other errors.


.. c:function:: VvasReturnType vvas_decoder_get_decoded_frame (VvasDecoder* dec_handle, VvasVideoFrame **output)

   This API gets decoded frame from decoder

**Parameters**

``VvasDecoder* dec_handle``
  Decoder handle pointer

``VvasVideoFrame **output``
  Video frame which contains decoded data

**Context**

This function gives decoded frame if available, one at a time in
each invocation. User need to keep calling this function until VVAS_RET_EOS
is returned.

**Return**



* VVAS_RET_SUCCESS on success.
* VVAS_RET_EOS on End of stream.
* VVAS_RET_NEED_MOREDATA if decoder need more data to produce any decoded frame.
* VVAS_RET_INVALID_ARGS if parameter is not valid or not in expeceted range.
* VVAS_RET_ERROR any other error.


.. c:function:: VvasReturnType vvas_decoder_destroy (VvasDecoder* dec_handle)

   Destroys decoded handle

**Parameters**

``VvasDecoder* dec_handle``
  Decoder handle pointer

**Context**

This function will free internal resources and destroy handle.

**Return**



* VVAS_RET_SUCCESS on success.
* VVAS_RET_ERROR on failure.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

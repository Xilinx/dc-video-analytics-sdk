#!/bin/bash

XCLBIN_LOCATION="/opt/xilinx/xclbin/v70.xclbin"


DECODE_PIPE=" h264parse ! \
             vvas_xvideodec dev-idx=0 xclbin-location=$XCLBIN_LOCATION kernel-name=\"kernel_vdu_decoder:{kernel_vdu_decoder_0}\" instance-id=0 avoid-output-copy=true avoid-dynamic-alloc=0 ! \
             identity sync=0 "

INFER_PIPE=" vvas_xskipframe name=skip_0_0 infer-interval=3 ! \
	vvas_xinfer preprocess-config=./preprocess.json infer-config=infer.json name=yolo_0 ! \
	vvas_xreorderframe name=reorder_0_0 ! \
	vvas_xtracker min-object-width=20 max-object-width=1900 min-object-height=20 max-object-height=1000 match-search-region=1 num-frames-confidence=2 "

DISPLAY_PIPE=" vvas_xabrscaler dev-idx=0 xclbin-location=$XCLBIN_LOCATION kernel-name=\"image_processing:{image_processing_1}\" ! \
             video/x-raw, width=480, height=270, format=NV12 ! \
	     vvas_xmetaconvert config-location=metaconvert.json ! \
             vvas_xoverlay ! \
             videoconvert ! \
             fpsdisplaysink sync=false "

CMD="vvas_xfunnel name=funnel_in ! $INFER_PIPE ! vvas_xdefunnel name=funnel_out \
	skip_0_0.src_1 ! \
	reorder_0_0.skip_sink funnel_out. ! $DISPLAY_PIPE \
	filesrc location=/workspace/Cars_1900.264 ! $DECODE_PIPE ! funnel_in. "

gst-launch-1.0 -v $CMD

#MIT License
#
#Copyright (c) 2023 Advanced Micro Devices, Inc.
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

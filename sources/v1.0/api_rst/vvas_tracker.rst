.. _VVAS Tracker APIs:

**VVAS Tracker APIs**

This file contains public methods and data structures related to VVAS Tracker.



.. c:enum:: VvasTrackerAlgoType

   Enum representing tracker algorithm type

**Constants**

``TRACKER_ALGO_IOU``
  Intersection-Over-Union algorithm

``TRACKER_ALGO_MOSSE``
  Minimum Output Sum of Squared Error algorithm

``TRACKER_ALGO_KCF``
  Kernelized Correlation Filter algorithm

``TRACKER_ALGO_NONE``
  No Algorithm is specified. TRACKER_ALGO_KCF will be
  set as default algorithm.




.. c:enum:: VvasTrackerMatchColorSpace

   Enum representing color space used for object matching

**Constants**

``TRACKER_USE_RGB``
  Use RGB color space for object matching

``TRACKER_USE_HSV``
  Use HSV (Hue-Saturation-Value) color space for object matching.




.. c:enum:: VvasTrackerSearchScale

   Enum representing search scales to be used for tracking

**Constants**

``SEARCH_SCALE_ALL``
  Search for object both in up, same and down scale

``SEARCH_SCALE_UP``
  Search for object in up and same scale only

``SEARCH_SCALE_DOWN``
  Search for object in down and same scale only

``SEARCH_SCALE_NONE``
  Search for in same scale




.. c:struct:: VvasTrackerconfig

   Structure to hold tracker configuration

**Definition**

::

  struct VvasTrackerconfig {
    VvasTrackerAlgoType tracker_type;
    bool iou_use_color;
    VvasTrackerMatchColorSpace obj_match_color;
    VvasTrackerSearchScale search_scales;
    unsigned int fet_length;
    unsigned int min_width;
    unsigned int min_height;
    unsigned int max_width;
    unsigned int max_height;
    int num_inactive_frames;
    int num_frames_confidence;
    float padding;
    float obj_match_search_region;
    float dist_correlation_threshold;
    float dist_overlap_threshold;
    float dist_scale_change_threshold;
    float dist_correlation_weight;
    float dist_overlap_weight;
    float dist_scale_change_weight;
    float occlusion_threshold;
    float confidence_score;
    bool skip_inactive_objs;
  };

**Members**

``tracker_type``
  Tracker algorithm to be used 0:IOU 1:KCF Tracker 2:MOSSE Tracker

``iou_use_color``
  To use color information for matching or not duirng IOU tracking

``obj_match_color``
  Color space to be used for object matching

``search_scales``
  Search scales of object during tracking

``fet_length``
  Feature length to be used during KCF based tracking

``min_width``
  Minimum width for considering as noise

``min_height``
  Minimum height for considering as noise

``max_width``
  Maximum width for considering as noise

``max_height``
  Maximum height for considering as noise

``num_inactive_frames``
  Number of frames wait for object reappearing before
  consider as inactive

``num_frames_confidence``
  Number of frames of continuous detection before
  considering for tracking and assiging an ID

``padding``
  Extra area surrounding the target to search in tracking

``obj_match_search_region``
  Search for nearest object to match

``dist_correlation_threshold``
  Objects correlation threshold

``dist_overlap_threshold``
  Objects overlap threshold

``dist_scale_change_threshold``
  Ojbects scale change threshold

``dist_correlation_weight``
  Weightage for correlation in distance function

``dist_overlap_weight``
  Weightage for overlap in distance function

``dist_scale_change_weight``
  Weightage for scale change in distance function

``occlusion_threshold``
  Occlusion threshold to ignore objects for tracking

``confidence_score``
  Tracker confidence threshold for tracking

``skip_inactive_objs``
  Flag to enable skipping of inactive object



.. c:function:: VvasTracker * vvas_tracker_create (VvasContext *vvas_ctx, VvasTrackerconfig *config)

   initializes tracker with config parameters and allocates required memory 

**Parameters**

``VvasContext *vvas_ctx``
  Pointer VvasContext handle.

``VvasTrackerconfig *config``
  Pointer to VvasTrackerConfig structure.

**Return**

On Success returns **ref** VvasTracker handle. On Failure returns NULL.


.. c:function:: VvasReturnType vvas_tracker_process (VvasTracker *vvas_tracker_hndl, VvasVideoFrame *pFrame, VvasInferPrediction **infer_meta)

   Called for every frames with or without detection information for tracking objects in a frame.

**Parameters**

``VvasTracker *vvas_tracker_hndl``
  **ref** VvasTracker with newly detected objects in VvasTracker:new_objs.
  Upon tracking updates **ref** VvasTracker:trk_objs with tracked objects info.

``VvasVideoFrame *pFrame``
  **ref** VvasVideoFrame structure of input frame.

``VvasInferPrediction **infer_meta``
  **ref** VvasInferPrediction contains detection tree if detection info available
  else NULL.

**Return**

**ref** VvasReturnType.


.. c:function:: bool vvas_tracker_destroy (VvasTracker *vvas_tracker_hndl)

   free memory allocated during creating the tracker and resets parameters to default values

**Parameters**

``VvasTracker *vvas_tracker_hndl``
  Pointer to **ref** VvasTracker

**Return**

True on success. False on failure.



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#####################
Development Guide
#####################

For advanced developers who wants to develop their Kernel or VVAS acceleration s/w library for their Kernel, this section covers detailed description and steps to achieve that.  Acceleration s/w library implements the logic to control the kernel. Each acceleration s/w lib must implement four APIs that are then called by VVAS Infrastructure plugins to interact with the kernel.



.. toctree::
   :maxdepth: 3
   :caption: For Advanced Developers
   :hidden:

   Acceleration s/w Library Developement Guide <Acceleration-Software-Library-Development>

.. list-table:: 
   :widths: 20 80
   :header-rows: 1
   
   * - Title
     - Description
	 
   * - :doc:`Acceleration s/w Library Developement Guide <Acceleration-Software-Library-Development>`
     - This section covers the intefaces exposed by VVAS framework to develop the aceleration s/w library. It also covers various types of Kernels supported and how to develop acceleration s/w lib for each type of kernels.

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

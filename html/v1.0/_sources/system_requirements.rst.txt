
Software & Hardware Requirements
################################

The current VVAS Video Analytics solution package for data center platform consists of the following software and hardware dependencies. 

Supported Host Operating System
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ubuntu 20.04.4 LTS (Kernel: 5.4.0-135-generic)


Software packages 
~~~~~~~~~~~~~~~~~

- **Xilinx Runtime (XRT) Version**: 2.14.418

- **APU Petalinux Package version**: 2.14.418

- **V70 Platform Package**: xilinx_v70_gen5x8_qdma_base_2


Hardware Requirements
~~~~~~~~~~~~~~~~~~~~~

- **Host Machine**: X86 host machine with x16 PCIe slot
- **AMD Alveo V70 card**: AMD Alveo V70 card with ES1 silicon
- DMB2 (Alveo programming) cable connected between V70 card and Windows laptop with Vivado 2022.2 installed (Needed only if received V70 card has no pre-loaded image and “lspci -vd 10ee:” is not detecting the card)
- To avoid inconsistent failure we recommend disabling the IOMMU of the host system. For  example, follow below steps if V70 card is installed on server with AMD CPU.

.. code-block::

   sudo  bash  -c  'echo  GRUB_CMDLINE_LINUX="amd_iommu=off"  >> /etc/default/grub'
   sudo grub-mkconfig -o /boot/grub/grub.cfg 
   sudo reboot

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

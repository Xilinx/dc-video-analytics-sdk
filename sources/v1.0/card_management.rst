.. _card_management.rst:

################################
Device Management & Utility tool
################################

***********************************
Overview
***********************************

The V70 Video Analytics SDK builds on the Xilinx Runtime (XRT) to interface with V70. The Video analytics SDK includes the ``xbutil`` and ``xbmgmt`` command line tools for card installation, upgrade, and management.


* The XRT management utility tool ``xbmgmt`` is used to administer V70. During the installation process ``xbmgmt`` command is used to flash the card firmware. Running this command requires sudo privileges. An online documentation of ``xbmgmt`` tool can be found at `xbmgmt documentation page in XRT documentation repo <https://xilinx.github.io/XRT/master/html/xbmgmt.html>`_


* The XRT user-space utility tool ``xbutil`` is used to examine, identify, program, and validate the installed V70 card(s). An online documentation of ``xbutil`` tool can be found at `xbutil documentation page in XRT documentation repo <https://xilinx.github.io/XRT/master/html/xbutil.html>`_

We will review some of the ``xbutil`` commands you may find useful during working on V70 card. 


***********************************
Examining the card
***********************************

The command ``xbutil examine`` is used to examine the V70 card. Assuming you have V70 up and running you can see a similar output like below

.. code-block:: bash

   System Configuration
     OS Name              : Linux
     Release              : 5.4.0-100-generic
     Version              : #113-Ubuntu SMP Thu Feb 3 18:43:29 UTC 2022
     Machine              : x86_64
     CPU Cores            : 12
     Memory               : 64264 MB
     Distribution         : Ubuntu 20.04.5 LTS
     GLIBC                : 2.31
     Model                : Precision T3610

   XRT
     Version              : 2.14.406
     Branch               : 2022.2
     Hash                 : 1727dda274d11e788ff457b668756d2c28dc6aec
     Hash Date            : 2023-01-18 21:51:00
     XOCL                 : 2.14.406, 1727dda274d11e788ff457b668756d2c28dc6aec
     XCLMGMT              : 2.14.406, 1727dda274d11e788ff457b668756d2c28dc6aec

   Devices present
   BDF             :  Shell                          Platform UUID                         Device ID       Device Ready*  
   -----------------------------------------------------------------------------------------------------------------------
   [0000:03:00.1]  :  xilinx_v70_gen5x8_qdma_base_2  56B80853-34D6-5BF2-8537-2EF76178CF95  user(inst=128)  Yes            


A couple of things to note from the above sample output

- The above output shows V70 device with PCIe BDF. Thr BDF should be used with ``xbutil --device <bdf>`` switch to obtain the device specific information. 
- The output also shows the "Device Ready" as "Yes" for a device in a good state.  

For further inspecion of the device you can run ``xbutil examine --device <bdf> --report <report type>`` for many different types of reports. For example to view the thermal report simply do ``xbutil examine --device <bdf> --report thermal``. 

.. code-block:: bash 

   xbutil examine --device 0000:03:00.1 --report thermal

   -----------------------------------------------
   [0000:03:00.1] : xilinx_v70_gen5x8_qdma_base_2
   -----------------------------------------------
   Thermals
      Temperature            : Celcius
      PCB                    :     39 C
      device                 :     49 C
      vccint                 :     41 C


To obtain the full list of ``xbutil examine`` subcommands you can run ``xbutil examine --help``


***********************************
Resetting the card
***********************************

In a situation when V70 goes to a bad state, you can reset the card by ``xbutil reset`` command. 

.. code-block:: shell

   xbutil reset --device 0000:03:00.1 --force
   xbutil program --device 0000:03:00.1 -u /opt/xilinx/xclbin/v70.xclbin


***********************************
Validating the card
***********************************
The command ``xbutil validate`` runs some built-in test that confirms the card is in good state (or not). 

.. code-block:: shell

    xbutil validate --device 0000:03:00.1



..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.. _installation.rst:

##################
Installation Guide
##################


*************
Prerequisites
*************

System Requirements
===================

- A V70 card is installed in the PCIe slot of the host system. 
- At least **100GB** of free space in the target partition.

.. _docker-installation:

Docker Installation
===================

Make sure that the Docker engine is installed according to the official Docker `documentation <https://docs.docker.com/engine/install/>`__ to install the Docker engine. The Docker daemon always runs as the root user. Non-root users must be `added <https://docs.docker.com/engine/install/linux-postinstall/>`__ to the docker group. ::

    sudo apt update
    sudo apt install make build-essential nfs-kernel-server docker docker.io
    sudo apt install containerd
    sudo docker run hello-world
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    sudo systemctl restart docker

Perform a quick and simple test of your Docker installation by executing the following command.  This command will download a test image from Docker Hub and run it in a container. When the container runs successfully, it prints a "Hello World" message and exits. ::

    docker run hello-world

|

**********************
Installation Procedure
**********************


Configuring the System
======================

#. Download the following files required for installation process::

.. code-block:: 

   wget -O v70_install_host_pkgs.sh https://www.xilinx.com/bin/public/openDownload?filename=v70_install_host_pkgs.sh
   wget -O v70_docker_prompt.txt  https://www.xilinx.com/bin/public/openDownload?filename=v70_docker_prompt.txt
   wget -O v70_docker_run.sh https://www.xilinx.com/bin/public/openDownload?filename=v70_docker_run.sh

The three files downloaded are

   - **v70_install_host_pkgs.sh**: Script to install Platform, XRT and APU packages on host machine
   - **v70_docker_run.sh** : Script to start and enter the docker 
   - **v70_docker_prompt.txt** : Text file that prompts user to accept the license agreements of different software packages installed in the docker

Make sure all the above three files in the same directory from where you are running the installation process

#. Ensure the V70 card is detected::

    lspci -vd 10ee:
    ....
    ....
    03:00.0 Processing accelerators: Xilinx Corporation Device 5094
        Subsystem: Xilinx Corporation Device 000e
        Flags: bus master, fast devsel, latency 0, NUMA node 0
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at d8080000 (64-bit, prefetchable) [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: xclmgmt
        Kernel modules: xclmgmt

    03:00.1 Processing accelerators: Xilinx Corporation Device 5095
        Subsystem: Xilinx Corporation Device 000e
        Flags: bus master, fast devsel, latency 0, NUMA node 0
        Memory at d8000000 (64-bit, prefetchable) [size=512K]
        Memory at d0000000 (64-bit, prefetchable) [size=128M]
        Capabilities: <access denied>
        Kernel driver in use: xocl
        Kernel modules: xocl

Make a note of Bus device function (BDF) numbers for XRT mgmtpf (03:00.0) and userpf (03:00.1) functions. These numbers should be given as argument to --device switch of XRT commands if in case there are more than one Alveo card is connected 

#. Install the drivers, runtime library and firmware packages and program the V70 cards::

 
    ./v70_install_host_pkgs.sh <BDF of XRT mgmtpf of the V70 device> 
    
    
#. Cold reboot the system. 

 

#. After the cold boot is complete, check that the cards are configured and that all the devices are ready:: 

    source /opt/xilinx/xrt/setup.sh 
    xbutil examine 
    
   
    ....
    ....
    Devices present
    BDF             :  Shell                          Platform UUID                         Device ID       Device Ready*  
    -----------------------------------------------------------------------------------------------------------------------
    [0000:03:00.1]  :  xilinx_v70_gen5x8_qdma_base_2  C56DE598-76F3-467D-2D82-0328EBA1C95A  user(inst=128)  Yes 



|

Installing the VVAS Video-Analytics SDK Docker Image
====================================================

#. Ensure :ref:`docker is installed <docker-installation>` and running. If not restart docker::

     sudo systemctl restart docker

#. Ensure you have the required space for loading data from docker image. The standard data directory used by docker is /var/lib/docker, and since this directory will store all your images, volumes, etc. it can become quite large in a relative small amount of time. In that case create docker daemon configuration /etc/docker/daemon.json as shown below. The path provided to data-root should have minimum 100GB space. After creating this file it requires restarting the docker again as per the command in the previous step :: 

    sudo cat /etc/docker/daemon.json
    {
        "data-root": "/scratch/docker-data"
    }

#. Get the docker images from the docker hub 

    For Tensorflow 2.x supported docker::

		docker pull xilinx/v70-video-analytics-tf2-cpu:ubuntu2004-1.0.0

    For Tensorflow 1.x supported docker::

		docker pull xilinx/v70-video-analytics-tf-cpu:ubuntu2004-1.0.0

    For Pytorch supported docker::

		docker pull xilinx/v70-video-analytics-pytorch-cpu:ubuntu2004-1.0.0

#. Verify that the docker image is correctly installed and is in the list of available images::

    docker images 

|

************************************
Running the VVAS Video-Analytics SDK
************************************


1. Run the Docker image
=======================
If working on a remote server, ensure X11 forwarding is enabled (``ssh -X``). Before running docker, ensure the DISPLAY is working on your terminal. Try any native GUI application (for example gedit or galculator) to see if the display works correctly. 

Load the TF2 docker image::

   ./v70_docker_run.sh v70-video-analytics-tf2-cpu:ubuntu2004-v1.0.0
   

Upon successful loading you will get banner indicating you are inside the container at /workspace directory::


    ==========================================
 
    __      ___ _   _                   _____
    \ \    / (_) | (_)            /\   |_   _|
     \ \  / / _| |_ _ ___ ______ /  \    | |
      \ \/ / | | __| / __|______/ /\ \   | |
       \  /  | | |_| \__ \     / ____ \ _| |_
        \/   |_|\__|_|___/    /_/    \_\_____|
 
    ==========================================

    Docker Image Version: latest   (CPU) 
    Vitis AI Git Hash: xxxxx 
    Build Date: xxxx-yy-zz
    WorkFlow: tf2


2. Set up the environment 
=========================

Set up the environmt in running container::

   source /opt/xilinx/docker_env_setup.sh
   
Note: By default, the ``/opt/xilinx/docker_env_setup.sh`` setup script will configure the system to work with the V70 device identified with index 0. If there are multiple devices are attached to the host then make sure the ``XLNX_ENABLE_DEVICES`` variable is set to the desired device index in the ``docker_env.sh`` script. The list of available devices can be obtained with ``xbutil examine`` command. If the host server has only one V70 device, no change is required.  

3. Run a sample application
===========================

Run the provided sample application to ensure the card is ready and video analytics pipeline is running. Make sure to run the scripts on the host machine directly with X11 enabled. Once the user is inside the docker container terminal, set the DISPLAY environment variable appropriately.

1)	Download sample mp4 video file (selecting 1920x1080 resolution) from below url and copy to the path accessible inside the docker to run the car classification example
 
 https://pixabay.com/videos/traffic-cars-road-street-56696/  


**Car Classification Application - Example 1** ::

    cd /opt/xilinx/examples/run_scripts
    ./car_classification_16streams_ximagesink_mp4.sh <path to sample mp4 video file>

- This script runs sixteen video streams for Car classification use case in parallel and show the results on sixteen separate Xwindows
- The sixteen output video streams will show the detected Car objects and their characteristics (Color/Make/Type)


**Car Classification Application - Example 2** ::

    cd /opt/xilinx/examples/run_scripts
    ./car_classification_16streams_fakesink_mp4.sh <path to sample mp4 video file>

- This script is used to run the above use case using Gstreamer fakesink plugin instead of ximagesink. This script can be used to measure the performance of the solution

To kill the running application, you can do a CTRL+C in the terminal.

  

..
  ------------
  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

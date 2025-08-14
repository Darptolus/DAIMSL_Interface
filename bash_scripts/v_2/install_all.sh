#!/bin/sh
# Install prerequisites
# Linux-Ubuntu
sudo apt-get install -y pciutils build-essential gcc cmake libfftw3-dev \
  libjpeg-dev libpng-dev mpich libmpich-dev mpich-doc nvidia-cuda-toolkit \
  libxi-dev libxrandr-dev libxcursor-dev libxinerama-dev python3-pip ffmpeg \
  libhdf5-dev hdf5-tools zlib1g-dev libvtk9-dev qtbase5-dev libwayland-dev \
  libxkbcommon-dev xorg-dev libboost-program-options-dev git python3 \
  python3-pip libboost-all-dev

cd DAIMSL_Interface/bash_scripts/
export DAIMSL_DIR=${HOME}/DAIMSL
chmod +x *.sh


# Install MPICH

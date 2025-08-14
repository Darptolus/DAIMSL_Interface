#!/bin/sh
# Install prerequisites
# Linux-Ubuntu
sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y git  build-essential gcc cmake python3 pciutils \
  python3-pip python3-venv libfftw3-dev libjpeg-dev libpng-dev mpich \
  libmpich-dev mpich-doc nvidia-cuda-toolkit libxi-dev libxrandr-dev \
  libxcursor-dev libxinerama-dev ffmpeg libhdf5-dev hdf5-tools zlib1g-dev \
  libvtk9-dev qtbase5-dev libwayland-dev libxkbcommon-dev xorg-dev \
  libboost-program-options-dev libboost-all-dev

#******************************************************************************#
#                           ___     _          _                               #
#                          | _ \___| |__ _ _ _(_)___                           #
#                          |  _/ _ \ / _` | '_| (_-<                           #
#                          |_| \___/_\__,_|_| |_/__/                           #
#                                                                              #
#******************************************************************************#

module load craype-accel-nvidia80
module swap PrgEnv-nvhpc PrgEnv-gnu
module use /soft/modulefiles
module load cudatoolkit-standalone
module load spack-pe-base cmake

module load gcc-native/12.3
module load cray-mpich/8.1.28

module load cce/17.0.0
module load nvhpc/23.9
module load nvidia/23.9

module load craype-network-ucx
module load cray-mpich-ucx/8.1.28

module load cray-hdf5

export MPICH_DIR=/opt/cray/pe/mpich/8.1.28/ucx/gnu/12.3/

export CC=${MPICH_DIR}/bin/mpicc
export CXX=${MPICH_DIR}/bin/mpic++
export FTN=${MPICH_DIR}/bin/mpif90

export MPICXX=${MPICH_DIR}/bin/mpic++

export MPI_C_COMPILER=${MPICH_DIR}/bin/mpicc
export MPI_CXX_COMPILER=${MPICH_DIR}/bin/mpic++
export MPIEXEC_EXECUTABLE=/opt/cray/pals/1.3.4/bin/mpiexec

#******************************************************************************#

cd ${HOME}
mkdir DAIMSL
cd DAIMSL
git clone https://github.com/Darptolus/DAIMSL_Interface
mkdir tools

# Set Environment Variables
export DAIMSL_DIR=${HOME}/DAIMSL
export DAIMSL_SCRIPTS_DIR=${DAIMSL_DIR}/DAIMSL_Interface/bash_scripts
export DAIMSL_TOOLS_DIR=${DAIMSL_DIR}/tools

# Set up Python Environment
mkdir daimsl_venv
python3 -m venv ./daimsl_venv
source daimsl_venv/bin/activate
pip install ipykernel
pip install python-dotenv

cd ${DAIMSL_SCRIPTS_DIR}
chmod +x *.sh

#******************************************************************************#
#                           __  __ ___ ___ ___ _  _                            #
#                          |  \/  | _ \_ _/ __| || |                           #
#                          | |\/| |  _/| | (__| __ |                           #
#                          |_|  |_|_| |___\___|_||_|                           #
#                                                                              #
#******************************************************************************#

# Install MPICH
export MPICH_DIR=${DAIMSL_TOOLS_DIR}/mpich
cd ${DAIMSL_TOOLS_DIR}
wget https://www.mpich.org/static/downloads/4.3.1/mpich-4.3.1.tar.gz
tar xzvf mpich-4.3.1.tar.gz
cd mpich-4.3.1
./configure --prefix=${MPICH_DIR} --enable-shared
make -j
make -j install

# Update MPICH Variables ToDo: Inline vars
source ${DAIMSL_SCRIPTS_DIR}/mpich_vars.sh
mpiexec --version

echo "Setting MPICH:"

export CC=${MPICH_DIR}/bin/mpicc
export CXX=${MPICH_DIR}/bin/mpic++
export FTN=${MPICH_DIR}/bin/mpif90

export MPICXX=${MPICH_DIR}/bin/mpic++

export MPI_C_COMPILER=${MPICH_DIR}/bin/mpicc
export MPI_CXX_COMPILER=${MPICH_DIR}/bin/mpic++
export MPIEXEC_EXECUTABLE=${MPICH_DIR}/bin/mpiexec

#******************************************************************************#
#                                    _ _ _                                     #
#                                 __| (_) |__                                  #
#                                |_ / | | '_ \                                 #
#                                /__|_|_|_.__/                                 #
#                                                                              #
#******************************************************************************#

# Install zlib
cd ${DAIMSL_TOOLS_DIR}
wget https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.gz
tar xzvf zlib-1.3.1.tar.gz
cd zlib-1.3.1
./configure --prefix=${DAIMSL_TOOLS_DIR}/zlib_bin
make -j
make -j install

# Update zlib Variables ToDo: Inline vars
source ${DAIMSL_SCRIPTS_DIR}/zlib_vars.sh

#******************************************************************************#
#                              _  _ ___  ___ ___                               #
#                             | || |   \| __| __|                              #
#                             | __ | |) | _||__ \                              #
#                             |_||_|___/|_| |___/                              #
#                                                                              #
#******************************************************************************#

# Install HDF5
cd ${DAIMSL_TOOLS_DIR}
# wget https://www.hdfgroup.org/download/hdf5-1-14-6-tar-gz/
tar xzvf hdf5-1-14-6.tar.gz
cd hdf5-1.14.6
./configure --prefix=${DAIMSL_TOOLS_DIR}/hdf5_bin
make -j
make -j install

# Update zlib Variables ToDo: Inline vars
source ${DAIMSL_SCRIPTS_DIR}/hdf5_vars.sh

#******************************************************************************#
#                      _      _   __  __ __  __ ___  ___                       #
#                     | |    /_\ |  \/  |  \/  | _ \/ __|                      #
#                     | |__ / _ \| |\/| | |\/| |  _/\__ \                      #
#                     |____/_/ \_\_|  |_|_|  |_|_|  |___/                      #
#                                                                              #
#******************************************************************************#

# Install LAMMPS
cd ${DAIMSL_DIR}
git clone -b release --depth=1 https://github.com/lammps/lammps.git lammps
lammpspath=${DAIMSL_DIR}/lammps
objpath=${lammpspath}/obj_bin

export CMAKE_OPTS=" \
  -DCMAKE_CXX_STANDARD=17 \
  -DCMAKE_INSTALL_PREFIX=${objpath} \
  -DBUILD_MPI=on \
  -DBUILD_OMP=on \
  -DPKG_BODY=on \
  -DPKG_MOLECULE=on \
  -DPKG_RIGID=on \
  -DPKG_KSPACE=on \
  -DPKG_GRANULAR=on \
  -DLAMMPS_PNG=on \
  -DLAMMPS_JPEG=on \
  -DLAMMPS_FFMPEG=on \
  -DPKG_VTK=ON \
  -DPKG_HDF5=ON \
  -DBUILD_SHARED_LIBS=yes \
  -DFMT=internal \
"
cmake -S cmake/ -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

# Update LAMMPS Variables ToDo: Inline vars
source ${DAIMSL_SCRIPTS_DIR}/lammps_vars.sh


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv#

#******************************************************************************#
#               _                   _     _    _                 _             #
#              /_\   ___ __ ___ _ _| |_ _| |_ /_\  _ _  __ _ _ _(_)            #
#             / _ \ (_-</ _/ -_) ' \  _|_   _/ _ \| ' \/ _` | '_| |            #
#            /_/ \_\/__/\__\___|_||_\__| |_|/_/ \_\_||_\__,_|_| |_|            #
#                                                                              #
#******************************************************************************#

# Install Ascent+Anari
cd ${DAIMSL_DIR}
git clone --recursive -b task/2025_05_develop_anari --depth=1 https://github.com/Alpine-DAV/ascent/ ascent_anari
cd ascent_anari
git submodule init
git submodule update

export ascent_dir=${DAIMSL_DIR}/ascent_anari/obj_bin
cd scripts/build_ascent/
ln -s ${DAIMSL_SCRIPTS_DIR}/build_ascent_anari_daimsl.sh build_ascent_anari_daimsl.sh
# ./build_ascent_anari_daimsl.sh
source build_ascent_anari_sojourner_v0.sh
./build_ascent_anari_sojourner.sh
# Update Ascent+Anari Variables ToDo: Inline vars
# ./build_ascent_anari_daimsl.sh

#******************************************************************************#
#                          ___          _____ ___ ___                          #
#                         / _ \ _ _  __|_   _| _ ) _ )                         #
#                        | (_) | ' \/ -_)| | | _ \ _ \                         #
#                         \___/|_||_\___||_| |___/___/                         #
#                                                                              #
#******************************************************************************#

# Install OneTBB
# git clone https://github.com/uxlfoundation/oneTBB.git onetbb
# cd opentbb
# onetbbpath=${HOME}/onetbb

git clone --branch v2021.13.0 --depth=1 https://github.com/oneapi-src/oneTBB.git tbb2021
cd onetbb2021
mkdir build
onetbbpath=${DAIMSL_TOOLS_DIR}/onetbb2021
objpath=${onetbbpath}/obj_bin

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
                    -DCMAKE_INSTALL_PREFIX=${objpath} \
                    -DMPI_C_COMPILER=${mpichpath}/mpicc \
                    -DMPI_CXX_COMPILER=${mpichpath}/mpicxx \
                    -DCMAKE_C_COMPILER=${mpichpath}/mpicc \
                    -DCMAKE_CXX_COMPILER=${mpichpath}/mpicxx \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

# Update OneTBB Variables ToDo: Inline vars
# cd ~/onetbb
cd ~/onetbb2021
# ln -s ~/tools/onetbb_install.sh onetbb_install.sh
ln -s ~/tools/onetbb2021_install.sh onetbb2021_install.sh
# ./onetbb_install.sh 
./onetbb_install.sh 
# source ~/tools/onetbb_vars.sh
source ~/tools/onetbb2021_vars.sh


#******************************************************************************#
#                             ___ _    _____      __                           #
#                            / __| |  | __\ \    / /                           #
#                           | (_ | |__| _| \ \/\/ /                            #
#                            \___|____|_|   \_/\_/                             #
#                                                                              #
#******************************************************************************#

# Install GLFW
git clone --recursive https://github.com/glfw/glfw glfw
cd glfw
git submodule update --init --recursive
mkdir build

glfwpath=${DAIMSL_TOOLS_DIR}/opensubdiv
objpath=${glfwpath}/obj_bin

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
                    -DCMAKE_INSTALL_PREFIX=${objpath} \
                    -DMPI_C_COMPILER=${mpichpath}/mpicc \
                    -DMPI_CXX_COMPILER=${mpichpath}/mpicxx \
                    -DCMAKE_C_COMPILER=${mpichpath}/mpicc \
                    -DCMAKE_CXX_COMPILER=${mpichpath}/mpicxx \
                    -DBUILD_SHARED_LIBS=ON \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

cd ~/glfw
# ln -s ~/tools/glfw_install.sh glfw_install.sh
# ./glfw_install.sh 

# Update GLFW Variables ToDo: Inline vars
source ~/tools/glfw_vars.sh


#******************************************************************************#
#                 ___                 ___      _        _ _                    #
#                / _ \ _ __  ___ _ _ / __|_  _| |__  __| (_)_ __               #
#               | (_) | '_ \/ -_) ' \\__ \ || | '_ \/ _` | \ V /               #
#                \___/| .__/\___|_||_|___/\_,_|_.__/\__,_|_|\_/                #
#                     |_|                                                      #
#******************************************************************************#

# Install OpenSubdiv
git clone https://github.com/PixarAnimationStudios/OpenSubdiv opensubdiv
cd opensubdiv
mkdir build

onetbbpath=${DAIMSL_TOOLS_DIR}/onetbb
objpath=${onetbbpath}/obj_bin


export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
-DCMAKE_INSTALL_PREFIX=${objpath} \
-DMPI_C_COMPILER=${mpichpath}/mpicc \
-DMPI_CXX_COMPILER=${mpichpath}/mpicxx \
-DCMAKE_C_COMPILER=${mpichpath}/mpicc \
-DCMAKE_CXX_COMPILER=${mpichpath}/mpicxx \
"
cmake -S cmake/ -B build/ ${CMAKE_OPTS}
cmake --build build --parallel 4
cmake --install build

# ln -s ~/tools/onetbb_install.sh onetbb_install.sh
# ./onetbb_install.sh 

# Update OpenSubdiv Variables ToDo: Inline vars
source ~/tools/onetbb_vars.sh


#******************************************************************************#
#                       ___                _   _ ___ ___                       #
#                      / _ \ _ __  ___ _ _| | | / __|   \                      #
#                     | (_) | '_ \/ -_) ' \ |_| \__ \ |) |                     #
#                      \___/| .__/\___|_||_\___/|___/___/                      #
#                           |_|                                                #
#******************************************************************************#
# Prerequisites:
source ~/tools/mpich_vars.sh
source ~/tools/conduit_vars.sh
source ~/tools/anari_ascent_vars.sh
source ~/tools/ascent_anari_vars.sh
source ~/tools/anarisdk_vars.sh

source ~/tools/zlib_vars.sh
source ~/tools/hdf5_vars.sh
source ~/tools/lammps_vars.sh

# - OneTBB (2021)
source ~/tools/onetbb2021_vars.sh
# - GLFW
source ~/tools/glfw_vars.sh
# - OpenSubdiv
source ~/tools/opensubdiv_vars.sh

# Install OpenUSD (2411)
git clone --depth=1 https://github.com/PixarAnimationStudios/OpenUSD openusd
cd openusd
openusdpath=${DAIMSL_TOOLS_DIR}/openusd
objpath=${openusdpath}/obj_bin
mpichpath=${DAIMSL_TOOLS_DIR}/tools/mpich/bin
onetbbpath=${DAIMSL_TOOLS_DIR}/onetbb/obj_bin
opensubdivpath=${DAIMSL_TOOLS_DIR}/opensubdiv/obj_bin

export FC=${mpichpath}/mpif90
export CC=${mpichpath}/mpicc
export CXX=${mpichpath}/mpic++

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
										-DCMAKE_INSTALL_PREFIX=${objpath} \
										-DMPI_C_COMPILER=${mpichpath}/mpicc \
										-DMPI_CXX_COMPILER=${mpichpath}/mpicxx \
										-DCMAKE_C_COMPILER=${mpichpath}/mpicc \
										-DCMAKE_CXX_COMPILER=${mpichpath}/mpicxx \
										-DTBB_ROOT_DIR=${onetbbpath} \
										-DOPENSUBDIV_ROOT_DIR=${opensubdivpath} \
										-DPXR_BUILD_PYTHON_SUPPORT=OFF \
										-DPXR_ENABLE_PYTHON_SUPPORT=FALSE \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

# ln -s ~/tools/openusd_install.sh openusd_install.sh

# Update OpenUSD Variables ToDo: Inline vars
source ~/tools/openusd_vars.sh


#******************************************************************************#
#                       _                 _ ___ ___  _  __                     #
#                      /_\  _ _  __ _ _ _(_) __|   \| |/ /                     #
#                     / _ \| ' \/ _` | '_| \__ \ |) | ' <                      #
#                    /_/ \_\_||_\__,_|_| |_|___/___/|_|\_\                     #
#                                                                              #
#******************************************************************************#

# Install AnariSDK
git clone --recursive https://github.com/KhronosGroup/ANARI-SDK anarisdk
cd anarisdk
git submodule update --init --recursive
anarisdk=${HOME}/anarisdk
objpath=${anarisdk}/obj_bin

anaripath=${HOME}/ascent/anari_sdk/obj_bin
openusd=${HOME}/openusd/obj_bin

export CMAKE_OPTS=" \
  -DCMAKE_CXX_STANDARD=17 \
  -DCMAKE_INSTALL_PREFIX=${objpath} \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

# ln -s ~/tools/anarisdk_install.sh anarisdk_install.sh
# ./anarisdk_install.sh

# Update AnariSDK Variables ToDo: Inline vars
source ~/tools/anarisdk_vars.sh


#******************************************************************************#
#                       _                 _ _   _ ___ ___                      #
#                      /_\  _ _  __ _ _ _(_) | | / __|   \                     #
#                     / _ \| ' \/ _` | '_| | |_| \__ \ |) |                    #
#                    /_/ \_\_||_\__,_|_| |_|\___/|___/___/                     #
#                                                                              #
#******************************************************************************#
# Prerequisites:
source ~/tools/mpich_vars.sh
source ~/tools/anarisdk_vars.sh
source ~/tools/openusd2411p_vars.sh

source ~/tools/conduit_vars.sh
source ~/tools/anari_ascent_vars.sh
source ~/tools/ascent_anari_vars.sh

source ~/tools/zlib_vars.sh
source ~/tools/hdf5_vars.sh
source ~/tools/lammps_vars.sh

# - OneTBB (2021)
source ~/tools/onetbb2021_vars.sh
# - GLFW
source ~/tools/glfw_vars.sh
# - OpenSubdiv
source ~/tools/opensubdiv_vars.sh

# Install AnariUSD
git clone --recursive https://github.com/NVIDIA-Omniverse/ANARI-USD anariusd
cd anariusd
git submodule update --init --recursive


# Update AnariUSD Variables ToDo: Inline vars
source ~/tools/anariusd_vars.sh


# Link library
# ln -s ~/anariusd/obj_bin/lib/libanari_library_usd.so ~/ascent_anari/obj_bin/install/anari-v0.10.0/lib
# ln -s ~/anariusd/obj_bin/lib/libUsdBridge_Volume.so ~/ascent_anari/obj_bin/install/anari-v0.10.0/lib
ln -s ~/anariusd/obj_bin_p/lib/libanari_library_usd.so ~/anarisdk/obj_bin/lib/libanari_library_usd.so
ln -s ~/anariusd/obj_bin_p/lib/libUsdBridge_Volume.so ~/anarisdk/obj_bin/lib/libUsdBridge_Volume.so

#******************************************************************************#
#                                 _                           _                #
#         __ ___ _ _  _ _  ___ __| |_ ___ ___ __ _ _ __  _ __| |___ ___        #
#        / _/ _ \ ' \| ' \/ -_) _|  _|___(_-</ _` | '  \| '_ \ / -_|_-<        #
#        \__\___/_||_|_||_\___\__|\__|   /__/\__,_|_|_|_| .__/_\___/__/        #
#                                                       |_|                    #
#******************************************************************************#

# Install connect-samples
git clone https://github.com/NVIDIA-Omniverse/connect-samples connectsamples
cd connectsamples
./repo.sh build
./repo.sh install_sdk


# Update connect-samples Variables ToDo: Inline vars
source ~/tools/connectsamples_vars.sh


#******************************************************************************#
#            ___             _                         ___ ___  _  __          #
#           / _ \ _ __  _ _ (_)_ _____ _ _ ___ ___ ___/ __|   \| |/ /          #
#          | (_) | '  \| ' \| \ V / -_) '_(_-</ -_)___\__ \ |) | ' <           #
#           \___/|_|_|_|_||_|_|\_/\___|_| /__/\___|   |___/___/|_|\_\          #
#                                                                              #
#******************************************************************************#

#!/bin/sh

# LAMMPS
lammpspath=${HOME}/lammps
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


# cmake ../cmake \
#   -DCMAKE_INSTALL_PREFIX=$HOME/lammps/install \
#   -DBUILD_MPI=ON \
#   -DBUILD_SHARED_LIBS=ON \
#   -DLAMMPS_EXCEPTIONS=ON \
#   -DLAMMPS_MEMALIGN=64 \
#   -DPKG_MISC=ON \
#   -DPKG_USER-REAXC=ON \
#   -DPKG_USER-MISC=ON \
#   -DPKG_USER-ASPHERE=ON \
#   -DPKG_KSPACE=ON \
#   -DPKG_RIGID=ON \
#   -DPKG_ATC=ON \
#   -DPKG_DUMP=ON \
#   -DPKG_MOLECULE=ON \
#   -DPKG_EXTRA-DUMP=ON \
#   -DPKG_REPLICA=ON \
#   -DPKG_USER-OMP=ON \
#   -DPKG_USER-ATC=ON \
#   -DWITH_PNG=ON \
#   -DWITH_JPEG=ON \
#   -DWITH_FFMPEG=ON \
#   -DWITH_HDF5=ON \
#   -DHDF5_INCLUDE_DIR=$HDF5_ROOT/include \
#   -DHDF5_LIBRARY=$HDF5_ROOT/lib/libhdf5.so \
#   -DZLIB_INCLUDE_DIR=$ZLIB_ROOT/include \
#   -DZLIB_LIBRARY=$ZLIB_ROOT/lib/libz.so

# -DPKG_DUMP=ON -DPKG_EXTRA-DUMP=ON

# make -j$(nproc)
# make install

# lammpspath=${HOME}/lammps
# objpath=${lammpspath}/obj_bin
# mpichpath=${HOME}/tools/mpich/bin

# export FC=${mpichpath}/mpif90
# export CC=${mpichpath}/mpicc
# export CXX=${mpichpath}/mpic++

# export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
# 					-DCMAKE_INSTALL_PREFIX=$HOME/lammps/obj_bin \
# 					-DMPI_C_COMPILER=${mpichpath}mpicc \
# 					-DMPI_CXX_COMPILER=${mpichpath}mpicxx \
# 					-DCMAKE_C_COMPILER=${mpichpath}mpicc \
# 					-DCMAKE_CXX_COMPILER=${mpichpath}mpicxx \
# 					-DBUILD_MPI=on \
# 					-DBUILD_OMP=on \
# 					-DPKG_BODY=on \
# 					-DPKG_MOLECULE=on \
# 					-DPKG_RIGID=on \
# 					-DPKG_KSPACE=on \
# 					-DLAMMPS_PNG=on \
# 					-DLAMMPS_JPEG=on \
# 					-DLAMMPS_FFMPEG=on \
# 					-DPKG_VTK=ON \
# 					-DPKG_HDF5=ON \
# 					-DBUILD_SHARED_LIBS=yes \
# 					-DFMT=internal \
# "
# cmake -S cmake/ -B build/ ${CMAKE_OPTS}
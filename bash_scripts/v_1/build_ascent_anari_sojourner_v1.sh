#!/bin/bash

##############################################################################
# Demonstrates how to manually build Ascent and its dependencies, including:
#
#  hdf5, conduit, vtk-m, mfem, raja, anari and umpire
#
# usage example:
#   env enable_mpi=ON enable_openmp=ON ./build_ascent.sh
#
#
# Assumes: 
#  - cmake is in your path
#  - selected compilers (including nvcc) are in your path or set via env vars
#  - [when enabled] MPI and Python (+numpy and mpi4py), are in your path
#
##############################################################################

mpich_dir=${HOME}/tools/mpich
ascent_dir=${HOME}/ascent_anari/obj_bin
echo "Setting MPICH:"

export CC=${mpich_dir}/bin/mpicc
export CXX=${mpich_dir}/bin/mpic++
export FTN=${mpich_dir}/bin/mpif90

export MPICXX=${mpich_dir}/bin/mpic++
export MPI_CXX_COMPILER=${mpich_dir}/bin/mpic++
export MPIEXEC_EXECUTABLE=${mpich_dir}/bin/mpiexec

# export CMAKE_ARGS="-DENABLE_FIND_MPI_TARGETS=OFF"

set -eu -o pipefail

# 2024-10-14 ANARI support is handled by our unified script
# env build_anari=true enable_mpi=ON ./build_ascent.sh

export enable_find_mpi="${enable_find_mpi:=OFF}"
export enable_mpi="${enable_mpi:=ON}"
export enable_mpicc="${enable_mpicc:=ON}"
export enable_openmp="${enable_openmp:=ON}"
export enable_anari="${enable_anari:=true}"
export build_jobs="${build_jobs:=8}"
export prefix="${ascent_dir}"

source build_ascent.sh

# ascent_dir=${HOME}/ascent_anari/obj_bin
# env build_anari=true enable_mpi=ON prefix:=${ascent_dir} ./build_ascent.sh

# # env prefix= enable_python=OFF enable_mpi=ON enable_fortran=OFF raja_enable_vectorization=OFF enable_tests=ON enable_openmp=ON ./build_ascent.sh
# export ANARI_DIR=${HOME}/ascent/anari_sdk/obj_bin  # Or appropriate path


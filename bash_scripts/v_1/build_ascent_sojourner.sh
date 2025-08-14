#!/bin/bash -l

mpich_dir=${HOME}/tools/mpich
ascent_dir=${HOME}/ascent_anari/obj_bin
echo "Setting MPICH:"

export CC=${mpich_dir}/bin/mpicc
export CXX=${mpich_dir}/bin/mpic++
export FTN=${mpich_dir}/bin/mpif90

export MPICXX=${mpich_dir}/bin/mpic++

export MPI_C_COMPILER=${mpich_dir}/bin/mpicc
export MPI_CXX_COMPILER=${mpich_dir}/bin/mpic++
export MPIEXEC_EXECUTABLE=${mpich_dir}/bin/mpiexec

# env prefix= enable_python=OFF enable_mpi=ON enable_fortran=OFF raja_enable_vectorization=OFF enable_tests=ON enable_openmp=ON ./build_ascent.sh
export ANARI_DIR=${HOME}/ascent/anari_sdk/obj_bin  # Or appropriate path

export enable_find_mpi="${enable_find_mpi:=OFF}"
export enable_mpi="${enable_mpi:=ON}"
export enable_openmp="${enable_openmp:=ON}"
export enable_anari="${enable_anari:=true}"
export build_jobs="${build_jobs:=20}"
export prefix="${ascent_dir}"

source build_ascent.sh

# env enable_python=ON enable_mpi=ON enable_openmp=ON prefix=<ascent_install_dir> ./scripts/build_ascent/build_ascent.sh

# export CC=$(which mpicc)
# export CXX=$(which mpic++)
# export FTN=$(which mpif90)

#!/bin/bash
export PYTHON_DIR=${DAIMSL_DIR}/daimsl_venv/venv/
export ASCENT_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin
export anari_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin/install/anari-v0.10.0

export Python_ROOT_DIR=${PYTHON_DIR}

export enable_anari="${enable_anari:=true}"
export build_anari="${build_anari:=true}"
export enable_find_mpi="${enable_find_mpi:=OFF}"
export enable_mpi="${enable_mpi:=ON}"
export enable_mpicc="${enable_mpicc:=ON}"
export enable_openmp="${enable_openmp:=ON}"
export enable_python="${enable_python:=OFF}"
export BUILD_SHARED_LIBS="${BUILD_SHARED_LIBS:=ON}"
export build_jobs="${build_jobs:=8}"
export prefix="${ASCENT_DIR}"

# ./build_ascent.sh

# ascent_dir=${HOME}/ascent_anari/obj_bin
# env build_anari=true enable_mpi=ON prefix:=${ascent_dir} ./build_ascent.sh

# # env prefix= enable_python=OFF enable_mpi=ON enable_fortran=OFF raja_enable_vectorization=OFF enable_tests=ON enable_openmp=ON ./build_ascent.sh
# export ANARI_DIR=${HOME}/ascent/anari_sdk/obj_bin  # Or appropriate path

# export Python_FIND_VIRTUALENV
# export Python_EXECUTABLE
# export Python_LIBRARY
# export Python_NumPy_INCLUDE_DIR

# export CMAKE_ARGS="-DENABLE_FIND_MPI_TARGETS=OFF"
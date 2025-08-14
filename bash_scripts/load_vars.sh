#!/bin/bash

export DAIMSL_DIR=${HOME}/DAIMSL
export DAIMSL_SCRIPTS_DIR=${DAIMSL_DIR}/DAIMSL_Interface/bash_scripts
export DAIMSL_TOOLS_DIR=${DAIMSL_DIR}/tools

# MPICH
export MPICH_DIR=${DAIMSL_TOOLS_DIR}/mpich

export CC=${MPICH_DIR}/bin/mpicc
export CXX=${MPICH_DIR}/bin/mpic++
export FTN=${MPICH_DIR}/bin/mpif90

export MPICXX=${MPICH_DIR}/bin/mpic++

export MPI_C_COMPILER=${MPICH_DIR}/bin/mpicc
export MPI_CXX_COMPILER=${MPICH_DIR}/bin/mpic++
export MPIEXEC_EXECUTABLE=${MPICH_DIR}/bin/mpiexec
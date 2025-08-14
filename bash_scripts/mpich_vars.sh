#!/bin/sh

# MPICH
mypath=${DAIMSL_TOOLS_DIR}/mpich

subdir=$mypath/bin
if [ -d "$subdir" ]; then
	export PATH=$subdir:$PATH
fi

subdir=$mypath/lib
if [ -d "$subdir" ]; then
	export LIBRARY_PATH=$subdir:$LIBRARY_PATH
	export LD_LIBRARY_PATH=$subdir:$LD_LIBRARY_PATH
fi

subdir=$mypath/lib64
if [ -d "$subdir" ]; then
	export LIBRARY_PATH=$subdir:$LIBRARY_PATH
	export LD_LIBRARY_PATH=$subdir:$LD_LIBRARY_PATH
fi

subdir=$mypath/include
if [ -d "$subdir" ]; then
	export CPATH=$subdir:$CPATH
	export C_INCLUDE_PATH=$subdir:$C_INCLUDE_PATH
	export CPLUS_INCLUDE_PATH=$subdir:$CPLUS_INCLUDE_PATH
fi

subdir=$mypath/lib/pkgconfig
if [ -d "$subdir" ]; then
	export PKG_CONFIG_PATH=$subdir:$PKG_CONFIG_PATH
fi

export MPICH_DIR=${DAIMSL_TOOLS_DIR}/mpich

export CC=${MPICH_DIR}/bin/mpicc
export CXX=${MPICH_DIR}/bin/mpic++
export FTN=${MPICH_DIR}/bin/mpif90

export MPICXX=${MPICH_DIR}/bin/mpic++

export MPI_C_COMPILER=${MPICH_DIR}/bin/mpicc
export MPI_CXX_COMPILER=${MPICH_DIR}/bin/mpic++
export MPIEXEC_EXECUTABLE=${MPICH_DIR}/bin/mpiexec
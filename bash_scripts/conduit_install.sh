#!/bin/sh

# Conduit
conduitpath=${HOME}/conduit/
sourcepath=${conduitpath}/install-debug/
objpath=${conduitpath}/obj_bin

export FC=mpif90
export CC=mpicc

export CMAKE_OPTS=" -DCMAKE_BUILD_TYPE=Debug \
		    -DENABLE_MPI=ON \
		    -DHDF5_DIR=/home/droaperdomo/tools/hdf5_bin"


export CONDUIT_DIR=$objpath



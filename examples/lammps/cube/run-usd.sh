#!/bin/bash
#
# export LD_LIBRARY_PATH=~/ANARI-USD/obj_bin/lib:~/OpenUSD/obj_bin/lib:$LD_LIBRARY_PATH
export ANARI_LIBRARY=usd

export PROG=lammps_mpi_ascent

mpirun -n 1 ./${PROG}.o -in in.lj 

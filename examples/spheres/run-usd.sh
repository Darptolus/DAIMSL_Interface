#!/bin/bash
#
# export LD_LIBRARY_PATH=~/ANARI-USD/obj_bin/lib:~/OpenUSD/obj_bin/lib:$LD_LIBRARY_PATH
export ANARI_LIBRARY=usd

export PROG=spheres_ascent_anari

mpirun -n 1 ./${PROG} -in in.lj 

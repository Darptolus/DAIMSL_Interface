#!/bin/bash
# export MPICH_DIR=${DAIMSL_TOOLS_DIR}/mpich

# export CC=${MPICH_DIR}/bin/mpicc
# export CXX=${MPICH_DIR}/bin/mpic++
# export FTN=${MPICH_DIR}/bin/mpif90

# export MPICXX=${MPICH_DIR}/bin/mpic++

export CONDUIT_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin/install/conduit-v0.9.4
export ANARI_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin/install/anari-v0.10.0 
export ASCENT_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin/install/ascent-checkout
export ANARIUSD_DIR=${DAIMSL_DIR}/anariusd/obj_bin

mpic++ cube_ascent_anari.cpp -o cube_ascent_anari.o \
  -I${CONDUIT_DIR}/include/conduit \
  -L${CONDUIT_DIR}/lib \
  -I${ASCENT_DIR}/include/ascent \
  -L${ASCENT_DIR}/lib \
  -I${ANARI_DIR}/include/anari \
  -L${ANARI_DIR}/lib \
  -L${ANARIUSD_DIR}/lib \
  -L/usr/lib/python3.12/config-3.12-x86_64-linux-gnu/ \
  -std=c++17 -ldl -lm -fopenmp \
  -lanari \
  -lpython3.12 \
  -lascent -lconduit -lconduit_blueprint -lconduit_relay \
  -ljpeg -lpng -lfftw3 -lfftw3_threads
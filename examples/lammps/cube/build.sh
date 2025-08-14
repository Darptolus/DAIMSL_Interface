#!/bin/bash
# export MPICH_DIR=${DAIMSL_TOOLS_DIR}/mpich

# export CC=${MPICH_DIR}/bin/mpicc
# export CXX=${MPICH_DIR}/bin/mpic++
# export FTN=${MPICH_DIR}/bin/mpif90

# export MPICXX=${MPICH_DIR}/bin/mpic++

export LAMMPS_DIR=${DAIMSL_DIR}/lammps/obj_bin
export CONDUIT_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin/install/conduit-v0.9.4
export ANARI_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin/install/anari-v0.10.0 
export ASCENT_DIR=${DAIMSL_DIR}/ascent_anari/obj_bin/install/ascent-checkout
export ANARIUSD_DIR=${DAIMSL_DIR}/anariusd/obj_bin
export PROG=lammps_mpi_ascent

mpic++ ${PROG}.cpp -o ${PROG}.o \
  -L${LAMMPS_DIR}/lib \
  -I${LAMMPS_DIR}/include/lammps \
  -I${CONDUIT_DIR}/include/conduit \
  -L${CONDUIT_DIR}/lib \
  -I${ASCENT_DIR}/include/ascent \
  -L${ASCENT_DIR}/lib \
  -I${ANARI_DIR}/include/anari \
  -L${ANARI_DIR}/lib \
  -L${ANARIUSD_DIR}/lib \
  -std=c++17 -ldl -lm -fopenmp \
  -lanari \
  -lascent -lconduit -lconduit_blueprint -lconduit_relay \
  -ljpeg -lpng -lfftw3 -lfftw3_threads -llammps 




# export CONDUIT_DIR=${HOME}/ascent_anari/obj_bin/install/conduit-v0.9.4
# export ANARI_DIR=${HOME}/ascent_anari/obj_bin/install/anari-v0.10.0 
# export ANARISDK_DIR=${HOME}/anarisdk/obj_bin/
# export OPENUSD_DIR=${HOME}/openusd2411/obj_bin/
# export ASCENT_DIR=${HOME}/ascent_anari/obj_bin/install/ascent-checkout
# export LAMMPS_DIR=${HOME}/lammps/obj_bin

# # mpic++ lammps_ascent_mpi_v2.cpp -o lammps_ascent_mpi_v2 \
# # mpic++ lammps_ascent_anari_mpi_v1.cpp -o lammps_ascent_anari_mpi_v1 \
# mpic++ lammps_ascent_anari_mpi_v0.cpp -o lammps_ascent_anari_mpi_v0 \
#   -L${LAMMPS_DIR}/lib \
#   -I${LAMMPS_DIR}/include/lammps \
#   -I${CONDUIT_DIR}/include/conduit \
#   -L${CONDUIT_DIR}/lib \
#   -I${ASCENT_DIR}/include/ascent \
#   -L${ASCENT_DIR}/lib \
#   -I${ANARI_DIR}/include/anari \
#   -L${ANARI_DIR}/lib \
#   -I${OPENUSD_DIR}/include/pxr \
#   -L${OPENUSD_DIR}/lib \
#   -I${ANARISDK_DIR}/include/anari \
#   -L${ANARISDK_DIR}/lib \
#   -I${ANARISDK_DIR}/include/anari/backend \
#   -std=c++17 -ldl -lm -fopenmp \
#   -lanari \
#   -lascent -lconduit -lconduit_blueprint -lconduit_relay \
#   -ljpeg -lpng -lfftw3 -lfftw3_threads -llammps 

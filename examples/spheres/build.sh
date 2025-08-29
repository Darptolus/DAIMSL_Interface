#!/bin/bash
mpichdir=${HOME}/tools/mpich

export CC=${mpich_dir}/bin/mpicc
export CXX=${mpich_dir}/bin/mpic++
export FTN=${mpich_dir}/bin/mpif90

export MPICXX=${mpich_dir}/bin/mpic++

export CONDUIT_DIR=${HOME}/ascent_anari/obj_bin_p/install/conduit-v0.9.4
export ANARI_DIR=${HOME}/ascent_anari/obj_bin_p_v0/install/anari-v0.10.0 
export ASCENT_DIR=${HOME}/ascent_anari/obj_bin_p/install/ascent-checkout
export ANARIUSD_DIR=${HOME}/anariusd/obj_bin_p

export PROG=spheres_ascent_anari

# mpic++ lammps_ascent_mpi_v2.cpp -o lammps_ascent_mpi_v2 \
# mpic++ lammps_ascent_anari_mpi_v1.cpp -o lammps_ascent_anari_mpi_v1 \
mpic++ ${PROG}.cpp -o ${PROG} \
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

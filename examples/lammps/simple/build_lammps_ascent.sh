#!/bin/bash
mpic++ -D_USE_ASCENT="True" \
  -L${LAMMPS_DIR}/lib \
  -I${LAMMPS_DIR}/include/lammps \
  -I${CONDUIT_DIR}/include/conduit \
  -I${ASCENT_DIR}/include/ascent \
  -L${CONDUIT_DIR}/lib -lconduit \
  -L${ASCENT_DIR}/lib \
  -std=c++17 -ldl -lm -fopenmp \
  -lanari \
  -lascent -lconduit -lconduit_blueprint -lconduit_relay \
  -ljpeg -lpng -lfftw3 -lfftw3_threads -llammps \
  examples/lammps/simple/lammps_mpi_ascent.cpp -o examples/lammps/simple/lammps_mpi_ascent.o -llammps
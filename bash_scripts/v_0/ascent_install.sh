#!/bin/sh

# Ascent
ascentpath=${HOME}/lammps
objpath=${ascentpath}/obj_bin
mpichpath=${HOME}/tools/mpich/bin

export FC=${mpichpath}/mpif90
export CC=${mpichpath}/mpicc
export CXX=${mpichpath}/mpic++

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
					-DCMAKE_INSTALL_PREFIX=${objpath} \
					-DMPI_C_COMPILER=${mpichpath}/mpicc \
					-DMPI_CXX_COMPILER=${mpichpath}/mpicxx \
					-DCMAKE_C_COMPILER=${mpichpath}/mpicc \
					-DCMAKE_CXX_COMPILER=${mpichpath}/mpicxx \
					-DVTKm_ENABLE_ANARI=ON \
					-DBUILD_SHARED_LIBS=yes \
"
cmake -S cmake/ -B build/ ${CMAKE_OPTS}

# cmake --build build --parallel 4
# cmake --install build


# cd build
# $(nproc)

# make -j$(nproc)
# make install
#!/bin/bash

# OpenUSD
openusdpath=${HOME}/openusd
objpath=${openusdpath}/obj_bin
mpichpath=${HOME}/tools/mpich/bin
onetbbpath=${HOME}/onetbb/obj_bin
opensubdivpath=${HOME}/opensubdiv/obj_bin

export FC=${mpichpath}/mpif90
export CC=${mpichpath}/mpicc
export CXX=${mpichpath}/mpic++

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
										-DCMAKE_BUILD_TYPE=Release \
										-DCMAKE_INSTALL_PREFIX=${objpath} \
										-DMPI_C_COMPILER=${mpichpath}/mpicc \
										-DMPI_CXX_COMPILER=${mpichpath}/mpicxx \
										-DCMAKE_C_COMPILER=${mpichpath}/mpicc \
										-DCMAKE_CXX_COMPILER=${mpichpath}/mpicxx \
										-DTBB_ROOT_DIR=${onetbbpath} \
										-DOPENSUBDIV_ROOT_DIR=${opensubdivpath} \
										-DPXR_BUILD_PYTHON_SUPPORT=OFF \
										-DPXR_ENABLE_PYTHON_SUPPORT=FALSE \
										-DBUILD_SHARED_LIBS=ON \
										-DPXR_BUILD_USDVIEW=OFF \
										-DBoost_NO_BOOST_CMAKE=ON \
"
cmake -S . -B build/ ${CMAKE_OPTS}

# cmake --build build --parallel 4
# cmake --install build

# cmake                                       \
# -DTBB_ROOT_DIR=/path/to/tbb                 \
# -DOPENSUBDIV_ROOT_DIR=/path/to/opensubdiv   \
# /path/to/USD/source

# cmake --build . --target install -- -j <NUM_CORES>


cmake --build build --parallel 4
cmake --install build
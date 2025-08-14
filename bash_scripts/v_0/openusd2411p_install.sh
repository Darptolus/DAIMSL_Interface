#!/bin/bash

# OpenUSD
openusdpath=${HOME}/openusd2411
objpath=${openusdpath}/obj_bin_p
mpichpath=${HOME}/tools/mpich/bin
onetbbpath=${HOME}/onetbb2021/obj_bin
opensubdivpath=${HOME}/opensubdiv/obj_bin

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
										-DBUILD_SHARED_LIBS=ON \
										-DPXR_ENABLE_PYTHON_SUPPORT=TRUE \
										-DPXR_BUILD_USDVIEW=OFF \
"
cmake -S . -B build/ ${CMAKE_OPTS}
cmake --build build --parallel 4
cmake --install build

# -DPXR_BUILD_MONOLITHIC=ON



# -DPXR_PY_UNDEFINED_DYNAMIC_LOOKUP=ON


										# -DUSD_USE_PYTHON=OFF \
										# -DPXR_BUILD_PYTHON_SUPPORT=OFF \
  									# -DBUILD_PYTHON_BINDINGS=OFF \
										# -DBoost_NO_BOOST_CMAKE=ON \


# cmake                                       \
# -DTBB_ROOT_DIR=/path/to/tbb                 \
# -DOPENSUBDIV_ROOT_DIR=/path/to/opensubdiv   \
# /path/to/USD/source

# cmake --build . --target install -- -j <NUM_CORES>


# cmake --build build --parallel 4
# cmake --install build
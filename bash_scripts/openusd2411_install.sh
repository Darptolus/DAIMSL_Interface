#!/bin/bash

# OpenUSD
openusdpath=${DAIMSL_TOOLS_DIR}/openusd2411
objpath=${openusdpath}/obj_bin
onetbbpath=${DAIMSL_TOOLS_DIR}/onetbb2021/obj_bin
opensubdivpath=${DAIMSL_TOOLS_DIR}/opensubdiv/obj_bin

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
                    -DCMAKE_BUILD_TYPE=Release \
                    -DCMAKE_INSTALL_PREFIX=${objpath} \
                    -DTBB_ROOT_DIR=${onetbbpath} \
                    -DOPENSUBDIV_ROOT_DIR=${opensubdivpath} \
                    -DPXR_BUILD_PYTHON_SUPPORT=ON \
                    -DPXR_ENABLE_PYTHON_SUPPORT=TRUE \
                    -DBUILD_SHARED_LIBS=ON \
                    -DPXR_BUILD_USDVIEW=OFF \
                    -DBoost_NO_BOOST_CMAKE=ON \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

# cmake                                       \
# -DTBB_ROOT_DIR=/path/to/tbb                 \
# -DOPENSUBDIV_ROOT_DIR=/path/to/opensubdiv   \
# /path/to/USD/source

# cmake --build . --target install -- -j <NUM_CORES>


# cmake --build build --parallel 4
# cmake --install build
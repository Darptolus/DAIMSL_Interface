#!/bin/sh

# OneTBB 2021
onetbbpath=${DAIMSL_TOOLS_DIR}/onetbb2021
objpath=${onetbbpath}/obj_bin

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
                    -DCMAKE_INSTALL_PREFIX=${objpath} \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

# cd build
# $(nproc)

# make -j$(nproc)
# make install
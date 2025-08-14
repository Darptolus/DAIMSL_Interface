#!/bin/sh

# OpenSubdiv
opensubdivpath=${DAIMSL_TOOLS_DIR}/opensubdiv
glfwpath=${DAIMSL_TOOLS_DIR}/glfw/obj_bin
objpath=${opensubdivpath}/obj_bin

export CMAKE_OPTS=" -DCMAKE_CXX_STANDARD=17 \
                    -DCMAKE_INSTALL_PREFIX=${objpath} \
                    -DBUILD_SHARED_LIBS=ON \
                    -DGLFW_LOCATION=${glfwpath} \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

# cd build
# $(nproc)

# make -j$(nproc)
# make install
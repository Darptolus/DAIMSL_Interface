#!/bin/sh

# Anari-SDK
anarisdk=${HOME}/anarisdk
objpath=${anarisdk}/obj_bin

anaripath=${HOME}/ascent/anari_sdk/obj_bin
openusd=${HOME}/openusd/obj_bin

export CMAKE_OPTS=" \
  -DCMAKE_CXX_STANDARD=17 \
  -DCMAKE_INSTALL_PREFIX=${objpath} \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
"
cmake -S . -B build/ ${CMAKE_OPTS}

cmake --build build --parallel 4
cmake --install build

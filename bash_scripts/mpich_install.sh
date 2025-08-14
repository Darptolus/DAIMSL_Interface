#!/bin/bash

wget https://www.mpich.org/static/downloads/4.3.1/mpich-4.3.1.tar.gz

tar xzvf mpich-4.3.1.tar.gz
cd mpich-4.3.1
./configure --prefix=${DAIMSL_TOOLS_DIR}/mpich --enable-shared
make -j
make -j install

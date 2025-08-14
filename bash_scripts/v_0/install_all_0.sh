#!/bin/bash
source ~/daimsl_venv/venv/bin/activate
source ~/tools/mpich_vars.sh

cd ~/ascent_anari/
rm -rf obj_bin_p
cd scripts/build_ascent/
source build_ascent_anari_sojourner_v0.sh 
./build_ascent_anari_sojourner.sh 

source ~/tools/zlib_vars.sh
source ~/tools/hdf5_vars.sh
source ~/tools/anarisdk_vars.sh
source ~/tools/conduit_vars.sh
source ~/tools/ascent_anari_vars.sh

source ~/tools/onetbb2021_vars.sh
source ~/tools/opensubdiv_vars.sh 
source ~/tools/glfw_vars.sh
source ~/tools/connectsamples_vars.sh

source ~/tools/openusd2411p_vars.sh

source ~/tools/anariusd_vars.sh
cd ~/anariusd
rm -rf build/ obj_bin_p
./anariusdp_install.sh

# DAIMSL Interface
Installation scripts to integrate HPC simulations with a visualization environment

```
cd ${HOME}
mkdir DAIMSL
cd DAIMSL
git clone https://github.com/Darptolus/DAIMSL_Interface
mkdir tools
```

## 0. Load initial variables
```
cd DAIMSL_Interface/bash_scripts
chmod +x *.sh
source load_vars_0.sh
```
## 1. Prerequisites

### Linux Workstation
```
sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y git python3 pciutils build-essential gcc cmake curl python3-pip python3-venv libfftw3-dev libjpeg-dev libpng-dev mpich libmpich-dev mpich-doc nvidia-cuda-toolkit libxi-dev libxrandr-dev libxcursor-dev libxinerama-dev ffmpeg libhdf5-dev hdf5-tools zlib1g-dev libvtk9-dev qtbase5-dev libwayland-dev libxkbcommon-dev xorg-dev libboost-program-options-dev libboost-all-dev libtbb-dev libglfw3-dev libglew-dev libglm-dev libgl1-mesa-dev libx11-dev nlohmann-json3-dev
```

### Polaris

```
module load craype-accel-nvidia80
module swap PrgEnv-nvhpc PrgEnv-gnu
module use /soft/modulefiles
module load cudatoolkit-standalone
module load spack-pe-base cmake

module load gcc-native/12.3
module load cray-mpich/8.1.28

module load cce/17.0.0
module load nvhpc/23.9
module load nvidia/23.9

module load craype-network-ucx
module load cray-mpich-ucx/8.1.28

module load cray-hdf5

export MPICH_DIR=/opt/cray/pe/mpich/8.1.28/ucx/gnu/12.3/

export CC=${MPICH_DIR}/bin/mpicc
export CXX=${MPICH_DIR}/bin/mpic++
export FTN=${MPICH_DIR}/bin/mpif90

export MPICXX=${MPICH_DIR}/bin/mpic++

export MPI_C_COMPILER=${MPICH_DIR}/bin/mpicc
export MPI_CXX_COMPILER=${MPICH_DIR}/bin/mpic++
export MPIEXEC_EXECUTABLE=/opt/cray/pals/1.3.4/bin/mpiexec
```


## 2. Set Up Python Environment
```
cd ${DAIMSL_DIR}

mkdir daimsl_venv
python3 -m venv ./daimsl_venv
source daimsl_venv/bin/activate
pip install ipykernel python-dotenv Jinja2 PyOpenGL PySide6
```


## 3. MPI Installation
```
cd ${DAIMSL_TOOLS_DIR}
ln -s ${DAIMSL_SCRIPTS_DIR}/mpich_install.sh mpich_install.sh
./mpich_install.sh

```
### Update MPI Variables
```
source ${DAIMSL_SCRIPTS_DIR}/mpich_vars.sh
```

## 4. Ascent+Anari Installation
```
cd ${DAIMSL_DIR}
git clone --recursive -b task/2025_05_develop_anari --depth=1 https://github.com/Alpine-DAV/ascent/ ascent_anari
cd ascent_anari
git submodule init
git submodule update

source ${DAIMSL_SCRIPTS_DIR}/ascent_anari_init.sh
```
Make sure to use anari_version=0.10.0
Add installation directory to .gitignore
```
echo "obj_bin" >> .gitignore
```

Install
```
cd scripts/build_ascent/
ln -s ${DAIMSL_SCRIPTS_DIR}/build_ascent_anari_daimsl.sh build_ascent_anari_daimsl.sh
./build_ascent_anari_daimsl.sh

```

### Update Ascent Variables
```
source ${DAIMSL_SCRIPTS_DIR}/ascent_vars.sh
```
### Update Conduit Variables
```
source ${DAIMSL_SCRIPTS_DIR}/conduit_vars.sh
```
### Update Anari Variables
```
source ${DAIMSL_SCRIPTS_DIR}/anari_vars.sh
```
### Update AnariSDK Variables
```
source ${DAIMSL_SCRIPTS_DIR}/anarisdk_vars.sh
```
### Update HDF5 Variables
```
source ${DAIMSL_SCRIPTS_DIR}/hdf5_vars.sh
```
### Update zlib Variables
```
source ${DAIMSL_SCRIPTS_DIR}/zlib_vars.sh
```

## 5. OneTBB Installation
```
cd ${DAIMSL_TOOLS_DIR}
git clone --branch v2021.13.0 --depth=1 https://github.com/oneapi-src/oneTBB.git onetbb2021
cd onetbb2021
mkdir build
echo "obj_bin" >> .gitignore

ln -s ${DAIMSL_SCRIPTS_DIR}/onetbb2021_install.sh onetbb2021_install.sh

./onetbb2021_install.sh

```
### Update OneTBB Variables
```
source ${DAIMSL_SCRIPTS_DIR}/onetbb2021_vars.sh
```

## 6. GLFW Installation
```
cd ${DAIMSL_TOOLS_DIR}
git clone --recursive --depth=1 https://github.com/glfw/glfw glfw
cd glfw
git submodule update --init --recursive
mkdir build
echo "obj_bin" >> .gitignore

ln -s ${DAIMSL_SCRIPTS_DIR}/glfw_install.sh glfw_install.sh
./glfw_install.sh

```

### Update GLFW Variables
```
source ${DAIMSL_SCRIPTS_DIR}/glfw_vars.sh
```

## 7. OpenSubdiv Installation
```
cd ${DAIMSL_TOOLS_DIR}
git clone https://github.com/PixarAnimationStudios/OpenSubdiv opensubdiv
cd opensubdiv
mkdir build
echo "obj_bin" >> .gitignore

ln -s ${DAIMSL_SCRIPTS_DIR}/opensubdiv_install.sh opensubdiv_install.sh
./opensubdiv_install.sh
```

### Update OpenSubdiv Variables
```
source ${DAIMSL_SCRIPTS_DIR}/opensubdiv_vars.sh
```

## 8. OpenUSD Installation (v24.11)
```
cd ${DAIMSL_TOOLS_DIR}
git clone -b v24.11 --depth=1 https://github.com/PixarAnimationStudios/OpenUSD openusd2411
cd openusd2411
echo "obj_bin" >> .gitignore

ln -s ${DAIMSL_SCRIPTS_DIR}/openusd2411_install.sh openusd2411_install.sh
./openusd2411_install.sh
```

### Update OpenUSD Variables
```
source ${DAIMSL_SCRIPTS_DIR}/openusd2411_vars.sh
```

## 9. Connect-Samples Installation
```
cd ${DAIMSL_TOOLS_DIR}
git clone --depth=1 https://github.com/NVIDIA-Omniverse/connect-samples connectsamples
cd connectsamples
./repo.sh build
./repo.sh install_sdk
```

### Update Connect-Samples Variables
```
source ${DAIMSL_SCRIPTS_DIR}/connectsamples_vars.sh
```

## 10. Anari-USD Installation
```
cd ${DAIMSL_DIR}
git clone --recursive https://github.com/NVIDIA-Omniverse/ANARI-USD anariusd
cd anariusd
git submodule update --init --recursive
echo "obj_bin" >> .gitignore

ln -s ${DAIMSL_SCRIPTS_DIR}/anariusd_install.sh anariusd_install.sh
./anariusd_install.sh
```

### Update Anari-USD Variables
```
source ${DAIMSL_SCRIPTS_DIR}/anariusd_vars.sh
```

## 11. LAMMPS Installation
```
cd ${DAIMSL_DIR}
git clone -b release --depth=1 https://github.com/lammps/lammps.git lammps
cd lammps

ln -s ${DAIMSL_SCRIPTS_DIR}/lammps_install.sh lammps_install.sh
./lammps_install.sh
```

### Update LAMMPS Variables
```
source ${DAIMSL_SCRIPTS_DIR}/lammps_vars.sh
```

## 12. Tests

### Cube USD
```
cd ${DAIMSL_DIR}/DAIMSL_Interface/examples/cube
./build.sh
export ANARI_LIBRARY=usd
./run-usd.sh
```
Generates USD inside folder Session_

### LAMMPS Cube USD
```
cd ${DAIMSL_DIR}/DAIMSL_Interface/examples/lammps/cube
./build.sh
export ANARI_LIBRARY=usd
./run-usd.sh
```
Generates USD inside folder Session_



## All Vars
### Script
```
cd ${DAIMSL_DIR}/DAIMSL_Interface/bash_scripts/
```

### Manual 
```
cd ${DAIMSL_DIR}
source daimsl_venv/bin/activate
source ${DAIMSL_SCRIPTS_DIR}/load_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/mpich_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/ascent_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/conduit_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/anari_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/anarisdk_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/hdf5_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/zlib_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/onetbb2021_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/glfw_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/opensubdiv_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/openusd2411_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/connectsamples_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/anariusd_vars.sh
source ${DAIMSL_SCRIPTS_DIR}/lammps_vars.sh

```
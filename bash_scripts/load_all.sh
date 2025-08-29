#!/bin/bash

# Exit if any file fails to source
# set -e
export DAIMSL_DIR=${HOME}/DAIMSL
export DAIMSL_SCRIPTS_DIR=${DAIMSL_DIR}/DAIMSL_Interface/bash_scripts

source ${DAIMSL_DIR}/daimsl_venv/bin/activate

# List of environment scripts
ENV_SCRIPTS=(
  "${DAIMSL_SCRIPTS_DIR}/load_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/mpich_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/ascent_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/conduit_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/anari_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/anarisdk_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/hdf5_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/zlib_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/onetbb2021_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/glfw_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/opensubdiv_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/openusd2411_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/connectsamples_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/anariusd_vars.sh"
  "${DAIMSL_SCRIPTS_DIR}/lammps_vars.sh"
)

for script in "${ENV_SCRIPTS[@]}"; do
  if [[ -f "$script" ]]; then
    echo "Sourcing $script"
    # Use "." to source in the current shell
    . "$script"
    wait
  else
    echo "Warning: $script not found. Skipping."
  fi
done

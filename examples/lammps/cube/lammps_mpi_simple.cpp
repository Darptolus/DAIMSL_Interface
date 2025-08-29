#include <iostream>
#include <string>
#include "lammps.h"
#include "input.h"
#include "atom.h"
#include "update.h"
#include <mpi.h>

using namespace LAMMPS_NS;

int main(int argc, char **argv)
{
  MPI_Init(&argc, &argv);  
  
  // Create LAMMPS instance
  LAMMPS *lmp = new LAMMPS(argc, argv, MPI_COMM_WORLD);

  // Run input script (e.g., in.lj)
  lmp->input->file();

  // Dump mpg
  lmp->input->one("dump mv all movie 1 lammps_box.mpg type type");
  lmp->input->one("dump_modify mv pad 4");

  for(int i=0; i<20; ++i) {
    lmp->input->one("run 10 post no");
  }
  
  // Cleanup
  delete lmp;

  MPI_Finalize(); 
  return 0;
}
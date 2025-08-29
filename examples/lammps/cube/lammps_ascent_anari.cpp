#include <iostream>
#include <string>

#define _USE_ASCENT

#if defined(_USE_ASCENT)
#include "ascent.hpp"
#include "conduit.hpp"
#include "conduit_blueprint.hpp"
#endif

#include "lammps.h"
#include "input.h"
#include "atom.h"
#include "update.h"
#include <mpi.h>

// anari
#define ANARI_EXTENSION_UTILITY_IMPL
#include "anari/anari_cpp.hpp"
#include "anari/anari_cpp/ext/std.h"
// stb_image
// #include "stb_image_write.h"

using namespace LAMMPS_NS;
#if defined(_USE_ASCENT)
using namespace ascent;
using namespace conduit;
#endif

// helper to convert LAMMPS atoms to a Conduit mesh
#if defined(_USE_ASCENT)
void lammps_atoms_to_conduit_mesh(LAMMPS *lmp, Node &mesh)
{
  Atom *atom = lmp->atom;
  int nlocal = atom->nlocal;
  double **x = atom->x;
  double **v = atom->v;  // Velocity array

  // Allocate temporary arrays
  float *x_vals = new float[nlocal];
  float *y_vals = new float[nlocal];
  float *z_vals = new float[nlocal];

  float *vx_vals = new float[nlocal];
  float *vy_vals = new float[nlocal];
  float *vz_vals = new float[nlocal];

  for (int i = 0; i < nlocal; i++) {
    // Position
    x_vals[i] = static_cast<float>(x[i][0]);
    y_vals[i] = static_cast<float>(x[i][1]);
    z_vals[i] = static_cast<float>(x[i][2]);
    // Velocity
    vx_vals[i] = static_cast<float>(v[i][0]);
    vy_vals[i] = static_cast<float>(v[i][1]);
    vz_vals[i] = static_cast<float>(v[i][2]);
  }

  float *speed_vals = new float[nlocal];
  for (int i = 0; i < nlocal; ++i) {
      float vx = vx_vals[i];
      float vy = vy_vals[i];
      float vz = vz_vals[i];
      speed_vals[i] = std::sqrt(vx * vx + vy * vy + vz * vz);
  }
  // Create explicit coordinate set
  mesh["coordsets/coords/type"] = "explicit";
  mesh["coordsets/coords/values/x"].set_external(x_vals, nlocal);
  mesh["coordsets/coords/values/y"].set_external(y_vals, nlocal);
  mesh["coordsets/coords/values/z"].set_external(z_vals, nlocal);

  // Define topology (points)
  mesh["topologies/topo/type"] = "points";
  mesh["topologies/topo/coordset"] = "coords";

  // Add velocity as a vector field
  mesh["fields/velocity/association"] = "vertex";
  mesh["fields/velocity/topology"] = "topo";
  mesh["fields/velocity/values"].set_external(speed_vals, nlocal);

  // Add simulation time
  mesh["state/time"] = lmp->update->ntimestep;
}
#endif


int main(int argc, char **argv)
{
  MPI_Init(&argc, &argv);

#if defined(_USE_ASCENT)
  // Get Ascent about info
  Node ascent_info;
  ascent::about(ascent_info);
  std::cout << "Ascent Config:\n" << ascent_info.to_yaml() << std::endl;
#endif
  
  // Create LAMMPS instance
  LAMMPS *lmp = new LAMMPS(argc, argv, MPI_COMM_WORLD);

  // Run input script (e.g., in.lj)
  lmp->input->file();

#ifndef _USE_ASCENT
// Dump PNGs
// lmp->input->one("dump img all image 1 img.*.jpg type type zoom 1.6 adiam 1");
// lmp->input->one("dump_modify img pad 4");

// Dump mpg
  lmp->input->one("dump mv all movie 1 movie_1.mpg type type");
  lmp->input->one("dump_modify mv pad 4");
#endif 

  for(int i=0; i<2; ++i) {
    lmp->input->one("run 10 post no");
    
#if defined(_USE_ASCENT)
  // Convert atom data to Conduit mesh
  Node mesh;
  lammps_atoms_to_conduit_mesh(lmp, mesh);
  
  // Start Ascent and publish mesh
  Ascent a;
  a.open();
  a.publish(mesh);
  
  // Define actions
  Node actions;
  Node &add_act = actions.append();
  
  add_act["action"] = "add_scenes";
  Node &scenes = add_act["scenes"]; 
  //scenes["scene1/plots/plot1/type"] = "anari_point";
  scenes["scene1/plots/plot1/type"] = "anari_pseudocolor";
  scenes["scene1/plots/plot1/field"] = "velocity";
  // scenes["scene1/renders/r1/type"] = "anari_points";
  scenes["scene1/renders/r1/image_prefix"] = "anari_render";
  scenes["scene1/renders/r1/camera/look_at"] = {0, 0, 0};
  scenes["scene1/renders/r1/camera/position"] = {25.0, 25.0, 25.0};
  scenes["scene1/renders/r1/image_width"] = 1024;
  scenes["scene1/renders/r1/image_height"] = 768;

  std::cout << "Ascent Actions:\n" << actions.to_yaml() << std::endl;
  
  // Render
  a.execute(actions);

  a.close();

#endif
  }
  
  // Cleanup
  delete lmp;

  MPI_Finalize(); 
  return 0;
}
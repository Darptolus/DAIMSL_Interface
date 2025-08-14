#include <iostream>
#include <string>

#define _USE_ASCENT

#if defined(_USE_ASCENT)
#include "ascent.hpp"
#include "conduit.hpp"
#include "conduit_blueprint.hpp"
#endif

// anari
#define ANARI_EXTENSION_UTILITY_IMPL
#include "anari/anari_cpp.hpp"
#include "anari/anari_cpp/ext/std.h"
// stb_image
// #include "stb_image_write.h"

#if defined(_USE_ASCENT)
using namespace ascent;
using namespace conduit;
#endif

#if defined(_USE_ASCENT)
void create_cube_mesh(conduit::Node &mesh)
{
  const int nx = 16, ny = 16, nz = 16;
  conduit::blueprint::mesh::examples::braid("uniform", nx, ny, nz, mesh);

  // Overwrite field to a velocity magnitude
  float *vx = new float[nx * ny * nz];
  for (int i = 0; i < nx * ny * nz; ++i)
    vx[i] = static_cast<float>(std::sin(i * 0.01)); // synthetic field

  mesh["fields/velocity/association"] = "vertex";
  mesh["fields/velocity/topology"] = "mesh";
  mesh["fields/velocity/values"].set_external(vx, nx * ny * nz);
  mesh["state/time"] = 0.0;
}
#endif

int main(int argc, char **argv)
{

#if defined(_USE_ASCENT)
  conduit::Node ascent_info;
  ascent::about(ascent_info);
  std::cout << "Ascent Config:\n" << ascent_info.to_yaml() << std::endl;

  conduit::Node mesh;
  create_cube_mesh(mesh);

  Ascent a;
  a.open();
  a.publish(mesh);

  conduit::Node actions;
  actions.load("ascent_actions.yaml", "yaml");

  // conduit::Node &add_act = actions.append();
  // add_act["action"] = "add_scenes";
  // conduit::Node &scenes = add_act["scenes"];
  // scenes["scene1/plots/plot1/type"] = "pseudocolor";
  // scenes["scene1/plots/plot1/field"] = "velocity";
  // scenes["scene1/renders/r1/image_prefix"] = "cube_render";
  // scenes["scene1/renders/r1/camera/look_at"] = {0, 0, 0};
  // scenes["scene1/renders/r1/camera/position"] = {25.0, 25.0, 25.0};
  // scenes["scene1/renders/r1/image_width"] = 1024;
  // scenes["scene1/renders/r1/image_height"] = 768;

  std::cout << "Ascent Actions:\n" << actions.to_yaml() << std::endl;
  a.execute(actions);
  a.close();
#endif

  return 0;
}
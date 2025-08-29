#include <iostream>
#include <cmath>
#include <cstdlib>
#include <ctime>

#define _USE_ASCENT

#if defined(_USE_ASCENT)
#include "ascent.hpp"
#include "conduit.hpp"
#include "conduit_blueprint.hpp"
#endif

using namespace ascent;
using namespace conduit;

void create_spheres_as_points(Node &mesh, int n, float r)
{
  float *x_vals = new float[n];
  float *y_vals = new float[n];
  float *z_vals = new float[n];
  float *velocity_vals = new float[n];

  std::srand(static_cast<unsigned int>(std::time(nullptr)));

  for (int i = 0; i < n; ++i)
  {
    x_vals[i] = static_cast<float>((std::rand() % 100) / 10.0f - 5.0f);
    y_vals[i] = static_cast<float>((std::rand() % 100) / 10.0f - 5.0f);
    z_vals[i] = static_cast<float>((std::rand() % 100) / 10.0f - 5.0f);

    // Use distance from origin as synthetic "velocity"
    float vx = x_vals[i], vy = y_vals[i], vz = z_vals[i];
    velocity_vals[i] = std::sqrt(vx * vx + vy * vy + vz * vz);
  }

  // Set coordinates
  mesh["coordsets/coords/type"] = "explicit";
  mesh["coordsets/coords/values/x"].set_external(x_vals, n);
  mesh["coordsets/coords/values/y"].set_external(y_vals, n);
  mesh["coordsets/coords/values/z"].set_external(z_vals, n);

  // Topology (points)
  mesh["topologies/topo/type"] = "points";
  mesh["topologies/topo/coordset"] = "coords";

  // Field: velocity (for pseudocolor)
  mesh["fields/velocity/association"] = "vertex";
  mesh["fields/velocity/topology"] = "topo";
  mesh["fields/velocity/values"].set_external(velocity_vals, n);

  // Time
  mesh["state/time"] = 0.0;
}

int main(int argc, char **argv)
{
  const int n = 10;
  // const float r = 0.5f;
  const float r = 10.0f;

  Node mesh;
  create_spheres_as_points(mesh, n, r);

  // Create output directory
  system("mkdir -p render");

  // Print Ascent config
  Node ascent_info;
  ascent::about(ascent_info);
  std::cout << "Ascent Info:\n" << ascent_info.to_yaml() << std::endl;

  // Load actions
  Node actions;
  actions.load("ascent_actions.yaml", "yaml");

  // Run Ascent
  Ascent a;
  a.open();
  a.publish(mesh);
  a.execute(actions);
  a.close();

  return 0;
}

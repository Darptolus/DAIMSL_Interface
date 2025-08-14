# python_scripts/mpich_vars.py
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--print", type=lambda x: x.lower() == "true", default=False)
args = parser.parse_args()

mypath = "/home/droaperdomo/tools/mpich"
output = []

def add_path(env_var, subdir):
    full_path = os.path.join(mypath, subdir)
    if os.path.isdir(full_path):
        output.append(f'export {env_var}="{full_path}:${{{env_var}:-}}"')

# Define paths
add_path("PATH", "bin")
add_path("LIBRARY_PATH", "lib")
add_path("LD_LIBRARY_PATH", "lib")
add_path("LIBRARY_PATH", "lib64")
add_path("LD_LIBRARY_PATH", "lib64")
add_path("CPATH", "include")
add_path("C_INCLUDE_PATH", "include")
add_path("CPLUS_INCLUDE_PATH", "include")
add_path("PKG_CONFIG_PATH", "lib/pkgconfig")

# Write to file
with open("mpich_env.sh", "w") as f:
    f.write("\n".join(output) + "\n")

if args.print:
    print("\n".join(output))
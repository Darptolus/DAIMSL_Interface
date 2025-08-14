import os
import subprocess
import argparse

# --- Argument parsing ---
parser = argparse.ArgumentParser(description="Set environment variables for a toolchain.")
parser.add_argument("-p", "--print", type=lambda x: x.lower() == "true", default=False,
                    help="Print environment variables after setting them (true/false)")
args, unknown = parser.parse_known_args()  # allow running inside Jupyter

# Set your base path (e.g., to MPICH or other toolchain)
mypath = "/home/droaperdomo/tools/mpich"

# Define mapping of subdirs to environment variables
paths = {
    "bin": ["PATH"],
    "lib": ["LIBRARY_PATH", "LD_LIBRARY_PATH"],
    "lib64": ["LIBRARY_PATH", "LD_LIBRARY_PATH"],
    "include": ["CPATH", "C_INCLUDE_PATH", "CPLUS_INCLUDE_PATH"],
    "lib/pkgconfig": ["PKG_CONFIG_PATH"]
}

def prepend_env(var, value):
    current = os.environ.get(var, "")
    if value not in current.split(":"):
        os.environ[var] = f"{value}:{current}" if current else value

# Apply the changes
for subdir, env_vars in paths.items():
    full_path = os.path.join(mypath, subdir)
    if os.path.isdir(full_path):
        for var in env_vars:
            prepend_env(var, full_path)

# --- Optionally print updated env vars ---
if args.print:
    print("Updated environment variables:")
    for var in sorted(set(sum(paths.values(), []))):
        print(f"{var} = {os.environ.get(var)}")

# --- Example subprocess test ---
try:
    result = subprocess.run(
        ["mpicc", "--version"],
        env=os.environ.copy(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True
    )
    print("mpicc --version output:")
    print(result.stdout)
except subprocess.CalledProcessError as e:
    print("Error running mpicc:", e.stderr)
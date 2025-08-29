#!/bin/bash

# ffmpeg -framerate 2 -i lammps_cube_%04d.png -c:v libx264 -pix_fmt yuv420p output.mp4
ffmpeg -f concat -safe 0 -r 1 -i frames.txt -c:v libx264 -pix_fmt yuv420p lammps_box_ascent.mp4

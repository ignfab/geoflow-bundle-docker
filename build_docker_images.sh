#!/usr/bin/env bash

# In case the repository was not cloned with --recurse-submodules
git submodule update --init --recursive

# Define number of cores for compilation
CORES=$(($(nproc)-2))

# Build base image
docker build -f base.dockerfile --no-cache --build-arg JOBS=$CORES -t ignfab/geoflow-bundle-base:latest .

# Build builder image based on base image
docker build -f builder.dockerfile --no-cache --build-arg JOBS=$CORES -t ignfab/geoflow-bundle-builder:latest . 

# Create reconstruct image with single workflow
docker build -f lod22-reconstruct.dockerfile --no-cache -t ignfab/lod22-reconstruct:latest .

# Create reconstruct image with batch workflow
docker build -f lod22-reconstruct-batch.dockerfile --no-cache -t ignfab/lod22-reconstruct-batch:latest .

# Create reconstruct image with stream workflow
docker build -f lod22-reconstruct-stream.dockerfile --no-cache -t ignfab/lod22-reconstruct-stream:latest .

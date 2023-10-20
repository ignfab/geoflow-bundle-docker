git submodule update --init --recursive
CORES=$(($(nproc)-2))
docker build -f base.dockerfile --no-cache --build-arg JOBS=$CORES -t ignfab/geoflow-bundle-base:latest .
docker build -f builder.dockerfile --no-cache --build-arg JOBS=$CORES -t ignfab/geoflow-bundle-builder:latest . 
docker build -f lod22-reconstruct.dockerfile --no-cache -t ignfab/lod22-reconstruct:latest .
docker build -f lod22-reconstruct-batch.dockerfile --no-cache -t ignfab/lod22-reconstruct-batch:latest .
docker build -f lod22-reconstruct-stream.dockerfile --no-cache -t ignfab/lod22-reconstruct-stream:latest .

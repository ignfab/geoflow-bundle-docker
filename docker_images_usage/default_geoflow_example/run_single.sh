#!/usr/bin/env bash
WORKING_DIR="test-data"
if [ -d $WORKING_DIR ]
then 
    rm -Rf $WORKING_DIR
fi
wget "https://data.3dgi.xyz/geoflow-test-data/wippolder.zip"
unzip wippolder.zip -d $WORKING_DIR
rm wippolder.zip
docker pull ignfab/lod22-reconstruct:latest
docker run --rm \
    -v "$(pwd)/$WORKING_DIR:/data" \
    ignfab/lod22-reconstruct:latest \
    --input_footprint=/data/wippolder.gpkg \
    --input_pointcloud=/data/wippolder.las \
    --output_cityjson=/data/model.json

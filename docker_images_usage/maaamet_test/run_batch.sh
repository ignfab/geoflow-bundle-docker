#!/usr/bin/env bash
WORKING_DIR="geoflow_estonia"

docker pull ignfab/lod22-reconstruct-batch:latest
time docker run --rm \
    -v "$(pwd)/$WORKING_DIR:/data" \
    ignfab/lod22-reconstruct-batch:latest \
    -V \
    --input_footprint=/data/tartu_buildings_test.gpkg \
    --input_pointcloud=/data/473658_2022_madal.laz \
    --output_cityjson=/data/tartu_test.json \
    --output_cj_referenceSystem="https://www.opengis.net/def/crs/EPSG/0/3301" \
    --building_identifier=OGRLoader.etak_id
    # other possible outputs
    # --output_ogr=/data/tartu_test_2d.gpkg \
    # --output_obj_lod12=/data/tartu_test_lod12.obj \
    # --output_obj_lod13=/data/tartu_test_lod13.obj \
    # --output_obj_lod22=/data/tartu_test_lod22.obj \

docker pull tudelft3d/cjio:latest
docker run --rm -v "$(pwd)/$WORKING_DIR:/data" \
    tudelft3d/cjio:latest \
    cjio /data/tartu_test.json lod_filter 2.2 save /data/tartu_test_lod22.json 

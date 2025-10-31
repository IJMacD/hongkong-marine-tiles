#!/bin/bash
set -e

download=/tmp/hongkong-marine

mbtiles_tmp_dir=$download/mbtiles
tiles_tmp_dir=$download/tiles

mbtiles_target_dir=${MBTILES_TARGET_DIR:-"/mbtiles"}
tiles_target_dir=${TILES_TARGET_DIR:-"/tiles"}

# Don't create actual tiles_tmp_dir; mbutil complains
mkdir -p $mbtiles_tmp_dir $(dirname $tiles_tmp_dir)

(cd $mbtiles_tmp_dir && python3 /usr/src/app/download.py)

if [ ! -f $mbtiles_tmp_dir/*.mbtiles ]; then
    echo "[Error] Unable to download mbtiles file"
    cat $mbtiles_tmp_dir/*
    exit 1
fi

cp $mbtiles_tmp_dir/*.mbtiles "$mbtiles_target_dir"

./mb-util --silent "$mbtiles_tmp_dir/"*.mbtiles $tiles_tmp_dir

cp -r $tiles_tmp_dir/* "$tiles_target_dir"

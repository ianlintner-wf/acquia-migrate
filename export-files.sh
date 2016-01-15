#!/bin/bash
#ARG1 site
#ARG2 env
#ARG3 file path
#ARG4 date
#example
#./export-files.sh workivainternal prod sites/default/files-private

export_dir=$HOME/export
archive=files-export.tar.gz
file_path=/mnt/files/$1.$2/$3
mkdir -p $export_dir


if [ ! -z $4 ]
then
  echo "tar -zcvf --after-date=$4 \"$export_dir/$archive\" -C $file_path ."
  tar -zcvf "$export_dir/$archive" -C $file_path . --after-date="$4"
else
  echo "tar -zcvf \"$export_dir/$archive\" -C $file_path ."
  tar -zcvf  "$export_dir/$archive" -C $file_path .
fi

echo $export_dir/$archive

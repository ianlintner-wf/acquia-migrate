#!/bin/bash
#ARG1 site
#ARG2 env
#ARG3 file path

$export_dir=$HOME/export
$archive=files-export.tar.gz
$file_path=/mnt/files/$1.$2/$3
mkdir $export_dir

tar -zcvf "$export_dir/$archive" $file_path
echo $export_dir/$archive

#!/usr/bin/env bash
#Arg1 source server hostname
#Arg2 source server site
#Arg3 source server enviornment

source_server=$2.$3@$1
file_to_copy=”$HOME/export/files-export.tar.gz”
target_file=$HOME/import/files/files-export.tar.gz

#create if does not exist
mkdir -p ~/import/files

#cd to import folder
cd ~/import/files

#copy the files
echo "copying $file_to_copy from $source_server to $target_file"
scp $source_server:$file_to_copy $target_file

ssh $source_server "rm
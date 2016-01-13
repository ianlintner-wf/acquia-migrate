#!/usr/bin/env bash
#Arg1 source server hostname
#Arg2 source server site
#Arg3 source server environment

source_server=$2.$3@$1
file_to_copy="./export/files-export.tar.gz"
target_file="$HOME/import/files/files-export.tar.gz"

#create if does not exist
mkdir -p ~/import/files

#copy the files
echo "copying $file_to_copy from $source_server to $target_file"
scp $source_server:$file_to_copy $target_file

read -p "Do you want to delete remote file? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo "removing $file_to_copy on $1"
ssh $source_server "rm $file_to_copy"

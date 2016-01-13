#!/bin/bash
#ARG1 site
#ARG2 env
#ARG3 database
#ARG4 export file (optional) defaults to $HOME/export/backup.sql.gz

if [ ! -z $4 ]
then
    file_to_export=$4
else
    file_to_export="./export/backup.sql.gz"
fi
file_to_copy="ls $backup_dir/*$4*.sql.gz | tail -1"
cp $file_to_copy $file_to_export
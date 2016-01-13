#!/bin/bash
#ARG1 site
#ARG2 env
#ARG3 database
#ARG4 export file (optional) defaults to $HOME/export/backup.sql.gz

if [ ! -z $4 ]
then
    $file_to_export=$4
else
    $file_to_export=$HOME/export/backup.sql.gz
fi

backup_dir="/mnt/files/$2.$3/backups/on-demand/"
drush @$1.$2 ac-database-instance-backup $3
file_to_copy="ls $backup_dir/$2-$3-*.sql.gz | head -1"
cp $file_to_copy $file_to_export

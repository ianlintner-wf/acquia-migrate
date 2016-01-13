#!/bin/bash
#ARG1 site
#ARG2 env
#ARG3 database

backup_dir="/mnt/files/$2.$3/backups/on-demand/"
drush @$1.$2 ac-database-instance-backup $3
file_to_copy="ls $backup_dir/$2-$3-*.sql.gz | head -1"

#!/usr/bin/env bash
#Runs the entire SQL IMPORT Process

#ARG1 source server
#ARG2 source site
#ARG3 source env
#ARG4 source filepath

#ARG5 target site
#ARG6 target env
#ARG7 target filepath

#ARG8 date

#Example
#./migrate_files.sh srv-1234.devcloud.hosting.acquia.com pubsite prod sites/default/files-private pubsite dev sites/default/files-private

server=$2.$3@$1

echo "Running sql export on $1"
ssh $server "bash -s" < ./export-files.sh "$2" "$3" "$4" "$8"

echo "Transfering backup file from $1"
./transfer-files-backup.sh $1 $2 $3

echo "Running drush import on @$5.$6 for db $7"
./import-files.sh $5 $6 $7

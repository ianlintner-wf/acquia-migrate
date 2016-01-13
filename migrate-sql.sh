#!/usr/bin/env bash
#Runs the entire SQL IMPORT Process

#ARG1 source server
#ARG2 source site
#ARG3 source env
#ARG4 source db

#ARG5 target site
#ARG6 target env
#ARG7 target db

echo "Running sql export on $1"
ssh $server "bash -s" < ./export-sql.bash "$2" "$3" "$4"

echo "Transfering backup file from $1"
transfer_sql_backup.sh $1 $2 $3

echo "Running drush import on @$5.$6 for db $7"
import-sql $5 $6 $7

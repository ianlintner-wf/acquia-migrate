#!/usr/bin/env bash
#Runs the entire SQL IMPORT Process

#ARG1 source server
#ARG2 source site
#ARG3 source env
#ARG4 source db

#ARG5 target site
#ARG6 target env
#ARG7 target db

#ARG8 site url

server=$2.$3@$1

echo "Running sql export on $1"
ssh $server "bash -s" < ./export-sql.sh "$2" "$3" "$4"

echo "Transfering backup file from $1"
transfer-sql-backup.sh $1 $2 $3

echo "Running drush import on @$5.$6 for db $7"
if [ ! -z $4 ]
then
    ./import-sql.sh $5 $6 $7 $8
else
    drush @$1.$2 ah-db-import $file_to_import --db=$3 --drop --force
fi




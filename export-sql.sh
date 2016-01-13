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

backup_dir="/mnt/files/$2.$3/backups/on-demand"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

json="$(drush @$1.$2 ac-database-instance-backup $3 --format=json)"
id="$(echo $json | sed "s/},/\n/g" | sed 's/.*"id":"\([^"]*\)".*/\1/')"
echo "task id: $id"
oldlogs=""
while [[ $state != "done" && $state != "error" ]]
do
  # Checking consumes resources, so wait for 3 seconds between checks.
  sleep 3
  json="$(drush @$1.$2 ac-task-info $id --format=json)"
  state="$(echo $json | sed "s/},/\n/g" | sed 's/.*"state":"\([^"]*\)".*/\1/')"
  newlogs="$(echo $json | sed "s/},/\n/g" | sed 's/.*"logs":"\([^"]*\)".*/\1/')"
  if [[ $newlogs != $oldlogs ]]
  then
    logdiff=${newlogs//"$oldlogs"/}
    logdiff=${logdiff//"\n"/}
    if [[ $logdiff != "" ]]
    then
      echo "    $logdiff"
    fi
  fi
  oldlogs="$newlogs"
done

if [[ $state = "error" ]]
then
  echo -e "    State: ${RED}$state${NC}"
  exit 1
else
  echo -e "    State: ${GREEN}$state${NC}"
  echo "copy file"
  file_to_copy="ls $backup_dir/*$4*.sql.gz | tail -1"
  cp $file_to_copy $file_to_export
fi
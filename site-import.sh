#!/usr/bin/env bash
#ARG1 source server hostname
#ARG2 source server site
#ARG3 source server enviornment

#Arg4 target server site
#ARG5 target server env

#example
#./site-import.sh 1234@acquia.devcloud.com pubsite prod pubsite prod

source_server=$2.$3@$1
export_file="~/export/site.tar.gz"
import_file="~/import/site.tar.gz"
ssh $source_server "mkdir -p ~/export"
ssh $source_server "drush @$2.$3 archive-dump --destination=$export_file"
scp $source_server:$export_file $import_file
drush @$4.$5 ah-site-archive-import $import_file

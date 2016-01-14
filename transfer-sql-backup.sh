#Arg1 source server hostname
#Arg2 source server site
#Arg3 source server enviornment
#Arg4 import file location this server
#Arg5 export file location source server

#Example import-sql.sh srv-1234.devcloud.hosting.acquia.com pubsite dev

if [ ! -z $4 ]
then
    file_to_import=$4
else
    file_to_import=$HOME/import/sql/backup.sql.gz
fi

if [ ! -z $5 ]
then
    file_to_export=$5
else
    file_to_export=./export/backup.sql.gz
fi

#create if does not exist
mkdir -p $HOME/import/sql

#cd to import folder
source_server=$2.$3@$1

file_to_copy=$HOME/export/backup.sql.gz

scp $source_server:"$file_to_export" $file_to_import

echo "cleaning up transfered file"
ssh $source_server "rm $file_to_export"
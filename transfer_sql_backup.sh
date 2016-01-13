#Arg1 source server hostname
#Arg2 source server site
#Arg3 source server enviornment
#Example import-sql.sh srv-1234.devcloud.hosting.acquia.com pubsite dev

#create if does not exist
mkdir -p $HOME/import/sql

#cd to import folder
$file_to_copy $HOME/import/sql/backup.sql.gz
source_server=$2.$3@$1

file_to_copy=$HOME/export/backup.sql.gz
scp $source_server:"$file_to_copy" backup.sql.gz
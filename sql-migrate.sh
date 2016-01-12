#Arg1 source server hostname
#Arg2 source server site
#Arg2 source server enviornment
#Arg3 target server site
#Arg4 target server enviornment
#Example sql-migrate.sh srv-1234.devcloud.hosting.acquia.com pubsite dev

#create if does not exist
mkdir -p ~/import/sql

#cd to import folder
cd ~/import/sql
source_server=$2.$3@$1
#backup directory
backup_dir="/mnt/files/$2.$3/backups/on-demand/"
file_to_copy=`ssh $source_server "ls $backup_dir | head -1"`
scp $source_server:"$backup_dir/$file_to_copy" backup.sql.gz
drush @$3.$4 ah-db-import ~/import/sql/backup.sql.gz

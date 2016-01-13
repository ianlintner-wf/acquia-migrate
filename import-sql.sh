#ARG1 site
#ARG2 env
#ARG3 db
#Example pubsite dev pubsite

#create if does not exist
echo "Running drush import"
drush @$1.$2 ah-db-import ~/import/sql/backup.sql.gz --db=$3

#ARG1 site
#ARG2 env
#ARG3 db
#ARG4 site (optional)
#ARG4 file (optional)
#Example pubsite dev pubsite


#create if does not exist
echo "Running drush import"



if [ ! -z $5 ]
then
    file_to_import=$4
else
    file_to_import=$HOME/import/sql/backup.sql.gz
fi

if [ ! -z $4 ]
then
    drush @$1.$2 ah-db-import $file_to_import -l $4 --db=$3 --drop --force
else
    drush @$1.$2 ah-db-import $file_to_import --db=$3 --drop --force
fi

echo "cleaning up import file"
rm $file_to_import

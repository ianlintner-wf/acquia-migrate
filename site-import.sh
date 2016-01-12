
$source_server=$2.$3@$1
$export_file="~/export/site.tar.gz"
$import_file="~/import/site.tar.gz"
ssh $source_server "mkdir -p ~/export"
ssh $source_server "drush @$2.$3 archive-dump --destination=$export_file"
scp $source_server:$export_file $import_file
drush @$4.$5 ah-site-archive-import $import_file

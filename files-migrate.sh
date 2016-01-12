#Arg1 source server hostname
#Arg2 source server site
#Arg2 source server enviornment
#Arg3 source files directory
#Arg4 target server site
#Arg5 target server enviornment
#Arg6 target server files directory
#Example sql-migrate.sh srv-1234.devcloud.hosting.acquia.com pubsite dev sites/defaul/private-files pubsite dev sites/default/private-files

#create if does not exist
mkdir -p ~/import/files

#cd to import folder
cd ~/import/files
source_server=$2.$3@$1
#backup directory
backup_dir="/mnt/files/$2.$3/$4"
file_to_copy=”~/export/files-export.tar.gz”
scp $server:$file_to_copy files-private.tar.gz
tar -xvf files-export.tar.gz
mv -v files-export/* /mnt/files/$2.$3/$4
rm -rf files-export
rm files-export.tar.gz
ssh $server 'rm $file_to_copy'

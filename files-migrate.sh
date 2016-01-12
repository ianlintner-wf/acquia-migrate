#Arg1 source server hostname
#Arg2 source server site
#Arg2 source server enviornment
#Arg3 source files directory
#Arg4 target server site
#Arg5 target server enviornment
#Arg6 target server files directory
#Example
#./files-migrate.sh srv-1234.devcloud.hosting.acquia.com pubsite dev sites/default/private-files pubsite dev sites/default/private-files

#variables
source_server=$2.$3@$1
backup_dir="/mnt/files/$2.$3/$4"
file_to_copy=”$HOME/export/files-export.tar.gz”
target_file=~/import/files/files-export.tar.gz

#create if does not exist
mkdir -p ~/import/files

#cd to import folder
cd ~/import/files

#run archive
echo "connecting to $source_server..."
echo "creating directory if necessary on $source_server..."
ssh $source_server 'mkdir $HOME/export'

echo "tar $backup_dir to $file_to_copy on $source_server..."
ssh $source_server "tar -zcvf $file_to_copy $backup_dir"

#copy the files
echo "copying $file_to_copy from $source_server to $target_file"
scp $source_server:$file_to_copy $target_file

echo "extracting file $target_file"
tar -xvf $target_file

echo "moving files to /mnt/files/$4.$5/$6"
mv -v files-export/* /mnt/files/$4.$5/$6

#clean up this server
echo "removing temp directory files-export"
rm -rf files-export

echo "removing $target_file"
rm $target_file

#clean up source server
echo "removing archive on $source_server"
ssh $source_server 'rm $file_to_copy'

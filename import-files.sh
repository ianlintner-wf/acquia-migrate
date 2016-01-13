#Arg1 target server site
#Arg2 target server enviornment
#Arg3 target server files directory
#Example
#./import-files.sh pubsite dev sites/default/private-files

#variables
target_file="$HOME/import/files/files-export.tar.gz"
extracted_dir=$HOME/import/files/files-export

echo "extracting file $target_file"
tar -xvf $target_file -C $extracted_dir

echo "moving files to /mnt/files/$1.$2/$3"
mv -v $extracted_dir/* /mnt/files/$1.$2/$3

#clean up this server
echo "removing temp directory files-export"
rm -rf files-export

echo "removing $target_file"
rm $target_file

read -p "Do you want to delete archive file? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo "removing $file_to_copy on $1"
rm $file_to_copy
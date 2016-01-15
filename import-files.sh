#Arg1 target server site
#Arg2 target server enviornment
#Arg3 target server files directory
#Example
#./import-files.sh pubsite dev sites/default/private-files

#variables
target_file="$HOME/import/files/files-export.tar.gz"
extracted_dir=$HOME/import/files/files-export

mkdir -p $extracted_dir

echo "extracting file $target_file"
tar -xvf $target_file -C $extracted_dir

echo "copying files to /mnt/files/$1.$2/$3"
cp -fRuv $extracted_dir/* /mnt/files/$1.$2/$3


read -p "Do you want to delete archive file? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo "removing $file_to_copy on $1"
rm $target_file
rm -rf $extracted_dir
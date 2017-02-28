#!/bin/bash
## author Koshuba V.O. - master@qbpro.ru
## The script is copying files from the given extensions .. (weak version of the processor)
#date
rdate=`date +%d.%m.%y_%H:%M`
#logfile
log=/var/log/syslog

#the master directory on the server
smbuser=( user1 user2 user3 user4 );
smbgroup=( group1 group2 group3 group4 )
## allowed extensions
tru_file=( "bmp"
	   "doc"
	   "docx"
	   "jpg"
	   "mdb"
	   "odb"
	   "odt"
	   "pdf"
	   "PST"
	   "QST"
	   "shx"
	   "tif"
	   "ttf"
	   "txt"
	   "xls"
	   "xlsx"
	   "xml"
	   "rtf"
	   "ods" );
# synchronize directories
get_dir=( "/work/share"
	 "/work/share"
	 "/share2"
	 "/share2" );
# directly copied directories
read_dir=( "work1"
	 "work2"
	 "work3"
	 "work4" );
# directories to backup files
put_dir=( "/arhive/copy_share"
	 "/arhive/copy_share"
	 "/arhive/copy_share"
	 "/arhive/copy_share" );
#------------------------------------------------
echo `date +%d.%m.%y_%H:%M` "Begin syncing files on the server...">>$log
# Copy the specified directory on the server and update Regulations
# We will perform the cycle until the end of the array of names
for ((i_names=0; i_names != ${#get_dir[@]}; i_names++))
    do
    cd ${get_dir[$i_names]};
# We will perform the cycle until the end of the array of allowed extensions
    for ((i_ex=0; i_ex != ${#tru_file[@]}; i_ex++))
	do
	find ${read_dir[$i_names]} -type 'f' -name "*.${tru_file[$i_ex]}" -exec cp -r -f --parent -t ${put_dir[$i_names]} '{}' \;
    done
# Assign user permissions
chmod -R 0666 ${put_dir[$i_names]}/${read_dir[$i_names]};
chmod -R ugo+X ${put_dir[$i_names]}/${read_dir[$i_names]};
chown -R ${smbuser[$i_names]}:${smbgroup[$i_names]} ${put_dir[$i_names]}/${read_dir[$i_names]};
done

# 
echo `date +%d.%m.%y_%H:%M` "Leaving syncing files on the server...">>$log
exit 0

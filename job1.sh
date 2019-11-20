#!/bin/bash

MAXSIZE=1048272               #1048272  = 1 Mb
NCHAR_LINE=15 
REMOVED_LINE=0
FILENAME="testr.txt"
FILESORTED="sort1.txt"
FILEDEL1="borrado.txt"
FILENEW1="withouta.txt"
SIZEFILE=0 

#If file exists, delete and generate 

if [ -f $FILENAME ]
then 
   echo 'Procesando .....'
   rm -r $FILENAME 
   touch $FILENAME
  
fi

while [ $SIZEFILE -le $MAXSIZE ]
do 

  cadena=$( tr -dc a-z0-9A-Z < /dev/urandom |head -c $NCHAR_LINE) # && echo ''

  echo $cadena >> $FILENAME

  SIZEFILE=$(stat -c %s $FILENAME )
   
done


if [ -f $FILENAME ]
then 
rm -r $FILESORTED 
touch $FILESORTED
fi

# sort -b $FILENAME
sort  -b $FILENAME  > $FILESORTED

if [ -f $FILEDEL1 ]
then 
   
   rm -r $FILEDEL1 
fi

# If file exists, delete and generate  

sed  -n '/^[a|A]/p' $FILESORTED > $FILEDEL1

if [ -f $FILENEW1 ]
then 
   
   rm -r $FILENEW1 
fi

# Remove lines with start with a|A  
sed  -e '/^[a|A]/d' $FILESORTED > $FILENEW1

datafile=$(du -bsh $FILENAME)

echo 'Size and file:  ' $datafile
echo 'Sorted File :  ' $FILESORTED
echo 'File without initial a or A: ' $FILENEW1

rmlines=$(<$FILEDEL1 wc -l)
echo 'Removed lines:   ' $rmlines

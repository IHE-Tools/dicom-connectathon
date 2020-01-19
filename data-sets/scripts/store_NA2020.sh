#!/bin/sh

# store_NA2020.sh
#  Stores a set of DICOM files found under a common folder
#  to the IHE Central Archive
#
#  * All input folders have been created using get_NA2020.sh
#    or created by hand.
#  * All input folders contain DICOM images only and nothing else.
#  * Subfolders are allowed as the DCM4CHE application can search
#    folders recursively.
#
# Arguments: [ FOLDER ]
#   If you include the FOLDER argument, that identifies the top level input folder
#   Otherwise, the default output folder is /opt/connectathon-2020/data-sets


# Function: my_cstore
# Arguments: folder title host port
# Result:
#  * Calls ./store.sh with these same arguments
#  * Exits with status 1 if error

my_cstore() {
 echo my_cstore: $*
 ./store.sh $*
 if [ $? -ne 0 ] ; then
  echo "Store $FOLDER DCM4CHEE localhost 11112 failed"
  exit 1
 fi
}

# Main starts here

echo Start at `date`

BASE_FOLDER=/opt/connectathon-2020/data-sets
if [ $# -ne 0 ] ; then
 BASE_FOLDER=$1
fi

echo Base folder: $BASE_FOLDER
if [ ! -e $BASE_FOLDER ] ; then
 echo The base folder you specified does not exist: $BASE_FOLDER
 exit 1
fi


for folder in $BASE_FOLDER/* ; do
 echo $folder
 my_cstore $folder DCM4CHEE localhost 11112
done

echo Done at `date`

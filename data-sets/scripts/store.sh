#!/bin/sh

check_args() {
 if [ ! $# -eq 4 ]; then
  echo "Arguments: <folder> <AE title> host port"
  echo Script exiting: store.sh
  exit 1
 fi
}

check_folder() {
 if [ ! -e $1 ]; then
  echo Folder -- $1 -- not found
  echo Please make sure the folder exists and contains DICOM images
  echo Script exiting: store.sh
  exit 1
 fi
}

check_application() {
 which $1 > /dev/null 2>&1
 if [ $? != 0 ]; then
  echo Your path does not include -- $1 -- "(DCM4CHE)"
  echo Please install and/or update your path
  echo Script exiting: store.sh
  exit 1
 fi
}

STORE=storescu
check_application $STORE

check_args $*

FOLDER=$1
AE=$2
HOST=$3
PORT=$4
check_folder $FOLDER

echo $STORE -c $AE@$HOST:$PORT $FOLDER
     $STORE -c $AE@$HOST:$PORT $FOLDER
if [ $? != 0 ]; then
 echo Unable to store images. The command below failed.
 echo $STORE -c $AE@$HOST:$PORT $FOLDER
 echo Script exiting: store.sh
 exit 1
fi

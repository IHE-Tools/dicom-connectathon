#!/bin/sh

check_args() {
 if [ $# -eq 0 ]; then
  echo "Arguments: <ROOT folder>"
  echo Script exiting: get_nmi.sh
  exit 1
 fi
}

check_root() {
 if [ ! -e $1 ]; then
  echo Script assumes the ROOT folder exists
  echo Folder -- $1 -- not found
  echo Please create the folder
  echo Script exiting: get_nmi.sh
  exit 1
 fi
}

confirm_folder() {
 mkdir -p $1
 if mkdir -p $1; then
  echo Folder $1 was created or already existed
 else
  echo Unable to create folder: $1
  echo Script exiting: get_nmi.sh
  exit 1
 fi
}

get_zip() {
 ZIP_FILE=$1/nm-samples.zip
 FTP_URL=ftp://ftp.ihe.net/Connectathon/test_data/RAD-profiles/NMI_image_sets/nm-samples.zip
 if [ -e $ZIP_FILE ]; then
  echo Zip file already exists: $ZIP_FILE
 else
  wget -O $ZIP_FILE $FTP_URL
  if [ $? != 0 ]; then
    echo Unable to retrieve zip with URL $FTP_URL
    echo Script exiting: get_nmi.sh
    exit 1
  fi
 fi
}

unzip_file() {
 ZIP_FILE=$1/nm-samples.zip
 OUTPUT_FOLDER=$2
 unzip -d $OUTPUT_FOLDER $ZIP_FILE
 if [ $? != 0 ]; then
  echo Unable to unzip file
  echo unzip -d $OUTPUT_FOLDER $ZIP_FILE
  echo Script exiting: get_nmi.sh
  exit 1
 fi
}

check_args $*

ROOT=$1
check_root $ROOT

NMI_FOLDER=$ROOT/nmi
NMI_ZIP_FOLDER=$ROOT/nmi-zip
confirm_folder $NMI_FOLDER
confirm_folder $NMI_ZIP_FOLDER

get_zip $NMI_ZIP_FOLDER
unzip_file $NMI_ZIP_FOLDER $NMI_FOLDER

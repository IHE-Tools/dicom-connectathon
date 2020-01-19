#!/bin/bash

# get_NA2020.sh
#  Retrieves DICOM files from the IHE FTP server for the NA2020 Connectathon
#  Issues/differences between folders to accommodate:
#   * Some folders contain only image files
#   * Some folders contain image files + .jpg and/or + DICOMDIR files
#   * Some folders contain image files + zip files
#   * Some folders contain zip files + readme files
#
# This script has hand coded functions to handle the various cases above
# I did not write general purpose software to try to figure things out
#
# When this script is done, the output is a series of distinct folders
# that contain DICOM images and nothing else. These folders are ready to
# be pushed to a PACS
#
# Arguments: [ FOLDER ]
#   If you include the FOLDER argument, the top level output goes to that folder
#   Otherwise, the default output folder is /opt/connectathon-2020/data-sets

# Function: make_folder
# Arguments: folder
# Result:
#  * Removes $folder if it already exists
#  * Creates folder with intermediate folders if necessary
#  * Exits with status 1 if error

make_folder() {
 FOLDER=$1
 if [ -e $FOLDER ] ; then
  rm -r $FOLDER
  if [ $? -ne 0 ] ; then
   echo Could not delete folder $FOLDER
   exit 1
  fi
 fi
 mkdir -p $FOLDER
 if [ $? -ne 0 ] ; then
  echo Could not create folder $FOLDER
  exit 1
 fi

}

# Function: retrieve
# Arguments: folder url
# Result:
#  * Creates $folder
#  * Uses wget -r to pull from URL and deposit files into $folder
#  * Output folder will contain no subfolders (wget -nd)
#  * Exits with status 1 if error

retrieve() {
 FOLDER=$1
 URL=$2
 echo Retrieve: $FOLDER $URL

 make_folder $FOLDER
 pushd $FOLDER
 wget -r -nd $URL
 if [ $? -ne 0 ] ; then
  echo Wget failed for this URL: $URL
  exit 1
 fi
 ls -C

 popd
}

# Function: my_unzip
# Arguments: zip folder
# Result:
#  * Creates $folder
#  * Unzips $zip into folder
#  * Output folder will contain subfolders if the input zip has a folder structure
#  * Exits with status 1 if error

my_unzip() {
 ZIP=$1
 DESTINATION=$2
 echo Unzip: $ZIP $DESTINATION
 make_folder $DESTINATION

 unzip -d $DESTINATION $ZIP
 ls -C $DESTINATION
}

# Function: clean_up
# Arguments: folder extension
# Result:
#  * Removes any file folder that matches $folder/*$extension
#  * Normally called like this: clean_up folder .jpg
#                               clean_up folder DIR   (for DICOMDIR)
#                               clean_up f1 f2        (to recursively remove f1/*f2)
#  * Exits with status 1 if error

clean_up() {
 FOLDER=$1
 EXTENSION=$2
 echo Cleanup: $FOLDER $EXTENSION

 for f in $FOLDER/*$EXTENSION ; do
  echo $f
  rm -rf $f
  if [ $? -ne 0 ] ; then
   echo Could not remove $f
   exit 1
  fi
 done
}

# Main starts here

echo Start at `date`

BASE_FOLDER=/opt/connectathon-2020/data-sets

if [ $# -ne 0 ] ; then
 BASE_FOLDER=$1
fi

echo $BASE_FOLDER


echo To support MAMMO profile tests: 
echo "(3) GE Synocrystal Images from here"

retrieve $BASE_FOLDER/ge_synocrystal	\
	ftp://ftp.ihe.net/Connectathon/samples/RAD-profiles/MAMMO_Samples/2019-EU-Samples/GE%20Senocrystal%20Images/STORE/51346117/70288881


echo "(4) IMSGIOTTO Images from here"
retrieve $BASE_FOLDER/IMSGIOTTO_MOD_RAFFAELLO	\
	ftp://ftp.ihe.net/Connectathon/samples/RAD-profiles/MAMMO_Samples/2018_EU_Samples/IMSGIOTTO_MOD_RAFFAELLO
clean_up	$BASE_FOLDER/IMSGIOTTO_MOD_RAFFAELLO .jpg


echo To support DBT profile tests: 
echo "(5) GE DBT samples from here"
retrieve $BASE_FOLDER/2017-EU-GEHC	\
	ftp://ftp.ihe.net/Connectathon/samples/RAD-profiles/DBT_samples/2017-EU-Samples/GEHC/ 
clean_up	$BASE_FOLDER/2017-EU-GEHC DIR


echo "(6) IMSGIOTTO Images from here"
retrieve $BASE_FOLDER/2018-EU-IMSGIOTTO	\
	ftp://ftp.ihe.net/Connectathon/samples/RAD-profiles/DBT_samples/2018-EU-Samples/
clean_up	$BASE_FOLDER/2018-EU-IMSGIOTTO .jpg


echo "(7) Siemens images from here"
retrieve	$BASE_FOLDER/2017-EU-Siemens	\
	ftp://ftp.ihe.net/Connectathon/samples/RAD-profiles/DBT_samples/2017-EU-Samples/Siemens/ 
clean_up	$BASE_FOLDER/2017-EU-Siemens .jpg
clean_up	$BASE_FOLDER/2017-EU-Siemens DIR

echo "To support REM-NM profile tests: "
echo "(8) GE samples from here:"
retrieve	$BASE_FOLDER/GE_NM_830	\
	ftp://ftp.ihe.net/Connectathon/samples/RAD-profiles/REM-NM_samples/GE_NM_830
my_unzip	$BASE_FOLDER/GE_NM_830/GE-NMI-and-REM-NM-2020.zip	\
		$BASE_FOLDER/GE_NM_830-unzipped
clean_up	$BASE_FOLDER GE_NM_830

echo "(9) Toshiba samples from here:"
retrieve	$BASE_FOLDER/TOCHIBA_NM	\
	ftp://ftp.ihe.net/Connectathon/samples/RAD-profiles/REM-NM_samples/MOD_TOSHIBA_1
my_unzip	$BASE_FOLDER/TOCHIBA_NM/sample_data_1.zip $BASE_FOLDER/TOCHIBA_NM-sample_1
my_unzip	$BASE_FOLDER/TOCHIBA_NM/sample_data_2.zip $BASE_FOLDER/TOCHIBA_NM-sample_2
clean_up	$BASE_FOLDER TOCHIBA_NM

echo TODO	$BASE_FOLDER/2017-EU-Siemens
echo		ZIPs, files or both
ls		$BASE_FOLDER/2017-EU-Siemens

echo Done at `date`

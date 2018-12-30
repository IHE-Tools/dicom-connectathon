#!/bin/sh

check_args() {
 if [ $# -eq 0 ]; then
  echo "Arguments: <ROOT folder>"
  echo Script exiting: slapd_run.sh
  exit 1
 fi
}

check_root() {
 if [ ! -e $1 ]; then
  echo Script assumes the ROOT folder exists and is known to Docker for sharing
  echo Folder -- $1 -- not found
  echo Please create the folder and make sure Docker is sharing it.
  echo Script exiting: slapd_run.sh
  exit 1
 fi
}

confirm_folder() {
 mkdir -p $1
 if mkdir -p $1; then
  echo Folder $1 was created or already existed
 else
  echo Unable to create folder: $1
  echo Script exiting: slapd_run.sh
  exit 1
 fi
}

check_args $*

echo `date` Starting slapd

ROOT=$1
check_root $ROOT
echo ROOT folder: $ROOT

LDAP=$ROOT/dcm4chee/ldap
confirm_folder $LDAP
SLAPD_D=$ROOT/dcm4chee/slapd.d
confirm_folder $SLAPD_D

docker run --name dcm4chee-slapd	\
	--rm				\
	-p 389:389			\
	-v $LDAP:/var/lib/ldap		\
	-v $SLAPD_D:/etc/ldap/slapd.d	\
	dcm4che/slapd-dcm4chee:2.4.44-10.5

echo `date` slapd stopped

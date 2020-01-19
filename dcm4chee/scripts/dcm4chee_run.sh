#!/bin/sh


check_args() {
 if [ $# -eq 0 ]; then
  echo "Arguments: <ROOT folder>"
  echo Script exiting: dcm4chee_run.sh
  exit 1
 fi
}

check_root() {
 if [ ! -e $1 ]; then
  echo Script assumes the ROOT folder exists and is known to Docker for sharing
  echo Folder -- $1 -- not found
  echo Please create the folder and make sure Docker is sharing it.
  echo Script exiting: dcm4chee_run.sh
  exit 1
 fi
}

confirm_folder() {
 mkdir -p $1
 if mkdir -p $1; then
  echo Folder $1 was created or already existed
 else
  echo Unable to create folder: $1
  echo Script exiting: dcm4chee_run.sh
  exit 1
 fi
}

check_args $*

echo `date` Starting dcm4chee

ROOT=$1
DOCKER_OPTIONS=$2
check_root $ROOT
echo ROOT folder: $ROOT

STORAGE=$ROOT/dcm4chee/storage
confirm_folder $STORAGE
WILDFLY=$ROOT/dcm4chee/wildfly
confirm_folder $WILDFLY

docker run --name dcm4chee-arc		\
	--rm				\
	-p 8080:8080			\
	-p 9990:9990			\
	-p 11112:11112			\
	-p 2575:2575			\
	-v $WILDFLY:/opt/wildfly/standalone \
	-v $STORAGE:/storage		\
	--link dcm4chee-slapd:ldap	\
	--link dcm4chee-postgres:db	\
	dcm4che/dcm4chee-arc-psql:5.10.5

echo `date` dcm4chee stopped

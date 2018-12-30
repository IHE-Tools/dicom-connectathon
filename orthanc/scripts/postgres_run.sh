#!/bin/sh

check_args() {
 if [ $# -eq 0 ]; then
  echo "Arguments: <ROOT folder>"
  echo Script exiting: postgres_run.sh
  exit 1
 fi
}

check_root() {
 if [ ! -e $1 ]; then
  echo Script assumes the ROOT folder exists and is known to Docker for sharing
  echo Folder -- $1 -- not found
  echo Please create the folder and make sure Docker is sharing it.
  echo Script exiting: postgres_run.sh
  exit 1
 fi
}

confirm_folder() {
 mkdir -p $1
 if mkdir -p $1; then
  echo Folder $1 was created or already existed
 else
  echo Unable to create folder: $1
  echo Script exiting: postgres_run.sh
  exit 1
 fi
}

check_args $*

ROOT=$1
check_root $ROOT

POSTGRES_DATA=$ROOT/orthanc/postgres/data
confirm_folder $POSTGRES_DATA

docker run --name orthanc-postgres	\
	--rm				\
	-p 5432:5432			\
	-e POSTGRES_USER=postgres	\
	-e POSTGRES_PASSWORD=postgres	\
	-v $POSTGRES_DATA:/var/lib/postgresql/data	\
	postgres:9.5

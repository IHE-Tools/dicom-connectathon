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

echo `date` Starting postgres

ROOT=$1
check_root $ROOT
echo ROOT folder: $ROOT

POSTGRES_DATA=$ROOT/dcm4chee/postgresql/data
confirm_folder $POSTGRES_DATA


docker run --name dcm4chee-postgres \
   -p 15432:5432		\
   -e POSTGRES_DB=pacsdb	\
   -e POSTGRES_USER=pacs	\
   -e POSTGRES_PASSWORD=pacs	\
   -v $POSTGRES_DATA:/var/lib/postgresql/data \
   --rm --verbose		\
   dcm4che/postgres-dcm4chee:9.6-10

echo `date` postgres stopped

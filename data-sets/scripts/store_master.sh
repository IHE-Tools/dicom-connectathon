#!/bin/sh

check_args() {
 if [ $# -eq 0 ]; then
  echo "Arguments: <ROOT folder>"
  echo Script exiting: store_master.sh
  exit 1
 fi
}

check_root() {
 if [ ! -e $1 ]; then
  echo Script assumes the ROOT folder exists
  echo Folder -- $1 -- not found
  echo Please create the folder
  echo Script exiting: store_master.sh
  exit 1
 fi
}

check_args $*

ROOT=$1
check_root $ROOT

./store.sh $ROOT/nmi ORTHANC  localhost 4242
./store.sh $ROOT/nmi DCM4CHEE localhost 11112

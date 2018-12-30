#!/bin/sh

get_container_id() {
 IMAGE=$1
 local id
 id=$(docker ps | grep $IMAGE | cut -f 1 -d " " -)
 echo "$id"
}

kill_one_container() {
 ID=$1
 LABEL=$2

 if [ -z "$ID" ]; then
  echo No identifier found for $LABEL
  echo Assuming the container was previously killed
  return
 fi
 docker stop $ID
}

kill_orthanc() {
 id=$(get_container_id jodogne/orthanc-plugins)
 echo "orthanc-plugins Container ID: " $id
 kill_one_container "$id" orthanc-plugins
}

kill_postgres() {
 id=$(get_container_id orthanc-postgres)
 echo "Postgres Container ID: " $id
 kill_one_container "$id" Orthanc-Postgres
}

kill_orthanc
kill_postgres

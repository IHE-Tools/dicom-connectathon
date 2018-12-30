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


kill_dcm4chee() {
 id=$(get_container_id dcm4che/dcm4chee)
 echo "DCM4CHEE Container ID: " $id
 kill_one_container "$id" DCM4CHEE
}

kill_postgres() {
 id=$(get_container_id dcm4che/postgres)
 echo "Postgres Container ID: " $id
 kill_one_container "$id" Postgres
}

kill_slapd() {
 id=$(get_container_id dcm4che/slapd)
 echo "SLAPD Container ID:    " $id
 kill_one_container "$id" SLAPD
}

kill_dcm4chee
kill_postgres
kill_slapd

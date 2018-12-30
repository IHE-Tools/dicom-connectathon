#!/bin/sh

my_pull() {
 docker pull $1
 if [ $? != 0 ]; then
  echo Unable to pull docker image $1
  echo The command below failed:
  echo "     " docker pull $1
  echo ""
  echo Script exiting: pull.sh
  exit 1
 fi
}

for image in \
	dcm4che/slapd-dcm4chee:2.4.44-10.5	\
	dcm4che/postgres-dcm4chee:9.6-10	\
	dcm4che/dcm4chee-arc-psql:5.10.5	\
	; do
 echo $image
 my_pull $image
done

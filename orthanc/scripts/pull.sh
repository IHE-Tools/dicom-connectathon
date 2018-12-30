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
	postgres:9.5		\
	jodogne/orthanc:1.4.2	\
	jodogne/orthanc-plugins	\
	; do
 echo $image
 my_pull $image
done


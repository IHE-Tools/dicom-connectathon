#!/bin/sh

check_application() {
 which $1 > /dev/null 2>&1
 if [ $? != 0 ]; then
  echo Your path does not include -- $1 -- "(DCM4CHE)"
  echo Please install and/or update your path
  echo Script exiting: orthanc_test_find.sh
  exit 1
 fi
}

FIND=findscu
check_application $FIND

HOST=localhost
PORT=4242

time $FIND	\
	-b TEST \
	-c ORTHANC@$HOST:$PORT \
	-m 00080005=""		\
	-m 00080020=""		\
	-m 00080030=""		\
	-m 00080050=""		\
	-m 00080054=""		\
	-m 00080056=""		\
	-m 00080090=""		\
	-m 00081030=""		\
	-m 00100010=""		\
	-m 00100020=""		\
	-m 00100030=""		\
	-m 00100040=""		\
	-m 0020000D=""		\
	-m 00200010=""


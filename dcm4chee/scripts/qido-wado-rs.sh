#!/bin/sh

HOST=localhost
PORT=9090
QIDO=dcm4chee-arc/aets/CENTRAL/rs
WADO=dcm4chee-arc/aets/CENTRAL/rs


#echo Query for all studies
#echo curl http://$HOST:$PORT/$QIDO/studies
     curl http://$HOST:$PORT/$QIDO/studies > studies.txt

#echo ""
#echo Query for specific study
#echo curl http://$HOST:$PORT/$QIDO/studies?0020000D=1.3.46.670589.28.1.1.1 
     curl http://$HOST:$PORT/$QIDO/studies?0020000D=1.3.46.670589.28.1.1.1 > study_1.txt


#echo ""
#echo Query for series for specific study
#echo curl http://$HOST:$PORT/$QIDO/series?0020000D=1.3.46.670589.28.1.1.1
     curl http://$HOST:$PORT/$QIDO/series?0020000D=1.3.46.670589.28.1.1.1 > series.txt

#echo ""
#echo Query for specific series
#echo curl http://$HOST:$PORT/$QIDO/series?0020000E=1.3.46.670589.28.1.1.2
     curl http://$HOST:$PORT/$QIDO/series?0020000E=1.3.46.670589.28.1.1.2 > series_1.txt

#echo ""
#echo Query for instances
#echo curl http://$HOST:$PORT/$QIDO/instances?0020000E=1.3.46.670589.28.1.1.2
     curl http://$HOST:$PORT/$QIDO/instances?0020000E=1.3.46.670589.28.1.1.2 > instances.txt


#echo ""
#echo Retrieve an image instance
#echo curl -o \
	instance.dcm http://$HOST:$PORT/$WADO/studies/1.3.46.670589.28.1.1.1/series/1.3.46.670589.28.1.1.2/instances/1.3.46.670589.28.1.1.2.3.4.5
#     curl -o instance.dcm \
#	--X "Accept: multipart/related;type=application/dicom"	\
#	http://$HOST:$PORT/$WADO/studies/1.3.46.670589.28.1.1.1/series/1.3.46.670589.28.1.1.2/instances/1.3.46.670589.28.1.1.2.3.4.5

#curl -X GET \
#	"http://$HOST:$PORT/dcm4chee-arc/aets/CENTRAL/rs/studies/1.3.46.670589.28.1.1.1/series/1.3.46.670589.28.1.1.2/instances/1.3.46.670589.28.1.1.2.3.4.5"	\
#	-H "accept: multipart/related;type=application/dicom"

curl -X GET -OJ \
	"http://$HOST:$PORT/dcm4chee-arc/aets/CENTRAL/rs/studies/1.3.46.670589.28.1.1.1/series/1.3.46.670589.28.1.1.2/instances/1.3.46.670589.28.1.1.2.3.4.5"	\
	-H "accept: multipart/related;type=application/dicom"

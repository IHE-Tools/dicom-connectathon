#!/bin/sh

echo "Postgres Network Settings: " \
	`docker inspect --format '{{ .NetworkSettings.IPAddress }}' orthanc-postgres`
echo "Postgres Port Settings:    " \
	`docker inspect --format '{{ .NetworkSettings.Ports }}'     orthanc-postgres`


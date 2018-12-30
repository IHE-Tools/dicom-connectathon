#!/bin/sh

echo "Postgres Network Settings: " \
	`docker inspect --format '{{ .NetworkSettings.IPAddress }}' dcm4chee-postgres`
echo "Postgres Port Settings:    " \
	`docker inspect --format '{{ .NetworkSettings.Ports }}'     dcm4chee-postgres`


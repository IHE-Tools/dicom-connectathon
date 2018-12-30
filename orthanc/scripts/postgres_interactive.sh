#!/bin/sh

docker run -it --link orthanc-postgres:postgres --rm postgres:9.5 \
	sh -c 'psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres '


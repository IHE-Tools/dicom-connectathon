#!/bin/sh

docker run -it --link dcm4chee-postgres:postgres --rm dcm4che/postgres-dcm4chee:9.6-10 \
	sh -c 'psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U pacs pacsdb'


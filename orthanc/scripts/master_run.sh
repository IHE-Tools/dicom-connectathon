#!/bin/sh

mkdir -p ../logs
ROOT=/opt/connectathon-2019

echo Starting Postgres
(time ./postgres_run.sh $ROOT) > ../logs/postgres.log 2>&1 &
sleep 10

echo Starting Orthanc
(time ./orthanc_run.sh $ROOT) > ../logs/orthanc.log 2>&1 &

echo All scripts launched

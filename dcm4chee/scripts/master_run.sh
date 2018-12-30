#!/bin/sh

mkdir -p ../logs
ROOT=/opt/connectathon-2019

echo Starting postgres
(time ./postgres_run.sh $ROOT) > ../logs/postgres.log 2>&1 &
sleep 4

echo Starting slapd
(time ./slapd_run.sh $ROOT) > ../logs/slapd.log 2>&1 &
sleep 2

echo Starting dcm4chee
(time ./dcm4chee_run.sh $ROOT) > ../logs/dcm4chee.log 2>&1 &

echo All scripts launched

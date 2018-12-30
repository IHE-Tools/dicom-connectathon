# Orthanc subfolder

This folder contains scripts and data files for running the Orthanc PACS.
This version does not use docker compose. It uses individual scripts to start
the necessary services.

## Folder Setup
* Create a ROOT folder that will contain the docker files. This folder can be shared
  with the DCM4CHEE files as the scripts maintain a separate structure.
  The example we use is /opt/connectathon-2019.
* Register this folder with docker for sharing.

## Images
You will need to be in the scripts folder to pull the proper images.
> ./pull.sh

## Database Setup
You will need to be in the scripts folder.

The Orthanc application expects the Postgres database 'orthanc' to exist when it starts.
You will need to perform a one-time startup procedure.
Run these steps from the scripts folder where
ROOT is the folder you have selected/created above:

> ./postgres_run.sh ROOT
> ./postgres_createdb.sh
When it requests a password, enter 'postgres'

To use a different (more secure) password, you will have to alter the scripts.

Execute this command to stop postgres
> docker stop orthanc-postgres

## Orthanc Setup
Orthanc uses the file orthanc.json to manage configuration.
We include an example in the etc folder.
* Edit the file to match your environment.
* Copy the file to the location expected by the runtime scripts
> mkdir -p $ROOT/orthanc/etc
> cp etc/orthanc.json $ROOT/orthanc/etc

## Start/Stop Containers for Production
You will need to be in the scripts folder.

Edit 'master_run.sh' and change the value for ROOT to match your environment.

To start Orthanc and connected database:
> ./master_run.sh ROOT

To stop the applications
> ./master_stop.sh

A logs folder will be created and output from the applications
will be stored in that folder.

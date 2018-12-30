# DCM4CHEE subfolder

This folder contains scripts and data files for running the DCM4CHEE PACS.
This version does not use docker compose. It uses individual scripts to start
the necessary services.

## Folder Setup
* Create a ROOT folder that will contain the docker files. This folder can be shared
  with the Orthanc files as the scripts maintain a separate structure.
  The example we use is /opt/connectathon-2019.
* Register this folder with docker for sharing.

## Images
You will need to be in the scripts folder to pull the proper images.
> ./pull.sh

## Start/Stop Containers for Production
You will need to be in the scripts folder.

Edit 'master_run.sh' and change the value for ROOT to match your environment.

To start DCM4CHEE and connected database:
> ./master_run.sh ROOT

To stop the applications
> ./master_stop.sh

A logs folder will be created and output from the applications
will be stored in that folder. You may also find useful log
information in the DCM4CHEE wildfly logs.

## I See a docker-compose file
This is a works in progress.

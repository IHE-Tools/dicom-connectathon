# dicom-connectathon
Scripts for DICOM testing at an IHE Connectathon

* Scripts are included to run both DCM4CHEE and Orthanc using a single Docker container
* Scripts are separable, so you can choose to run one of the applications but not the other
* Scripts assume that all files will go under one ROOT folder that is an input parameter
** We use /opt/connectathon-2019
* You will have to make sure that common folder exists and is available to Docker

## Expected Path
* Create your ROOT folder and configure docker to share it
* Configure and run the DCM4CHEE application. There is a README.md file in the
  dcm4chee folder with scripts.
* Configure and run the Orthanc application. There is a README.md file in the
  orthanc folder with scripts.
* Optional:
** Use the 'get' scripts in data-sets to retrieve DICOM objects used for Connectathon testing.
** Use 'store_master.sh' script or individual store scripts to send those
   objects to the DCM4CHEE and Orthanc PACS.

## docker Folder?
This folder contains reminders because I have not memorized the docker lingo.
Please review any script in that folder before you run it.

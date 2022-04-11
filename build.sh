#!/bin/bash
##############################################################################################################
# Created By: komquest
# Creation Date: 4/9/2022
# Purpose: This Script will start the automation process to build, configure and STIG an httpd docker image.
# In particular this will build the x509 certs, and start the build process for the docker image.
# Each Docker Image will be given a unqiue id based off of a random string
# Requirments:
# 1. Dockerfile for apache build must be in root dir
# 2. All files for Dockerfile copy must be in root dir
# 3. openssl installed
# 4. Docker installed and running
# 5. Active Internet connection

# This script will not take any agruments at this time, but can change based off of requirments
##############################################################################################################


#Get ServerName

HTTPNAME=$1
LOG="/var/log/webserver.log"

#Build X509 Certs

openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj "/C=HW/ST=Hello/L=World/O=HelloWorld/CN=www.helloworld.com" -keyout server.key -out server.crt >> ${LOG} 2>&1

#Build Docker Image (See Dockerfile for more information)

docker build ./ -t $HTTPNAME >> ${LOG} 2>&1

#Display Build, with simple error checking
# 0 and 1 for Jenkins

if [ $? -ne 0 ]; then
  echo "<ERROR>_Please Verify Config" >> ${LOG} 2>&1
  echo 1
else
  echo "<INFO>_Built ${HTTPNAME}" >> ${LOG} 2>&1
  echo 0
fi





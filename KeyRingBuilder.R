## ---------------------------
## Script name: KeyRingBuilder.R
##
## Purpose of script: Build a keyring to securely store login credentials for
##    easy reference from R scripts
##
## Author: George A. Maynard
##
## Date Created: 2021-02-10
##
## Email: george.maynard@noaa.gov
##
## ---------------------------
## Notes: based on the tutorial found at 
##    https://rviews.rstudio.com/2019/03/21/how-to-avoid-publishing-credentials-in-your-code/
##   
##    Be sure to install the package 'keyring' before running this code
#install.packages('keyring')
## ---------------------------
## Set Working Directory
##
## ---------------------------
## Block scientific notation
options(scipen = 6, digits = 4)
## ---------------------------
## Load necessary packages
library(keyring)
## ---------------------------
## Load necessary functions
##
## ---------------------------
## Name your keyring
krName="GMaynard_keyring"

## Identify a service you would like to connect to
krService="SOLE"

## Input your username for that service
krUser="gmaynard"

## Create the keyring
kr=keyring::backend_file$new()

## Prompt for the master password to unlock the keyring
kr$keyring_create(krName)

## Prompt for the credential to be stored
kr$set(
  service=krService,
  username=krUser,
  keyring=krName
)

## Lock the keyring
kr$keyring_lock(krName)
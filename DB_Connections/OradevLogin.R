## ---------------------------
## Script name: OradevLogin.R
##
## Purpose of script: creates a connection object ("con") that allows for data
##    transfers to and from the NEFSC Oradev databases
##
## Author: George A. Maynard
##
## Date Created: 2021-03-19
##
## Email: george.maynard@noaa.gov
##
## ---------------------------
## Notes: You must be on the VPN and have appropriate credentials for this to 
##    work
##
## ---------------------------
## Set Working Directory
##
## ---------------------------
## Block scientific notation
options(scipen = 6, digits = 4)
## ---------------------------
## Load necessary packages
library(getPass)
library(odbc)
library(keyring)
## ---------------------------
## Load necessary functions
source("varEntryDialog.r")
## ---------------------------
## Check the system information to determine login type
if(Sys.info()[[4]]=="NECLWH04656117"&&Sys.info()[[7]]=="george.maynard"){
  con=dbConnect(
    odbc::odbc(),
    .connection_string=paste0(
      "DRIVER={Oracle in instantclient_12_2};DBQ=oradev.nefsc.noaa.gov:1526/oradev;UID=gmaynard;PWD=",
      keyring::backend_file$new()$get(
        service="SOLE",
        user="gmaynard",
        keyring="GMaynard_keyring"
      )
    ),
    timeout=10
  )
} else {
  username=varEntryDialog(vars="Username: ")
  con=dbConnect(
    odbc::odbc(),
    .connection_string=paste0(
      "DRIVER={Oracle in instantclient_12_2};DBQ=oradev.nefsc.noaa.gov:1526/oradev;UID=",
      username,
      ";PWD=",
      getPass(msg='PASSWORD')
    ),
    timeout=10
  )
}
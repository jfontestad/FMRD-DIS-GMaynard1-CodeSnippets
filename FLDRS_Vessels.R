## ---------------------------
## Script name: 
##
## Purpose of script:
##
## Author: George A. Maynard
##
## Date Created: 2021-02-09
##
## Email: george.maynard@noaa.gov
##
## ---------------------------
## Notes:
##  This script requires the user to be connected to the NEFSC VPN and have   
##    have access to the NOvA and SOLE Oracle servers
## ---------------------------
## Set Working Directory
##
## ---------------------------
## Block scientific notation
options(scipen = 6, digits = 4)
## ---------------------------
## Load necessary packages
##
library(odbc)
library(DBI)
library(lubridate)
library(dplyr)
## ---------------------------
## Load necessary functions
##
## ---------------------------
## Add connection lines here...

VP=dbGetQuery(
  con_sole,
  'SELECT * FROM FVTR.VERS_VESSEL_PROGRAMS'
)
VP$VVP_END_DATE=ymd_hms(VP$VVP_END_DATE)
VP=subset(
  VP,
  is.na(VP$VVP_END_DATE)
)
VES=dbGetQuery(
  con_sole,
  'SELECT * FROM FVTR.FVTR_VESSELS'
)
VES=subset(
  VES,
  VES$AP_NUM%in%VP$FV_AP_NUM
)
VES$FV_AP_NUM=VES$AP_NUM
new=merge(VES,VP)
SECTOR=dbGetQuery(
  con_nova,
  'SELECT * FROM OBDBS.SECTOR_VESSELS_MV'
)
SECTOR=subset(
  SECTOR,
  SECTOR$HULLNUM%in%new$VESSEL_HULL_ID
)
SECTOR$VESSEL_HULL_ID=SECTOR$HULLNUM
new2=merge(new,SECTOR)
new3=select(new2,VESSEL_NAME,SECTOR_NAME)
new3=subset(
  new3,
  duplicated(new3)==FALSE
  )
new3=new3[order(new3$SECTOR_NAME),]
## Build a new data frame that includes all relevant information

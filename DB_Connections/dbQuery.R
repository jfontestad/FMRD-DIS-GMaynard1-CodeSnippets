## ---------------------------
## Script name: dbQuery.R
##
## Purpose of script: Simple script to execute a query on an Oracle database at
##    NEFSC
##
## Author: George A. Maynard
##
## Date Created: 2021-04-16
##
## Email: george.maynard@noaa.gov
##
## ---------------------------
## Notes: You must be on the VPN and have appropriate credentials in order for
##    this script to execute properly   
##
## ---------------------------
## Set Working Directory
## Check the system information to determine working directory handling
if(Sys.info()[[4]]=="NECLWH04656117"&&Sys.info()[[7]]=="george.maynard"){
  setwd("H:/GitHub/FMRD-DIS-GMaynard1-CodeSnippets/DB_Connections/")
} else {
  setwd(choose.dir())
}
## ---------------------------
## Block scientific notation
options(scipen = 6, digits = 4)
## ---------------------------
## Load necessary packages
##
## ---------------------------
## Load necessary functions
##
## ---------------------------
## Source the entry dialogue
source("varEntryDialog.r")
## Prompt the user for which database they'd like to access
db=toupper(
  varEntryDialog(vars="Database Name: ")
)
## Connect to the database or return an error if there is no connection script
connection=paste0(
  db,
  "LOGIN.R"
)
if(connection%in%toupper(dir())==FALSE){
  stop("Database name not recognized.")
} else {
  source(
    dir()[which(toupper(dir())==connection)]
  )
}
## Prompt the user to enter the query
q=varEntryDialog(vars="Query: ")
## Execute the query and store the results as an object called data
data=dbGetQuery(
  conn=con,
  statement=q$Query
)

SELECT * FROM FVTR.VERS_PROGRAMS WHERE PROGRAM_DESCR LIKE '%Elec%'

## ---------------------------
## Script name: SQLiteLoader.R
##
## Purpose of script: To load an SQLite database into R for viewing and editing
##
## Author: George A. Maynard
##
## Date Created: 2021-01-21
##
## Email: george.maynard@noaa.gov
##
## ---------------------------
## Notes:
##   
##
## ---------------------------
## Set Working Directory
##
## ---------------------------
## Block scientific notation
options(scipen = 6, digits = 4)
## ---------------------------
## Load necessary packages
library(RSQLite)
## ---------------------------
## Load necessary functions
##
## ---------------------------
## Connect to an SQLite database file
con=dbConnect(
  drv=SQLite(),
  file.choose()
  )
## Show a list of tables
dbListTables(con)
## Fetch data from a table
tb=dbReadTable(
  conn=con,
  name="TableNameHere"
)

library(rgdal)
library(GISTools)
library(tidyverse)


#set working directory
setwd("D:/Users/james/Documents/RStudio/Test_R_GIS-master")
#make sure you set yours correctly

#get my working directory
mydir <- getwd()

#Add the data folder to mydir using paste function
mydir <- paste(mydir,"Data",sep="/")

#Read in shapefiles from data directory
lhb <- readOGR(mydir, "Local_Health_Boards_December_2015_Full_Clipped_Boundaries_in_Wales")

#import things to count data from csv
things <- read.csv("Data/test_data_lhbs.csv")

#create thing lhbs
lhbt <- lhb 

#insert lhb data over existing data
lhbt@data <- left_join(lhbt@data, things, by = c("lhb15cd" = "lhb16cd"))

#create shade ranges from the values in lhbz$x2007
shades <- auto.shading(lhbt$X2000, n=5,cols = brewer.pal(5,"Reds"))

#adds choropleth to png
choropleth(lhbt,lhbt$X2000,shades)
#adds legend to png
choro.legend(370000, 390000, shades, fmt = "%g", cex = 1, title = "Things Detected in 2000")


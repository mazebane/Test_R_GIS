library(rgdal)
library(GISTools)
library(RColorBrewer)
library(tidyverse)
library(png)
library(magick)

#set working directory
setwd("D:/Users/james/Documents/RStudio/Test_R_GIS-master")
#make sure you set yours correctly

#get my working directory
mydir <- getwd()

#Add the data folder to mydir using paste function
mydir <- paste(mydir,"Data",sep="/")


#Read in shapefiles from data directory
lhb <- readOGR(mydir, "Local_Health_Boards_December_2015_Full_Clipped_Boundaries_in_Wales")

#simple plot of lhbs
plot(lhb)

#nicely coloured in using the area of each lhb
choropleth(lhb, lhb$st_areasha)

#defining colours using the 
shades <- auto.shading(lhb$st_areasha, n=5,cols = brewer.pal(5,"Blues"))

#using defined colours
choropleth(lhb, lhb$st_areasha,shades)

#using diferrent colour scheme
shades <- auto.shading(lhb$st_lengths, n=5,cols = brewer.pal(9,"Greens"))

#output with new colours
choropleth(lhb, lhb$st_lengths,shades)

#adding a legend
choro.legend(360000, 380000, shades, fmt = "%g", title = "Things Counted")

#import things to count data from csv
things <- read.csv("Data/test_data_lhbs.csv")

#create thing lhbs
lhbt <- lhb 

#insert lhb data over existing data
lhbt@data <- left_join(lhbt@data, things, by = c("lhb15cd" = "lhb16cd"))

#create shade ranges from the values in lhbz$x2007
shades <- auto.shading(lhbt$X2007, n=5,cols = brewer.pal(5,"Reds"))

#export pretty maps per year in png format
#im sure this could be scripted as a loop but i have't worked that out yet

#creates the png file in Plot folder with defined size
png("Plot/Test01.png", width = 6000, height = 3000)
#adds choropleth to png
choropleth(lhbt,lhbt$X2000,shades)
#adds legend to png
choro.legend(370000, 390000, shades, fmt = "%g", cex = 6, title = "Things Detected in 2000")
#closes the plot so nothing else can be added to the png
dev.off()
#start the next png and so on
png("Plot/Test02.png", width = 6000, height = 3000)
choropleth(lhbt,lhbt$X2001,shades)
choro.legend(370000, 390000, shades, fmt = "%g", cex = 6, title = "Things Detected in 2001")
dev.off()
png("Plot/Test03.png", width = 6000, height = 3000)
choropleth(lhbt,lhbt$X2002,shades)
choro.legend(370000, 390000, shades, fmt = "%g", cex = 6, title = "Things Detected in 2002")
dev.off()
png("Plot/Test04.png", width = 6000, height = 3000)
choropleth(lhbt,lhbt$X2003,shades)
choro.legend(370000, 390000, shades, fmt = "%g", cex = 6, title = "Things Detected in 2003")
dev.off()
png("Plot/Test05.png", width = 6000, height = 3000)
choropleth(lhbt,lhbt$X2004,shades)
choro.legend(370000, 390000, shades, fmt = "%g", cex = 6, title = "Things Detected in 2004")
dev.off()
png("Plot/Test06.png", width = 6000, height = 3000)
choropleth(lhbt,lhbt$X2005,shades)
choro.legend(370000, 390000, shades, fmt = "%g", cex = 6, title = "Things Detected in 2005")
dev.off()
png("Plot/Test07.png", width = 6000, height = 3000)
choropleth(lhbt,lhbt$X2006,shades)
choro.legend(370000, 390000, shades, fmt = "%g", cex = 6, title = "Things Detected in 2006")
dev.off()

#create animated gif file from pngs
#only works if you have imagemagick installed
list.files(path = "Plot/", pattern = "*.png", full.names = T) %>% 
map(image_read) %>% # reads each path file
image_join() %>% # joins image
image_animate(fps=1) %>% # animates, can opt for number of loops
image_write("Plot/choropleth.gif") 





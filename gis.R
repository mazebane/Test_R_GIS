library(rgdal)
library(GISTools)
library(RColorBrewer)
library(tidyverse)
library(png)

#Read in shapefiles
lhb <- readOGR(".", "Local_Health_Boards_December_2015_Full_Clipped_Boundaries_in_Wales")

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
choro.legend(331089, 384493, shades, fmt = "%g", title = "Things Counted")

#import zombie data from csv
things <- read.csv("test_data_lhbs.csv")

#create zombie lhbs
lhbt <- lhb 

#insert zombie data over existing data
lhbt@data <- left_join(lhbt@data, things, by = c("lhb15cd" = "lhb16cd"))

#create shade ranges from the values in lhbz$x2007
shades <- auto.shading(lhbt$X2007, n=5,cols = brewer.pal(9,"Blues"))

#pretty maps per year
choropleth(lhbt,lhbt$X2000,shades)
choro.legend(331009, 384403, shades, fmt = "%g", title = "Things Detected")
choropleth(lhbt,lhbt$X2001,shades)
choro.legend(331009, 384403, shades, fmt = "%g", title = "Things Detected")
choropleth(lhbt,lhbt$X2002,shades)
choro.legend(331009, 384403, shades, fmt = "%g", title = "Things Detected")
choropleth(lhbt,lhbt$X2003,shades)
choro.legend(331009, 384403, shades, fmt = "%g", title = "Things Detected")
choropleth(lhbt,lhbt$X2004,shades)
choro.legend(331009, 384403, shades, fmt = "%g", title = "Things Detected")
choropleth(lhbt,lhbt$X2005,shades)
choro.legend(331009, 384403, shades, fmt = "%g", title = "Things Detected")
png("TEST.png", width = 600, height = 300)
choropleth(lhbt,lhbt$X2006,shades)
choro.legend(331009, 384403, shades, fmt = "%g", title = "Things Detected")
 dev.off()


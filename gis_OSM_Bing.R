

library(ggmap)
library(rosm)
library(prettymapr)

altalake <- makebbox(53.45,-2.5,51.375,-5.355)
osm.plot(altalake)
bmaps.plot(altalake)

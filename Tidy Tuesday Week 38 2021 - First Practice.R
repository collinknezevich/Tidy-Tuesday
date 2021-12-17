library(tidyverse)
library(ggplot2)
setwd("/Users/collinknezevich/Desktop/R")

install.packages("tidytuesdayR")

#loading Tidy Tuesday data
tuesdata <- tidytuesdayR::tt_load(2021, week = 38)
billboard <- tuesdata$billboard
audio <- tuesdata$audio_features

#gathering data for blink-182 songs on the Billboard
blink <- billboard %>% 
  filter(performer == "Blink-182")

#obtaining unique iterations of blink songs on Billboard, with greatest
#value of weeks_on_chart to reflect most recent data
sortedblink <- blink[order(blink$song, -blink$weeks_on_chart),]

uniqueblink <- sortedblink[!duplicated(sortedblink$song),]

#repeat with The Offspring
offspring <- billboard %>% 
  filter(performer == "The Offspring")

sortedoffspring <- offspring[order(offspring$song, -offspring$weeks_on_chart),]

uniqueoffspring <- sortedoffspring[!duplicated(sortedoffspring$song),]

#concatenating Blink and Offspring datasets
offblink <- rbind(uniqueblink, uniqueoffspring)

#histograms 
ggplot(offblink, aes(x=weeks_on_chart, fill=performer, color=performer)) + 
  geom_histogram(position="identity", alpha=0.5) + 
  facet_grid(performer ~ .) + 
  labs(title="Weeks on Billboard Top 100", x="Weeks", y="") 

ggplot(offblink, aes(x=peak_position, fill=performer, color=performer)) + 
  geom_histogram(position="identity", alpha=0.5) + 
  facet_grid(performer ~ .) + 
  labs(title="Peak Ranking on Billboard Top 100", x="Peak", y="")
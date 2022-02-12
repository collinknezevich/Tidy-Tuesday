library(tidyverse)
library(ggplot2)
library(dplyr)
library(tidytuesdayR)
setwd("/Users/collinknezevich/Desktop/R")

tuesdata <- tidytuesdayR::tt_load(2021, week = 44)
rankings <- tuesdata$ultra_rankings
race <- tuesdata$race

#merging datasets by race ID 
racemerge <- merge(rankings, race, by="race_year_id") 

#nationality of race winners 
racewinners <- racemerge %>% 
  filter(rank == 1)
nationality <- table(racewinners$nationality)
lbls <- paste(names(nationality), "\n", nationality, sep="") 
pie(nationality, labels = lbls, main = "Nationality of Race Winners")

#Switzerland is the 5th most mountainous country in the world.
#Do Swiss racers perform better in races with high increases in elevation (>8000)? 
#Measuring by proportion of race winners that are Swiss.
q <- racewinners$nationality == "SUI"
suiprop <- mean(q) #prop = 0.4%

highelev <- racewinners %>% 
  filter(elevation_gain > 8000)
suipropelev <- mean(highelev$nationality == "SUI") #prop = 1.9%

#hypothesis test 
n1 <- nrow(racewinners)
n2 <- nrow(highelev)
x1 <- suiprop*n1
x2 <- suipropelev*n2
test <- prop.test(x = c(x1, x2), n = c(n1, n2), alternative = "less")
test #p-value = .018
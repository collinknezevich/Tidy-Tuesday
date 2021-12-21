library(tidyverse)
library(ggplot2)
setwd("/Users/collinknezevich/Desktop/R")
install.packages("dplyr")
library(dplyr)

install.packages("tidytuesdayR")

#loading Tidy Tuesday data
tuesdata <- tidytuesdayR::tt_load(2021, week = 22)
records <- tuesdata$records 
drivers <- tuesdata$drivers

#on which track were records held the longest, on average
ggplot(records, aes(x=track, y=record_duration, fill=track)) + 
  geom_bar(position="dodge", stat="summary", fun="mean", color="black") + 
  labs(title="Average World Record Duration by Track", x="Track", y="Duration",
       fill="Track") + 
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

#for which subset were records held the longest: 
#   - Three Lap, NO Shortcut
#   - Three Lap, Shortcut
#   - One Lap, NO Shortcut
#   - One Lap, Shortcut
ggplot(records, aes(x=type, y=record_duration, fill=shortcut)) + 
  geom_bar(position="dodge", stat="summary", fun="mean", color="black") + 
  labs(title="Average World Record Duration for One and Three Laps \nWith or Without Shortcuts",
       x="Laps", y="Duration", fill="Shortcut?")

#timeline of Choco Mountain records, three lap w/ shortcuts 
choco <- records %>% filter(track == "Choco Mountain", shortcut == "Yes",
                            type == "Three Lap")
weathertenkodate <- as.Date('2014-02-01')
weathertenkodate2 <- as.Date('2014-08-01')
weathertenkodate3 <- as.Date('2017-10-29')
ggplot(choco, aes(x=date, y=time)) + 
  geom_point() + 
  labs(title="Timeline: Choco Mountain Three Lap Records w/ Shortcuts", 
       x="Date", y="Time") + 
  geom_vline(xintercept = weathertenkodate, linetype = "dashed", color = "red", 
             size = 0.75) + 
  geom_text(aes(weathertenkodate, 120, 
                label = "'Weathertenko' Skip Discovered"),
            color = "red", size = 2.5, hjust=1.05) + 
  geom_vline(xintercept = weathertenkodate2, linetype = "dashed", color = "blue",
             size = 0.75) + 
  geom_text(aes(weathertenkodate2, 100,
                label = "Weathertenko Done by Human"),
            color = "blue", size = 2.5, hjust=1.05) + 
  geom_vline(xintercept = weathertenkodate3, linetype = "dashed",
             color = "darkgreen", size = 0.75) + 
  geom_text(aes(weathertenkodate3, 35,
                label = "Weathertenko Done 3 Times \nin Single Run (abney317)"),
            color = "darkgreen", size = 2.5, hjust=1.05)
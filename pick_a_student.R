library(dplyr)
library(ggplot2)
library(readr)


## Choose a student ----

## Import the data
dd <- read.csv("data/BIO377_Participants_Sep18.csv")
str(dd)

## add full names variable
dd <- mutate(dd, Full_name=paste(First_name, Last_name))

sample_n(dd, 1)$Full_name

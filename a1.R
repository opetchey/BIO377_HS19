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

## make a histogram of 1000 random normal deviation ----
x <- rnorm(20, mean=2, sd=3)
cc <- hist(x, breaks=20)
d1 <- density(x)
str(d1)
lines(d1$x, d1$y*20, col="red")

## same for poisson ----
d <- rpois(n=1000, lambda=1)
hist(d, col="blue")

## plot y = x^2
x <- -10:10
x <- seq(-10, 10, 0.1)
y <- x^2
dd <- data.frame(x, y)
plot(x, y, type="l", col="purple")

## make a sin curve
x <- seq(from=-pi, to=pi, length=1000)
y <- sin(x)

pdf("a lovely plot.pdf")
plot(x, y, type="l", col="green")
dev.off()

## read in the dataset
dd <- read.csv2("data/myfirstexcel.csv")
dd


## read in the dataset using readr:read_csv ----
dd1 <- read_csv2("data/myfirstexcel.csv")
dd1

## make a graph to tell us if the relationship ----
## between age and weight differs for males and females
qplot(x=Age, y=Weight, col=Gender, data=dd1,
      geom=c("line", "point"))






## Day two of BIO377
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(vegan)

dplyr::filter()
stats::filter()

dd <- read_csv("data/Foodbalancesheets_E_All_data_reduced.csv")

str(dd)

dd1 <- filter(dd, Element=="Food supply quantity (kg/capita/yr)")
dd1 <- dd %>% filter(., Element=="Food supply quantity (kg/capita/yr)")
dd1 <- dd %>% filter(Element=="Food supply quantity (kg/capita/yr)")

## removing 2014 and 2015 data as it is mostly 0s and NAs
dd2 <- select(dd1, -Y2014, -Y2015)

## make it long
dd3 <- gather(dd2, Year, Quantity, 5:ncol(dd2))


new_dd <- dd %>%
  filter(Element=="Food supply quantity (kg/capita/yr)") %>%
  select(-Y2014, -Y2015) %>%
  gather(Year, Quantity, 5:57) %>%
  mutate(Year=as.numeric(str_sub(Year, 2)))
  

## find max mean food supply per year
c_means <- group_by(new_dd, Country, Year) %>%
  summarise(total_supply=sum(Quantity)) %>%
  group_by(Country) %>%
  summarise(mean.Food_Supply=mean(total_supply, na.rm=TRUE),
            number_of_NAs=sum(is.na(total_supply)),
            num_vals=length(total_supply))

## 
new_dd %>% filter(Country=="Switzerland",
                  Item=="Wheat and products") %>%
  qplot(x=as.numeric(Year), y=Quantity, data=.,
        ylab="Food supply (kg per capita per year)",
        geom=c("line", "point")) 

##

## take out the zeros? and NAs

food_div <- new_dd %>% group_by(Country, Year) %>%
  summarise(div=diversity(Quantity, index="simpson"))

qplot(x=Year, y=div,
      data=filter(food_div, Country=="Switzerland"),
      geom=c("line", "point"))

qplot(x=Year, y=div, col=Country,
      data=food_div,
      geom=c("line")) + 
  theme(legend.position="none")



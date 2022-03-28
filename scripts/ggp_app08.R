{

rm(list=ls());                         # clear Environment tab
options(show.error.locations = TRUE);  # show line numbers on error
library(package=ggplot2);              # get the GGPlot package
library(package=ggforce);              # for geom_circle, geom_ellipse
library(package="gridExtra");

#### Two bugs in GGPlot that cause issues with including data and mapping:
#    1) faceting data must come from a declared data frame
#    2) annotate (i.e., manually adding objects) does not work for all geoms (objects)
#       -- it does not work for circles and ellipses

# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA.csv",
                       stringsAsFactors = FALSE);# for people still using R v3

#### Q2  ####

seasonOrdered = factor(weatherData$season,
                       levels=c("Spring", "Summer", "Fall", "Winter"));
hazyDays = grep(weatherData$weatherType, pattern= "HZ");   # any day with hazy

mean1 = round(mean(weatherData[hazyDays,]$tempDept),digits = 2)

plot1 = ggplot(data=weatherData[hazyDays,]) +
  geom_histogram(mapping=aes(x=tempDept),
                 fill="brown1",
                 color="black") +
  theme_classic() +

  annotate(geom = "text",
           x = -1,
           y = 9,
           label = mean1,
           color = "brown1")+
  geom_vline(xintercept = mean1, color = "brown1")+
  labs(title = "Temp Departure from Average (Hazy Days)",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temp Dept",
       y = "Frequency");

plot(plot1);

#### Q3 ####

breezyDays = grep(weatherData$weatherType, pattern="BR");  # any breezy day

sunnyDays = grep(weatherData$weatherType, pattern="SN");   #any sunny day

mean2 = round(mean(weatherData[breezyDays,]$tempDept),digits = 2)

plot2 = ggplot(data=weatherData[breezyDays,]) +
  geom_histogram(mapping=aes(x=tempDept),
                 fill="brown1",
                 color="black") +
  theme_classic() +
  
  annotate(geom = "text",
           x = 5.1,
           y = 14,
           label = mean2,
           color = "brown1")+
  geom_vline(xintercept = mean2, color = "brown1")+
  labs(title = "Temp Departure from Average (Breezy Days)",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temp Dept",
       y = "Frequency");

plot(plot2);

mean3 = round(mean(weatherData[sunnyDays,]$tempDept),digits = 2)
plot3 = ggplot(data=weatherData[sunnyDays,]) +
  geom_histogram(mapping=aes(x=tempDept),
                 fill="brown1",
                 color="black") +
  theme_classic() +
  
  annotate(geom = "text",
           x = -2.3,
           y = 9,
           label = mean3,
           color = "brown1")+
  geom_vline(xintercept = mean3, color = "brown1")+
  labs(title = "Temp Departure from Average (Sunny Days)",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temp Dept",
       y = "Frequency");

plot(plot3);

#### Q4 ####

breezyAndhazyDays = intersect(breezyDays, hazyDays);

plot4 = ggplot(data=weatherData[breezyAndhazyDays,]) +
  geom_histogram(mapping=aes(x=tempDept,fill="brown1"),color="black") +
  theme_classic() +
  
  annotate(geom = "text",
           x = 5.1,
           y = 9,
           label = "2.39\U00BA F",
           color = "brown1")+
  geom_vline(xintercept = mean(weatherData$tempDept), color = "brown1")+
  labs(title = "Temp Departure from Average (Breezy and Hazy Days)",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temp Dept",
       y = "Frequency");

plot(plot4);

#### Q5 ####
sunnyOrbreezy = union(sunnyDays, breezyDays);

plot5 = ggplot(data=weatherData[sunnyOrbreezy,]) +
  geom_histogram(mapping=aes(x=tempDept,fill="brown1"),color="black") +
  theme_classic() +
  
  annotate(geom = "text",
           x = 5.1,
           y = 15,
           label = "2.39\U00BA F",
           color = "brown1")+
  geom_vline(xintercept = mean(weatherData$tempDept), color = "brown1")+
  labs(title = "Temp Departure from Average (Sunny or Breezy Days)",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temp Dept",
       y = "Frequency");
plot(plot5);

#### Q7 ####
multi1=arrangeGrob(plot1, plot2, plot3, plot4, plot5, 
                   layout_matrix = rbind(c(1,2,3),   # plot4, plot5, plot6 
                                         c(4,5,NA))); # plot3, plot2, plot1
plot(multi1);

#### Q8 ####
multi2=arrangeGrob(plot5, plot4, plot3,
                   layout_matrix = rbind(c(3,NA,2),
                                         c(NA,NA,2),
                                         c(NA,3,1)));
plot(multi2);
}

#### Questions####

#1. Pretty good for this session, it is short and simpler than last lesson.

#2. Approximately 1.4 hours.

#3. Not for now.

#4. If I have several matrix data with columns include 12 months' data, 
#the rows include multiple years, how can I draw the lines simple? The
#first thing I want to know is to draw these lines one month by the other,
#just wondering if there is any simple ways. I uploaded the example files
#into "private" folder. Please check them if there is a need. Thank you
#very much!
{
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package
  
  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016NOAA.csv", 
                         stringsAsFactors = FALSE);  # for people still using R v3

#### Factoring the values in season ####
seasonOrdered = factor(weatherData$season,
                       levels=c("Spring", "Summer", "Fall", "Winter"));

# Scatter plot
plot1 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, 
                          y=relHum, 
                          color = seasonOrdered,
                          shape = seasonOrdered,
                          fill = seasonOrdered),
              size = 2.5,
              color = "grey") +
  geom_smooth( mapping=aes(x=avgTemp, y=relHum,
                           color = seasonOrdered),
               se = FALSE,
               method="lm" ) +
  scale_color_manual(values = c ("Spring" = rgb(red = 248, green = 148, blue = 109, maxColorValue = 255),
                                 "Summer" = rgb(red = 124, green = 174, blue = 0, maxColorValue = 255),
                                 "Fall" = rgb(red = 0, green = 191, blue = 196, maxColorValue = 255), 
                                 "Winter" = rgb(red = 199, green = 124, blue = 255, maxColorValue = 255)))+
  scale_x_continuous(limits=c(15,85),     # add these components
                     breaks = c(30,50,70)) +
  scale_y_continuous(limits=c(40,100),
                     breaks = c(50,70,90))+
  scale_shape_manual(values=c(21,22,23,24)) +
  scale_size_continuous(range=c(0,5))+
  theme_bw() +
  labs(title = "Humidity vs. Temperature",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature (\u00B0F)", 
       y = "Humidity (\u0025)",
       color = "Seasons",
       size = "Precipitation")+
  guides(color = guide_legend(order=1),
         size = guide_legend(order=2));
plot(plot1);


#### Factoring the values in windSpeedLevel ####
windSpeedLevels = factor(weatherData$windSpeedLevel,
                       levels=c("Low", "Medium", "High"));
 #### Histogram plot ####
plot2 = ggplot( data=weatherData ) +
  geom_histogram( mapping=aes(x=relHum, color = windSpeedLevels),
                  bins = 30
                  ) + # color is the outline color
  scale_color_manual(values = c ("Low" = "green", "Medium" = "yellow",
                                 "High" = "red"))+
  theme_bw() +
  theme(panel.background = element_rect(fill="black", 
                                        color=rgb(red=0.7, green=0.5, blue=0.5)))
  labs(title = "Temperature (\u00B0F)",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature (\u00B0F)", 
       );  
plot(plot2);

#### humidity vs. average temperature ####


plot3 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum, color=stnPressure),
              size = 2,alpha = 0.5) +
  scale_color_gradientn(colors=c( "green", "yellow", "blue"),
                        values=c(0,0.33,1))+
  theme_bw() +
  labs(title = "Humidity vs. Wind Speed",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature (\u00B0F)", 
       y = "Humidity (\u0025)");
plot(plot3);

#### What was your level of comfort with the lesson/application? #####
# A bit challenge for me this week.

#### Approximately how long did you work on this lesson? ####
# About 3.5 hours.

#### What areas of the lesson/application confused or still confuses you? ####
#Great for now.

####What are some things you would like to know more about that is related to, 
####but not covered in, this lesson? ####
# Already talked about all interested figures.


}
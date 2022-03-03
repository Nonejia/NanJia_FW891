{
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package
  
  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016NOAA.csv", 
                         stringsAsFactors = FALSE);  # for people still using R v3
  
  #### Plot 1 ####
  
  #### Define wind spped and wind direction order, add them into the data file
  windspeedOrdered = factor(weatherData$windSpeedLevel,
                         levels=c("High" , "Medium" , "Low"));  #order of windspeed
  
  weatherData$windspeedOrdered = windspeedOrdered; #add order to data file
  
  windDirOrdered = factor(weatherData$windDir,
                          levels=c("North", "South", "East", "West")); #order of wind direction
  
  weatherData$windDirOrdered = windDirOrdered; #add order to data file
  
  #### plot function
  plot1 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum)) + 
    theme_bw() +
    facet_grid( rows = vars(windDirOrdered),
                cols = vars(windspeedOrdered)) + # set rows and cols variables 
    labs(title = "Temperature (\u00B0F)",
         subtitle = "Lansing, Michigan: 2016",
         x = "Temperature (\u00B0F)",
         y = "Humidity (\u0025)"); 
  plot(plot1);
  
  
  #### Plot 2 ####
  
  #### Define season order, add them into the data file
  seasonOrdered = factor(weatherData$season,
                         levels=c("Spring", "Summer", "Fall", "Winter")); #order of season
  weatherData$seasonOrdered = seasonOrdered; #add order to data file
  
  plot2 = ggplot( data=weatherData ) +
    geom_histogram( mapping=aes(x=avgTemp, fill = seasonOrdered),
                    color="black",bins = 15) + 
    scale_color_manual(values = c ("Spring" = "green",
                                   "Summer" = "red",
                                   "Fall" = "orange", 
                                   "Winter" = "purple"))+
    theme_bw() +
    facet_grid( rows = vars(seasonOrdered) ) +
    labs(title = "Temperature (\u00B0F)",
         subtitle = "Lansing, Michigan: 2016",
         x = "Temperature (\u00B0F)")+
    scale_x_continuous( breaks = seq(from=5, to=85, by=10),
                        limits = c(3,100)) +
    theme(strip.text = element_text(size = 12,color = "brown",family = 'sans'),
          strip.background =element_rect(fill="#FFFFCC",color = "purple"),
          plot.background = element_rect(linetype=1, size=3, color="black")); 
  plot(plot2);
  
  
  #### Plot 3 ####
  
  ####reorder the wind speed from high -> medium -> low to low -> medium -> high
  windspeedOrdered = factor(weatherData$windSpeedLevel,
                            levels=c("Low" , "Medium" , "High"));
  
  weatherData$windspeedOrdered = windspeedOrdered;
  
  boxColors = c(rep("brown", 8),
                rep("blue", 3),
                rep("brown",1));

  
  plot3 = ggplot(data=weatherData) +
    geom_boxplot(mapping=aes(x=windDirOrdered, y=changeMaxTemp),
                 na.rm = TRUE,  # gets rid of warning about non-finite values
                 color = boxColors,
                 fill = "lightyellow",
                 outlier.color = rgb(red=232, green=117, blue=17, maxColorValue = 255),
                 outlier.shape = "&",
                 outlier.size = rel(3.0)) +
    theme_bw() +
    facet_grid( cols=vars(windspeedOrdered)) +
    labs(title = "Change in Temperature vs. Wind Direction",
         subtitle = "Lansing, Michigan: 2016",
         x = "Wind Direction",
         y = "Degrees (Fahrenheit)");
  plot(plot3);
  
  #### Ignore the outliers ####
  
  #1. Set the ouliers' transparent as 100%, so that the outliers will be invisible. 
  # outlier.alpha = 0
  #2. Set the shape of outliers as NA
  #outlier.shape = NA
  #3. Use coord_cartesian function to set the axis limitation.
  #coord_cartesian(ylim =  c(-15, 10))
  #4. Reset the outlier size as 0 pixel.
  #outlier.size = 0
  
  
  #### Questions ####
  
  #### Question 1
  # Great for this lesson.
  
  #### Question 2
  # About 2 - 2.5 hours.
  
  #### Question 3
  # How can we add outline of total canvas?
  
  #### Question 4
  #Will our course include some more complex diagrams? 
  #For example Sankey diagrams, Sunburst diagrams, Voronoi diagrams and Chord diagrams?
  
  
  
}

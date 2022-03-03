{
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package
  library(package=ggforce);              # for geom_circle, geom_ellipse
  
  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016NOAA.csv", 
                         stringsAsFactors = FALSE);  # for people still using R v3
  #### APP 1 --- Plot1 - Plot3 ####
  
  ### Re-order the directions on the x-axis using factor(s)
  windDirOrdered = factor(weatherData$windDir,
                          levels=c("North", "East", "South", "West"));
  
  #### A Boxplot ####
  #### data for 3 outliers
  xVector = c(2,2,2);
  yVector = c(26,24,-21);
  pointSize = c(1.5,1.5,1.5);
  pointFill = c("purple", "orange", "red");
  #Using annotate, add three outlier points to the East box (two above and one below).
  #Change the color, shape, and size of the points
  plot1 = ggplot(data=weatherData) +
    geom_boxplot(mapping=aes(x=windDirOrdered, y=changeMaxTemp),
                 na.rm = TRUE) +
    annotate(geom="point",
             x = xVector,
             y = yVector,
             size = pointSize,
             color =rgb(red=0, green=.3, blue=.7),  # same for all points
             fill = pointFill,
             shape = 24)+
    annotate(geom="rect",   
             xmin = c(1.8, 1.8, 1.8),    
             xmax = c(1.96, 1.96, 1.96),    
             ymin = c(25,23,-22),    
             ymax = c(27,25,-20),   
             linetype=1,
             color = "black",
             fill = "black") +
    #Labels the points with their value
    annotate(geom = "text",
             x = c(1.9,1.9,1.9),
             y = c(26,24,-21),
             label = c(26,24,-21),
             color = c("purple", "orange", "red"))+
    theme_bw() +
    labs(title = "Change in Temperature vs. Wind Direction",
         subtitle = "Lansing, Michigan: 2016",
         x = "Wind Direction",
         y = "Change in Temperature (\u00B0F)");
  
  plot(plot1)
  
  plot2 = ggplot(data=weatherData,
                 mapping=aes(x=windDirOrdered, y=changeMaxTemp)) +
    geom_boxplot(na.rm = TRUE) +
    annotate(geom="point",
             x = xVector,
             y = yVector,
             size = pointSize,
             color =rgb(red=0, green=.3, blue=.7),  # same for all points
             fill = pointFill,
             shape = 24)+
    annotate(geom="rect",   
             xmin = c(1.8, 1.8, 1.8),    
             xmax = c(1.96, 1.96, 1.96),    
             ymin = c(25,23,-22),    
             ymax = c(27,25,-20),   
             linetype=1,
             color = "black",
             fill = "black") +
    #Labels the points with their value
    annotate(geom = "text",
             x = c(1.9,1.9,1.9),
             y = c(26,24,-21),
             label = c(26,24,-21),
             color = c("purple", "orange", "red"))+
    theme_bw() +
    labs(title = "Change in Temperature vs. Wind Direction",
         subtitle = "Lansing, Michigan: 2016",
         x = "Wind Direction",
         y = "Change in Temperature (\u00B0F)");
  
  plot(plot2)
  
  plot3 = ggplot() +
    geom_boxplot(data=weatherData,
                 mapping=aes(x=windDirOrdered, y=changeMaxTemp),
                 na.rm = TRUE) +
    annotate(geom="point",
             x = xVector,
             y = yVector,
             size = pointSize,
             color =rgb(red=0, green=.3, blue=.7),  # same for all points
             fill = pointFill,
             shape = 24)+
    annotate(geom="rect",   
             xmin = c(1.8, 1.8, 1.8),    
             xmax = c(1.96, 1.96, 1.96),    
             ymin = c(25,23,-22),    
             ymax = c(27,25,-20),   
             linetype=1,
             color = "black",
             fill = "black") +
    #Labels the points with their value
    annotate(geom = "text",
             x = c(1.9,1.9,1.9),
             y = c(26,24,-21),
             label = c(26,24,-21),
             color = c("purple", "orange", "red"))+
    theme_bw() +
    labs(title = "Change in Temperature vs. Wind Direction",
         subtitle = "Lansing, Michigan: 2016",
         x = "Wind Direction",
         y = "Change in Temperature (\u00B0F)");
  
  plot(plot3)
  
  plot4 = ggplot() +
    geom_boxplot(mapping=aes(x=windDirOrdered, y=weatherData$changeMaxTemp),
                 na.rm = TRUE) +
    annotate(geom="point",
             x = xVector,
             y = yVector,
             size = pointSize,
             color =rgb(red=0, green=.3, blue=.7),  # same for all points
             fill = pointFill,
             shape = 24)+
    annotate(geom="rect",   
             xmin = c(1.8, 1.8, 1.8),    
             xmax = c(1.96, 1.96, 1.96),    
             ymin = c(25,23,-22),    
             ymax = c(27,25,-20),   
             linetype=1,
             color = "black",
             fill = "black") +
    #Labels the points with their value
    annotate(geom = "text",
             x = c(1.9,1.9,1.9),
             y = c(26,24,-21),
             label = c(26,24,-21),
             color = c("purple", "orange", "red"))+
    theme_bw() +
    labs(title = "Change in Temperature vs. Wind Direction",
         subtitle = "Lansing, Michigan: 2016",
         x = "Wind Direction",
         y = "Change in Temperature (\u00B0F)");
  
  plot(plot4) 
  
  ######  Group 2: ##############################################
  # - Continue working in the script file Class7.R
  # - create a scatterplot of pressure vs humidity
  # - facet_wrap two other variables to create between 9 and 30 plots
  #    - hint: https://ggplot2.tidyverse.org/reference/vars.html
  #    - change either the number of rows or columns in the facet_wrap
  #    - hint: https://ggplot2.tidyverse.org/reference/facet_wrap.html
  #    - modify one other argument (aside from rows and columns) in facet_wrap 
  #    - explain what the other argument does in comments
  # - facet_grid the same two variable for the same scatterplot
  ###############################################################
  # Create a new column called month (will use in facet_wrap)
  dateFormatted = as.Date(weatherData$dateYr, "%Y-%m-%d"); # properly format date
  monthAbb = format(dateFormatted, "%b");  # extract the month from the date
  weatherData$month = monthAbb;   # save month vector to data frame
  
  plot5 = ggplot(data=weatherData) +
    theme_bw() +
    geom_point(mapping=aes(x=windSpeed, y=relHum)) +
    geom_smooth(mapping=aes(x=windSpeed, y=relHum),
                method = "lm",
                fill = "red") + 
    facet_wrap(facets = vars(windDir),
               nrow=1,
               ncol=4,
               switch = "y");  # this has to be a column in the data frame
  plot(plot5);
  
  plot6 = ggplot(data=weatherData) +
    theme_bw() +
    geom_point(mapping=aes(x=stnPressure, y=windSusSpeed)) +
    geom_smooth(mapping=aes(x=stnPressure, y=windSusSpeed),
                method = "lm",
                fill = "red") + 
    facet_wrap(facets = vars(season));  # this has to be a column in the data frame
  plot(plot6);
  
  
  
}
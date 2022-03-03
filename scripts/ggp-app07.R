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
    theme_bw() +
    labs(title = "Change in Temperature vs. Wind Direction",
         subtitle = "Lansing, Michigan: 2016",
         x = "Wind Direction",
         y = "Change in Temperature (\u00B0F)");
  
  plot2 = plot1+
    annotate(geom="point",
             x = xVector,
             y = yVector,
             size = pointSize,
             color =rgb(red=0, green=.3, blue=.7),  # same for all points
             fill = pointFill,
             shape = 24);                           # same for all points
  plot(plot2);
  
  plot3 = plot2+
    #Put black boxes behind the labels
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
             color = c("purple", "orange", "red"));

  plot(plot3);

  #### APP 2 ---- Plot 4 - Plot7 ####
  temp100 = weatherData$avgTemp[0:99];
  hum100 = weatherData$relHum[0:99];
  
  plot4 = ggplot()+ # creating a canvas without a data frame
    theme_bw() +
    annotate(geom="point",
             x = temp100, # not mapped -- needs to be explicit
             y = hum100,  # not mapped -- needs to be explicit
             size = 2,
             color = "blue",
             fill = "lightblue",
             shape = 22) + 
    labs(title="Scatterplot using annotate",
         x = "Average Temperature(\u00B0F)",
         y = "Relative Humidity(\u0025)");
  plot(plot4);
  
  #create red polygons
  plot5 = plot4+
    annotate(geom = "polygon",
             x = c(21,21,7,6,9),
             y = c(87,60,60,65,75),
             color = "blue",
             fill = "green",
             linetype = 4,
             alpha = 0.4);
  plot(plot5);
  
  #Add a horizontal and vertical lines that represent the median 
  #temperature and median humidity for the 100 values
  medianTemp = median(temp100);
  medianHum = median(hum100);
  
  plot6 = plot5 +
    geom_vline(mapping=aes(xintercept = medianTemp),
               color = "orange",
               size= 2) +
    geom_hline(mapping=aes(yintercept = medianHum),
               color="purple",
               size=2);
  plot(plot6);
  
  #Create an ellipse that covers the 9 points circled in grey below
  plot7 =  plot6+
    geom_ellipse(mapping=aes(x0 = 44, y0 = 90, a = 17, b=8.5, angle=50),
                 alpha=0.2,   
                 color = "blue",
                 fill = "green",
                 size=2,
                 linetype=3);
  plot(plot7);
   
  #### APP 3 ---- Plot8 -  #### 
  xVector = seq(1,1000, by=1);
  yVector = sqrt(seq(1:1000));
  
  plot8 = ggplot() +
    theme_bw() +
    annotate(geom="point",
                       x = xVector,
                       y = yVector,
                       size = 2.5,
                       color ="lightyellow",  # same for all points
                       fill = "lightyellow",
                       shape = 24)+
    annotate(geom ="line",
                   x=seq(1,1000, by=1),
    
                   y=sqrt(seq(1:1000)),
                   color = "red",
                   linetype=1,
                   size = 1,
                   arrow = arrow())+
    labs(title="Plot of square of x",
                   x = "Sequence from 1 to 1000",
                   y = "Square Value");                           # same for all points
  plot(plot8);
  
}
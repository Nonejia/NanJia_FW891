
  
  #################Library import and data read###################
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package
  
  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016NOAA.csv", 
                         stringsAsFactors = FALSE);  # for people still using R v3
  
  
  ########### Add a mapping of color=season when creating linear model#######
  plot1 = ggplot( data=weatherData ) +
    geom_smooth( mapping=aes(x=avgTemp, y=relHum, color=season), 
                 method="lm" ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum, size=precip2, color=season) ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          x = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity",
          size = "Precipitation",
          color = "Seasons") +    # changes order
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) ,
           legend.position = "none");
  plot(plot1)
  
  #########   Question 1: The model simulated four different 
  ########lines based on the 4 seasons   ##########
  
  ####  Create a scatterplot that maps the four columns windDir, 
  ####  windSpeed, precip2, and tempDept ####
  plot2 = ggplot( data=weatherData ) +
    geom_smooth( mapping=aes(x=windSpeed, y= tempDept), 
                 formula = y ~ x,
                 method="lm" ) +
    geom_point( mapping=aes(x=windSpeed, y= tempDept, size=precip2, color = windDir) ) +
    labs( title="Temperature Disperison VS. Wind Speed",
          subtitle="Lansing, MI -- 2016",
          x = "Wind Speed",
          y = "Temperature Disperison",
          size = "Precipitation",
          color = "Wind Direction") +    # changes order
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) ,
           legend.position = c(0.9, 0.40));
  plot(plot2)
  
  ########################################  Question 2  ############################################ 
  #### After observation, it can be seen that among all wind directions, 
  #### the east wind is the least. 
  #### Second, the points with larger rainfall (>1.0) are also closer to 
  #### the fitted line. The points 
  #### with larger rainfall in the west wind are mostly above the fitted line.
  
  ####  Create a scatterplot that (somewhat intelligently) makes use of five 
  ####  mappings in one component. ####
  plot3 = ggplot( data=weatherData ) +

    geom_point( mapping=aes(x=windSpeed, y= tempDept, size=precip2, color = windDir, alpha = tempDept) ) +
    labs( title="Temperature Disperison VS. Wind Speed",
          subtitle="Lansing, MI -- 2016",
          x = "Wind Speed",
          y = "Temperature Disperison",
          size = "Precipitation",
          color = "Wind Direction") +    # changes order
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) ,
           legend.position = "bottom");
  plot(plot3)
##no more than 85 characters
  ########################################  Question to answer  ############################################
  # 1. This assignment makes me feel inspired and provide a useful template 
  # for my future data analysis needs.
  # 2. It took almost 2 h 30 minutes to read all codes and complete the homework.
  # 3. Actually, I did have one. I am really wondering that how can we point a 
  # specific symbol when we use 
  # "color" parameter. 
  # 4. Maybe some data pre-processing skills. It might be really helpful 
  # for us to deal with the NAN values, or 
  # manipulate the matrix calculations.
  
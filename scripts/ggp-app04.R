{
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package
  
  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016.csv", 
                         stringsAsFactors = FALSE);  # for people still using R v3

  #### Part 1####
  plot1 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum),
                color=rgb(red=0.3, green=0.3, blue=0.6),
                size=3.5,
                na.rm = TRUE,
                position = "identity",
                shape="\u00A7",
                alpha = 0.4 ) +
    theme_bw() +
    labs(title = "Humidity vs. Temperature",
         subtitle = "Lansing, Michigan: 2016",
         x = "Temperature (\u00B0F)",
         y = "Humidity (\u0025)") +
    theme(axis.title.x=element_text(size=14, 
                                    color=rgb(red=0.7, green=0.4, blue=0.5),
                                    family = 'sans',
                                    angle = 10),
          axis.title.y=element_text(size=14, color=rgb(red=0.7, green=0.5, blue=0.5)), 
          axis.text.x = element_text(colour = "grey", 
                                   size = rel(1.0),
                                   face = "bold", 
                                   angle = 45,
                                   hjust = 0.5,
                                   vjust = 0.5,
                                   family = 'sans',
                                   lineheight = 0.5,
                                   margin = NULL,
                                   debug = TRUE),
          axis.text.y = element_text(colour = "brown", 
                                     size = rel(1.0),
                                     face = "bold", 
                                     family = 'sans',
                                     lineheight = 0.5,
                                     margin = NULL,
                                     debug = TRUE),
          plot.title=element_text(size=19, face="bold.italic", 
                                  color =rgb(red=0.7, green=0.4, blue=0.6)),
          plot.subtitle=element_text(size=10, face="italic", 
                                     color ="blue", family="sans"),
          plot.caption=element_text(size=15),
          
          panel.background = element_rect(fill="grey95", 
                                          colour=rgb(red=0.7, green=0.5, blue=0.5),
                                          linetype = 3,
                                          size = 1.2,
                                          inherit.blank = FALSE,
                                          margin(2, 2, 2, 2, "cm")),
          axis.line = element_line(arrow = arrow(),size = 0.7, colour = "lightblue"));
  plot(plot1);
  
  #### Part 2####  
  plot2 = ggplot(data=weatherData) +
    geom_line(mapping=aes(x=1:nrow(weatherData), y=maxTemp),
              color="darkgreen",size = 0.5) +
    geom_line(mapping=aes(x=1:nrow(weatherData), y=minTemp), 
              color=rgb(red=0.4, green=0.7, blue=0.9),size = 0.5) + 
    
    theme_bw() +
    geom_smooth(mapping=aes(x=1:nrow(weatherData), y=avgTemp),
                method="loess",
                color=rgb(red=1, green=0.5, blue=0),
                linetype=3,
                size=2.6, 
                fill="lightgreen") +
    labs(title = "Temperature throughout the year",
         subtitle = "Lansing, Michigan: 2016",
         x = "Day (row) number",
         y = "Temperature (\u00B0F)") +
    theme(axis.ticks = element_line(color=rgb(red=0.7, green=0.5, blue=0.5), 
                                    size=0.7,linetype = 2),
          panel.grid.minor = element_line(color="grey80", linetype=4),
          panel.grid.major = element_line(color="grey66"),
          panel.background = element_rect(fill="grey98", 
                                          color=rgb(red=0.7, green=0.5, blue=0.5)));
  plot(plot2);
  
  #### Part 3####
  plot3 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum, color=season, size=precip2), 
                color="darkblue", # this overrides the color mapping
                shape="\u018f") +
    theme_bw() +
    labs(title = "Humidity vs. Temperature",
         subtitle = "Lansing, Michigan: 2016",
         x = "Temperature (F)",
         y = "Humidity (%)")+
  theme(legend.title = element_text(size =15, color = "firebrick"),
        legend.key = element_rect(fill = 'lightblue'),
        legend.background = element_rect(fill = "green"),
        plot.background = element_rect(fill = "khaki"));
  plot(plot3);
  
  #### Report  ####
  #For this assignment, I draw two plots. The first one is the point plot, I  
  #included 6 modifications, color, size, na.rm, position, shape and alpha.
  #Meanwhile, I used one alpha (geom_point), 5 rgb color(geom_point,axis.title.y
  #axis.title.x,plot.title,panel.background), 3 uses of unicode(labs of x and y,
  #shape),2 element_rect, 8 element_text and 1 grayscale.
  #The second plot is the line plot. I included 8 modification to plot lines, 
  #added 1 unicode (subtitle of y), 5 element_line(panel.grid.minor,panel.
  #grid.major,panel.background),3 grey scales.While the third plot used one 
  #unicode, complete all requirements.
  
  ####  Questions  ####
  #1. It is fine for me to understand and follow the assignments' requirements.
  #2. Do not have for now.
  #3. The smooth line enbales me to map the deep learning training loos plot.
  #4. Map a set of graphs from one csv file, such as 3*2 or 4*3 figures.
  
  
  }
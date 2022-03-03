{
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package
  
  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016.csv", 
                         stringsAsFactors = FALSE);  # for people still using R v3
  
  windDir_2 = factor(weatherData$windDir,
                         levels=c("North", "East", "South", "West"));
  plot1 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=relHum, y=avgTemp,shape=windDir_2, color=windSpeed),
                size=3.5,
                na.rm = TRUE,
                position = "identity",
                alpha = 0.7 ) +
    theme_bw() +
    labs(title = "Humidity vs. Temperature",
         subtitle = "Lansing, Michigan: 2016",
         x = "Humidity (\u0025)",
         y = "Temp (F)") +
    scale_x_continuous( minor_breaks= seq(from =25,to=100,by=10),breaks = seq(from=50, to=90, by=10), 
                        limits = c(30,100)) +
    scale_y_continuous( breaks = seq(from=0, to=100, by=25),
                        limits = c(-1,110)) +

    theme(
          axis.title.y=element_text(size=15, angle = 0, vjust = 0.5), 
          axis.text.x  = element_text(colour = "brown", size = rel(1.0),face = "bold", angle = 270,
                                   hjust = 0.5),
          plot.title=element_text(size=19, face="bold", 
                                  color ="darkgreen",hjust =0.5),
          plot.subtitle=element_text(size=10, face="italic",hjust =0.5),
          plot.background = element_rect(fill = rgb(red = 255,green = 255,blue = 224,maxColorValue = 255)),
          panel.background = element_rect(fill="black", color= "black",size = 1.2),
          panel.grid.major = element_line(color ="grey20", linetype = 1), 
          panel.grid.minor = element_line(color = "grey20", linetype = 2),
          axis.line = element_line(size = 2.5, colour = rgb(red = 0,green = 0,blue = 224,maxColorValue = 255)));
  plot(plot1);
  ####set the shape and color bar
  plot2 = plot1+
    scale_shape_manual(values = c("~","%","@","*"))+
    scale_color_gradientn(colors=c("green", "yellow", "purple"));
  plot(plot2);
  #### set legend adjustments
  plot3 = plot2+
    theme(legend.position = 'bottom',
          legend.direction = "horizontal",
          legend.background = element_rect(fill= "grey90",color = "lightgreen", size = 1.5, linetype = 2),
          legend.key = element_rect(fill = "lightblue", color = "blue"));
  plot(plot3);
  
  ####set legend position
  plot4 = plot3+
    guides(color = guide_legend(order = 1),
           size = guide_legend(order=2));
  plot(plot4);
  
}

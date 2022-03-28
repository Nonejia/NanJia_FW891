{
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package
  library(package=ggforce);              # for geom_circle, geom_ellipse
  
  #### Two bugs in GGPlot that cause issues with including data and mapping:
  #    1) faceting data must come from a declared (local or global)data frame
  #    2) annotate (manually adding objects) does not work for all geoms_* 
  #       -- hline/vline/circles/ellipses...
  
  #### Group 1: 
  #    Using plotA1, create curve that matches the picture 
  #      - Use annotate to create the brown curve
  #      - Use geom_curve to create the green curve
  #      - need angle, curvature, arrow (subcomponents of geom_curve)
  #      -      x, y, xend, yend (aesthetics)
  #    https://ggplot2.tidyverse.org/reference/geom_segment.html
  
  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016NOAA.csv");
  janTemps = read.csv(file="data/LansingJanTemps.csv");  # second data frame
  
  #### Part A: Include data globally from a data frame #####
  ## Note: you can make the mapping global -- I do not recommend this...
  plotA1 = ggplot(data=weatherData) +  # generally what I recommend
    theme_bw() +
    geom_point(mapping=aes(x=avgTemp, y=relHum)) +
    geom_smooth(mapping=aes(x=avgTemp, y=relHum),
                method = "lm",
                fill = "red")+
    geom_curve(mapping = aes(x=36, y=50, xend = 20, yend = 48), 
               size=1.15, 
               color="darkgreen",
               curvature = -1, 
               arrow = arrow())+
    annotate(
      geom = "curve", 
      x = 65, 
      y = 89,
      xend = 82, 
      yend = 83,
      size = 1.15,
      curvature = -1, 
      color = "#CC9900",
      arrow = arrow()
    )
  plot(plotA1);
  
  #### Group 2:
  ## Using plotA1 (same as group 1)
  ##  - Create an X that connects to all four corners using geom_abline
  ##    - being exact is not necessary!
  ##    - change the color, linetype, size, and opacity of the X
  ##  - create text using one annotate component in the top-right and top-left corner
  ##    - make 3 property changes to the text
  ##  - create text using one geom_text component in the bottom-right and bottom-left corner
  ##    - make 3 property changes to the text   
  ##    - try to do this without a legend
  plotA2 = ggplot(data=weatherData) +  
    theme_bw() +
    geom_point(mapping=aes(x=avgTemp, y=relHum)) +
    geom_smooth(mapping=aes(x=avgTemp, y=relHum),
                method = "lm",
                fill = "red")+
    geom_abline(slope = c(-0.75,0.8), intercept =  c(100,30),             
                color="black");
  plot(plotA2)
  
  
  
  
  
}
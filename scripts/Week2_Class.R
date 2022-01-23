##################################Application#################################

#1.	The “geom_label() geom_text()” function works for us to 
#create a test plot based on this week’s tutorial. 
#And the subcomponent in theme(), called axis.text.x and element_text 
#will be helpful for it. Also, the geom_label() geom_text() functions 
#will also help to map the text. 
#2.	Through the scale_x_continuous(), we can modify the breaks on the x-axis
#############################################################################

rm(list=ls());                         # clear the Environment tab
options(show.error.locations = TRUE);  # show line numbers on error
library(package=ggplot2);              # include all GGPlot2 functions

options(show.error.locations = TRUE);  # show line numbers on error

library(package=ggplot2);              # include all GGPlot2 functions

# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA.csv");


#### stnPressure vs windSpeed ####
plot1 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=stnPressure, y=windSpeed) ) +
  labs( title="Standard Pressuree VS Wind Speed",
        subtitle="Lansing, MI -- 2016",
        x = "Standard Pressure",
        y = "Wind Speed") +
  scale_x_continuous( breaks = seq(from=28, to=30, by=0.1),
                      limits = c(28.5,29.5)) +
  scale_y_continuous( breaks = seq(from=3, to=25, by=9),
                      limits = c(3,21)) +
  theme( axis.text.x=element_text(angle=45, vjust=0.5,
                                  color = "blue", 
                                  size = 12) ,plot.background = element_rect('lightblue') ) ;

plot(plot1)


##############################Answer to 10.1#################################
#1. Since I am a total typo to R language, but have programming background on
#Python, so I think it is a bit challenge but inspired. Love it for now!

#2. I think the tutorials gave prefect instructions of this course.

#3. I only want to ask for a favor, if possible, is there any possibility for 
#us to re-draw some figures from sentific paper? It might be really helpful.

#############################################################################

#### Part 5: Changing the theme --- oops, undoes theme ####
plot5 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  labs( title="Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
        y = "Relative Humidity") +
  scale_x_continuous( n.breaks = 5,minor_breaks = NULL) +
  theme( axis.text.x = element_text(angle=0, vjust=0.5,
                                    color = "lightblue", 
                                    size = 12, family = "Times New Roman") );
plot(plot5)
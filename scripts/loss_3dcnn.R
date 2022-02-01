#################Library import and data read###################
rm(list=ls());                         # clear Environment tab
options(show.error.locations = TRUE);  # show line numbers on error
library(package=ggplot2);              # get the GGPlot package
library(ggbump)
library(dplyr)

loss = read.csv(file="Data/noatt_train_loss.csv", 
               stringsAsFactors = FALSE);

#plot1 = ggplot(data = loss, mapping = aes (x = Step, y = V))+
#  geom_bump(aes(x = Step, y = v))

#plot(plot1)

plot2 = ggplot( data=loss ) +
  geom_bump( mapping=aes(x=Step, y= Value),color = 'lightblue' ) +
  #geom_smooth( mapping=aes(x=Step, y= V))
  labs( x = "Step",
        y = "Value") +   
  scale_x_continuous( breaks = seq(from=10, to=400, by=80) ) +
  theme_bw() +
  theme( axis.text.x=element_text(angle=90, vjust=0.5) ,
         legend.position = c(0.9, 0.40));
plot(plot2)

#plot3 = ggplot(data=loss, aes(x=Step, y= V, colour=treatment)) + 
#  geom_smooth(method = "nls", method.args = 
#                list(formula = y ~ a * x / (b + x), start = list(a = 1, b = 1)), 
#              data = loss, se = FALSE, col = "black")
#plot(plot3)

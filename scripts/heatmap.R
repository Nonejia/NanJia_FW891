
library(pheatmap) 
library(ggplot2) 
library(readxl)



data <- read_xlsx('Data/heatmap.xlsx',2,range = 'M9:P12')
data <- as.matrix(data)
rownames(data) <- data[,1]
data1<- data.frame(data[,-1])
data1$Other<-as.numeric(data1$Other)
data1$Rice<-as.numeric(data1$Rice)
data1$Corn<-as.numeric(data1$Corn)

p <- pheatmap(data1,display_numbers = T,fontsize_number = 14,
              cluster_cols = F, 
              cluster_rows = F,
              number_color="white",
              legend = TRUE,
              fontsize_row = 14,
              fontsize_col = 14,
              angle_col = 0,
              color =  colorRampPalette(c("#d4f3a3", "#329d82", "#0b4151"))(100))

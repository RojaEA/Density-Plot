library(lubridate)
library(scales)
library(usethis)
library(devtools)
library(ggplot2)
library(dplyr)
library(ggExtra)
library(gridExtra)
library(rgl)
library(ggpubr)
library(hexbin)
library(RColorBrewer)
theme_set(theme_bw())

# conflict density - data set 1 ...............................................
data <- dataset1
x <- data$xcollide
y <- data$ycollide
df <- data.frame(x=x, y=y)
myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")), space="Lab")

p1 <- ggplot(df, aes(x,y, fill=..level..) ) + 
  stat_density_2d(bins=25, geom = "polygon") +
  scale_fill_gradientn(colours = myPalette(11)) +
  labs(x = "X-position (m)", y = "Y-position (m)") +
  theme_light()+
  #theme(axis.text=element_text(size=10),
    #    axis.title=element_text(size=16))+
 # theme(legend.text=element_text(size=10),
    #  legend.title=element_text(size=16))+
 # theme(legend.title = element_blank())+
  #theme(legend.position = "none")+
  coord_fixed(ratio =1)

# conflict density - data set 2 ..............................................
data1 <- dataset2
x <- data1$x_colide
y <- data1$y_colide
df1 <- data.frame(x=x, y=y)
myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")), space="Lab")

p2 <- ggplot(df1, aes(x,y, fill =..level..) ) + 
  stat_density_2d(bins=25, geom = "polygon") +
  scale_fill_gradientn(colours = myPalette(11)) +
  labs(x = "X-position (m)", y = "") +
  theme_light()+
  theme(axis.text=element_text(size=8),
        axis.title=element_text(size=9))+
  theme(legend.text=element_text(size=8),
        legend.title=element_text(size=9))+
  theme(
    # Change legend background color
    #legend.background = element_rect(fill = "darkgray"),
    # legend.key = element_rect(fill = "lightblue", color = NA),
    # Change legend key size and key width
    legend.key.height = unit(0.7, "cm"),
    legend.key.width = unit(0.4,"cm") 
  )+
  coord_fixed(ratio =1)


p12 <- p1 + p2
p12[[1,2]] <- p12[[1,2]] & theme_light()+
  theme(axis.text=element_text(size=8),
        axis.title=element_text(size=9))+
  theme(legend.text=element_text(size=8),
        legend.title=element_text(size=9))+
  theme(
    # Change legend background color
    #legend.background = element_rect(fill = "darkgray"),
    # legend.key = element_rect(fill = "lightblue", color = NA),
    # Change legend key size and key width
    legend.key.height = unit(0.7, "cm"),
    legend.key.width = unit(0.4,"cm") 
  )
p12

dev.off()
ggsave("saving.pdf", p12)


grid.arrange(p1, p2, nrow = 1)

grid.arrange(arrangeGrob(p1,p2, ncol=2, nrow=1)) 

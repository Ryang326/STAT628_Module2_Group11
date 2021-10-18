rm(list = ls())
library(magrittr)
library(tidyverse)
data <- read.csv("BodyFat.csv")
data %<>% filter(BODYFAT >= 3 & AGE != 81 & IDNO != 96 & IDNO != 39)

BMI <- function( HEIGHT = NULL, WEIGHT = NULL, ADIPOSITY = NULL ){
  if(is.null(HEIGHT) == F & is.null(WEIGHT) == T & is.null(ADIPOSITY) == F){
    WEIGHT_1 <- ADIPOSITY * (HEIGHT/100)^2
    return(WEIGHT_1)
  }
  if(is.null(HEIGHT) == T & is.null(WEIGHT) == F & is.null(ADIPOSITY) == F){
    HEIGHT_1 <- sqrt(WEIGHT / ADIPOSITY) * 100
    return(HEIGHT_1)
  }
}

error_bodyfat_index <- abs(data$BODYFAT - (495/data$DENSITY - 450)) >= 3

data$IDNO[error_bodyfat_index]
data[error_bodyfat_index,]
data %<>% mutate(
  BODYFAT = replace(BODYFAT,error_bodyfat_index, round(495/DENSITY[error_bodyfat_index] - 450,1)))
data[error_bodyfat_index,]

plot(data$DENSITY, data$BODYFAT)

data$HEIGHT <-  round(data$HEIGHT * 2.54, 2)
data$WEIGHT <- round(data$WEIGHT * 0.454, 2)

error_height_index <- which(data$HEIGHT < 100)
data$HEIGHT[error_height_index] <- BMI(WEIGHT = data$WEIGHT[error_height_index],
                                       ADIPOSITY = data$ADIPOSITY[error_height_index])%>%round(2)

hist(data$HEIGHT)
hist(data$WEIGHT)
hist(data$AGE)

write.csv(data,"data_tidied.csv")




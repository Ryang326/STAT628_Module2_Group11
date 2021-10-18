rm(list = ls())
library(tidyverse)
library(lars)
data <- read.csv("data_tidied.csv")
data <- data[,-1]
n <- nrow(data)

library(caret)
train_ctrl <- trainControl(method = "LOOCV")
model <- train(BODYFAT ~ AGE + ABDOMEN+ WRIST  + HEIGHT, data = data, method = "lm", trControl = train_ctrl)
print(model)
summary(model)


# age group ---------------------------------------------------------------


data$AGEgroup <- 0
data$AGEgroup[data$AGE<=30] <- 1
data$AGEgroup[data$AGE<=40 & data$AGE>30] <- 2
data$AGEgroup[data$AGE<=50 & data$AGE>40] <- 3
data$AGEgroup[data$AGE<=60 & data$AGE>50] <- 4
data$AGEgroup[data$AGE>60] <- 5
data$AGEgroup <- as.factor(data$AGEgroup)


# model2 ------------------------------------------------------------------


train_ctrl <- trainControl(method = "LOOCV")
model2 <- train(BODYFAT ~ AGEgroup + ABDOMEN + HEIGHT, data = data, method = "lm", trControl = train_ctrl)
print(model2)
summary(model2)


# comparison --------------------------------------------------------------


BIC(model2$finalModel)
BIC(model$finalModel)
AIC(model2$finalModel)
AIC(model$finalModel)
library(AICcmodavg)
models <- list(model$finalModel, model2$finalModel)
aictab(cand.set = models)

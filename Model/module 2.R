rm(list = ls())
library(tidyverse)
library(lars)
library(car)
data <- read.csv("data_tidied.csv")
data <- data[,-1]
n <- nrow(data)

library(caret)
train_ctrl <- trainControl(method = "LOOCV")
model <- train(BODYFAT ~ AGE + HEIGHT + ABDOMEN + WRIST, data = data, method = "lm", trControl = train_ctrl)
print(model)
summary(model)


# age group ---------------------------------------------------------------

data$AGEgroup <- cut(data$AGE, breaks=c(20,40,80), right = TRUE)


# model2 ------------------------------------------------------------------


train_ctrl <- trainControl(method = "LOOCV")
model2 <- train(BODYFAT ~ AGEgroup + ABDOMEN + HEIGHT + WRIST, data = data, method = "lm", trControl = train_ctrl)
print(model2)
summary(model2) 



# model2 diagonostics ------------------------------------------------------------------
res <- model2$finalModel$residuals
shapiro.test(res)
vif(model2$finalModel)
qqnorm(res, pch=19)
qqline(res, col='red')

plot(res~model$finalModel$fitted.values, main='Residual vs Fitted', xlab='Fitted Values', ylab='Residuals', ylim=c(-10,10), pch=19, col='blue')
abline(h=0, col='red')
# prediction--------------------------------------------------------------
younger <- ifelse(data$AGE<=40, 1, 0)
older <- ifelse(data$AGE>40, 1, 0)
df <- data.frame(height=data$HEIGHT, wrist=data$WRIST, abdomen=data$ABDOMEN, older=older, younger=younger)
train_ctrl <- trainControl(method = "LOOCV")
model<- train(bodyfat ~ height + wrist + abdomen + older + younger, data = df, method = "lm", trControl = train_ctrl)


mod<-model$finalModel

avgdat <- data.frame(abdomen=c(102.87, 102.87), height=c(175.4,175.4), wrist = c(18.42,18.42), older = c(0,1), younger = c(1,0))
predict(mod, avgdat, interval = 'confidence')





rm(list = ls())
library(tidyverse)
library(lars)
data <- read.csv("data_tidied.csv")
data <- data[,-1]
n <- nrow(data)

library(caret)

# model1 -------------use age as a continuous variable----------------------------
train_ctrl <- trainControl(method = "LOOCV")
model <- train(BODYFAT ~ AGE + HEIGHT + ABDOMEN + WRIST, data = data, method = "lm", trControl = train_ctrl)
print(model)
summary(model)

mod1 <- model$finalModel
shapiro.test(mod1$residuals)

# model2 ------------use age as a categorical variable cut off by 40--------------

data$AGEgroup <- cut(data$AGE, breaks=c(20,40,80), right = TRUE)
train_ctrl <- trainControl(method = "LOOCV")
model2 <- train(BODYFAT ~ AGEgroup + ABDOMEN + HEIGHT + WRIST, data = data, method = "lm", trControl = train_ctrl)
print(model2)
summary(model2) 

res <- model2$finalModel$residuals
shapiro.test(res)
mod2_wth_wrist <- model2$finalModel

man_data <- data.frame(
  AGE = 25,
  ABDOMEN = 100,
  HEIGHT = 180,
  WRIST = 20
)
man_data$AGEgroup <- cut(man_data$AGE, breaks=c(20,40,80), right = TRUE)
predict(model2,man_data)


# model3 ------------remove the predictor wrist in our model----------------------
train_ctrl <- trainControl(method = "LOOCV")
model3 <- train(BODYFAT ~ AGEgroup + ABDOMEN + HEIGHT, data = data, method = "lm", trControl = train_ctrl)
print(model3)
summary(model3)
mod3_wot_wrist <- model3$finalModel
shapiro.test(mod3_wot_wrist$residuals)

save(mod3_wot_wrist,mod2_wth_wrist,file = "BFmodels.Rda")

# comparison --------------------------------------------------------------


BIC(model2$finalModel)
BIC(model$finalModel)
AIC(model2$finalModel)
AIC(model$finalModel)
library(AICcmodavg)
models <- list(model$finalModel, model2$finalModel)
aictab(cand.set = models)

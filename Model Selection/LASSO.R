rm(list = ls())
library(tidyverse)
library(lars)
data <- read.csv("data_tidied.csv")
n <- nrow(data)

# build predictor matrix and name its columns
train_index <- sample(1:n, floor(0.8*n), replace = F)
train <- data[train_index,]
test <- data[setdiff(1:n, train_index),]
predictor <- as.matrix(train%>%select(AGE:WRIST))
colnames(predictor) <- colnames(data)[5:18]

# lasso
lasso_1 <- lars(predictor,train$BODYFAT, type = "lasso")
summary(lasso_1)
plot(lasso_1)
coef(lasso_1)

# fit model
linear_1 <- lm(BODYFAT ~ AGE + ABDOMEN + WRIST + HEIGHT , data = train)
summary(linear_1)
pred <- predict(linear_1,test)
res <- pred - test$BODYFAT


# diagnose
qqnorm(res)
qqline(res)
shapiro.test(res)
hist(res)
plot(pred, res)
abline(h = 0 , lty = 2, col = 2)

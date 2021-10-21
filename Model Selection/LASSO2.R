rm(list=ls())
library('glmnet')

data <- read.csv("data_tidied.csv")
n <- nrow(data)


train_index <- sample(1:n, floor(0.8*n), replace = F)
train <- data[train_index,]
test <- data[setdiff(1:n, train_index),]
predictor <- as.matrix(train%>%select(AGE:WRIST))
colnames(predictor) <- colnames(data)[5:18]

cvfit <- glmnet::cv.glmnet(predictor, train$BODYFAT)
coef(cvfit, s = "lambda.1se")

# age <- cut(data$AGE, breaks=c(20, 30, 40, 50, 60, 70, 80), right = FALSE)



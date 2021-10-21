# STAT628_Module2_Group11
This ReadMe file is for description for Module2 Group 11 of STAT 628 2021 Fall.

Our group member: Brian Tsai, Tinghui Xu, Shengwen Yang
# Data Cleaning
This directory includes original datasets, cleaned version datasets and the R script to clean the data.
* BodayFat.csv: the orginal datasets from [this link](http://staff.pubhealth.ku.dk/~tag/Teaching/share/data/Bodyfat.html#org16c7c47).
* data_tidied.csv: the cleaned datasets from BodayFat.csv by tidy_data_1.0.R.
* tidy_data_1.0.R: the R script to do the data cleaning.

# Final Model 
This directory includes the script we used for our final model as well as some predictions and diagnosis  
* finalmodel.R: the R script to implement our final model of multiple linear regression model with leaving one out cross validation. 

# Model Selection
This directory includes scripts that we used to try different models on the data and to choose the important variables.
* LASSO.R: the R script to implement the lasso regression model and feature selection.
* LASSO2.R: another R script to implement the lasso regression model with different packages and feature selection
* RandomForest.ipynb: the Python script to implement the random forest model
* XGboost.ipynb: the Python script to implement the XGBoost model
* ModelSelection&Diagnosis.R: the R script to select three different multiple linear regression models


# Shiny App
This directory includes the R script to build the web-based shiny app based on the final model we got.
* BODYFATCALCULATOR-GROUP11.zip: the zip file to build our shiny app

# Summary and Presentation
This directory includes the pdf file of our executive summary and presentation slide for this body fat study.
* STAT_628_Module2_Group_11_BodyFat_Project_Summary.pdf: our executive summary
* Stat628 Module2 Group 11 BodyFat Project Presentation.pptx: our presentation slide

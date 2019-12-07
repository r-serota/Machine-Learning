# Project ML

rm(list=ls()) # to delete all variables

library(data.table)
# library(dplyr)
library(tidyr)
library(leaps)

data <- read.table("student-por.csv",sep=";",header=TRUE)
data <- na.omit(data)
data <- setDT(data)

VariablesClasses <- data %>% summarise_all(class) %>% gather # checking variables' classes

data[,G2 := NULL] # deleting a variable
data[,G3 := NULL]

# TODO (create a function)
data$Medu <- factor(data$Medu, order=T, levels = c(0,1,2,3,4))
data$Fedu <- factor(data$Fedu, order=T, levels = c(0,1,2,3,4))
data$traveltime <- factor(data$traveltime, order=T, levels = c(1,2,3,4))
data$studytime <- factor(data$studytime, order=T, levels = c(1,2,3,4))
data$famrel <- factor(data$famrel, order=T, levels = c(1,2,3,4,5))
data$freetime <- factor(data$freetime, order=T, levels = c(1,2,3,4,5))
data$goout <- factor(data$goout, order=T, levels = c(1,2,3,4,5))
data$Dalc <- factor(data$Dalc, order=T, levels = c(1,2,3,4,5))
data$Walc <- factor(data$Walc, order=T, levels = c(1,2,3,4,5))
data$health <- factor(data$health, order=T, levels = c(1,2,3,4,5))


# Model selection 

regfit.full = regsubsets(G3 ~ ., data = data)
regfit.full = regsubsets(G3 ~ ., data = data, really.big=T)
summary(regfit.full)

regfit.full = regsubsets(G3 ~ ., data = data, nvmax = 150)


# Variables to exclude:
# school
# Mjob
# Fjob
# guardian 

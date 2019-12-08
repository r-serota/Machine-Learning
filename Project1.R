# Project ML

rm(list=ls()) # to delete all variables

library(data.table)
library(dplyr)
library(tidyr)
library(leaps)

data <- read.table("student-por.csv",sep=";",header=TRUE)
data <- na.omit(data)
data <- setDT(data)

# Cleaning our dataset
data[,G1 := NULL] # deleting a variable
data[,G2 := NULL]
data[,school := NULL]
data[,Mjob := NULL]
data[,Fjob := NULL]
data[,guardian := NULL]
data[,traveltime := NULL]
data[,romantic := NULL]
data[,goout := NULL]

VariablesClasses <- data %>% summarise_all(class) %>% gather # checking variables' classes

# split students into good or bad - "by hand"
data <- data[, studentPerformance := ifelse(G3 <= 10,0, 1)]

# TODO (create a function)
data$Medu <- factor(data$Medu, order=T, levels = c(0,1,2,3,4))
data$Fedu <- factor(data$Fedu, order=T, levels = c(0,1,2,3,4))
data$studytime <- factor(data$studytime, order=T, levels = c(1,2,3,4))
data$famrel <- factor(data$famrel, order=T, levels = c(1,2,3,4,5))
data$freetime <- factor(data$freetime, order=T, levels = c(1,2,3,4,5))
data$Dalc <- factor(data$Dalc, order=T, levels = c(1,2,3,4,5))
data$Walc <- factor(data$Walc, order=T, levels = c(1,2,3,4,5))
data$health <- factor(data$health, order=T, levels = c(1,2,3,4,5))
data$studentPerformance <- as.factor(data$studentPerformance)


# Model selection 
# We use FSS

# TODO (fix FSS)
# regfit.fwd = regsubsets(G3 ~ ., data = data, nvmax = 67, method = "forward")
# summary(regfit.fwd)
# 
# plot(regfit.fwd, scale = "Cp") # plot C_p
# 
# reg.summary = summary(regfit.fwd)
# plot(reg.summary$cp, xlab = "Number of Variables", ylab = "Cp")
# imin = which.min(reg.summary$cp)
# imin
# points(imin, reg.summary$cp[imin], pch = 20, col = "red") # add a point to the plot to highlight the minimum
# 
# coef(regfit.fwd, imin)
# 
# reg.summary$cp





#### Preamble ####
# Purpose: Clean the raw data 
# Author: Pu Yuan
# Date: 10 April 2024
# Contact: scott.yuan@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(dplyr)

#### Clean data ####
data <- read.csv("data/raw_data/life_expectancy.csv")

# Inspect the data structure
str(data)
summary(data)

# Handling missing values
# Option 1: Remove rows with any missing data
cleaned_data <- na.omit(data)

# Option 2: Impute missing values
# For continuous variables: impute with the mean or median
data$Life.expectancy[is.na(data$Life.expectancy)] <- mean(data$Life.expectancy, na.rm = TRUE)
data$Adult.Mortality[is.na(data$Adult.Mortality)] <- median(data$Adult.Mortality, na.rm = TRUE)
data$Alcohol[is.na(data$Alcohol)] <- mean(data$Alcohol, na.rm = TRUE)

# For categorical variables: impute with the mode or remove
# Assuming 'Hepatitis.B' is a categorical variable (e.g., vaccination coverage rates binned)
mode_hepb <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
data$Hepatitis.B[is.na(data$Hepatitis.B)] <- mode_hepb(data$Hepatitis.B[!is.na(data$Hepatitis.B)])

# Removing outliers (example using IQR for 'Adult.Mortality')
Q1 <- quantile(data$Adult.Mortality, 0.25, na.rm = TRUE)
Q3 <- quantile(data$Adult.Mortality, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1
data <- data %>%
  filter(Adult.Mortality >= (Q1 - 1.5 * IQR) & Adult.Mortality <= (Q3 + 1.5 * IQR))

# Convert factors if necessary
data$Country <- as.factor(data$Country)
data$Status <- as.factor(data$Status)

# Normalize/scale data (example with GDP)
data$GDP <- scale(data$GDP, center = TRUE, scale = TRUE)

# Final inspection
summary(data)
str(data)

# Save the cleaned data
write.csv(data, "data/raw_data/cleaned_life_expectancy.csv", row.names = FALSE)

#### Preamble ####
# Purpose: Test cleaned data
# Author: Pu Yuan
# Date: 10 April 2024
# Contact: scott.yuan@mail.utoronto.ca
# Pre-requisites: 02-data_cleaning.R


#### Workspace setup ####
library(dplyr)
library(ggplot2)

#### Test data ####
data <- read.csv("data/raw_data/cleaned_life_expectancy.csv")

# 1. Check for missing values
missing_values <- sapply(data, function(x) sum(is.na(x)))
cat("Missing values per column:\n")
print(missing_values)

# 2. Summary of the dataset
cat("Summary of dataset:\n")
summary(data)

# 3. Check for illogical values (e.g., negative life expectancy or percentages over 100)
if(any(data$LifeExpectancy < 0 | data$LifeExpectancy > 100)) {
  cat("There are illogical values in Life Expectancy.\n")
}

# Define current year function
currentYear <- function() {
  as.numeric(format(Sys.Date(), "%Y"))
}

# 4. Check for year values outside the expected range
if(any(data$Year < 2000 | data$Year > currentYear())) {
  cat("There are out of range values in Year.\n")
}

# 5. Visualization to identify outliers or unusual distributions
ggplot(data, aes(x = LifeExpectancy)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  theme_minimal() +
  ggtitle("Distribution of Life Expectancy")

# 6. Check correlations between key numerical variables
correlations <- cor(data %>% select_if(is.numeric), use = "complete.obs")
cat("Correlations between numeric variables:\n")
print(correlations)

# 7. Check data types to ensure data integrity
cat("Data types in the dataset:\n")
str(data)

#### Preamble ####
# Purpose: Simulate data base on a dataset from the World Health Organization.
# Author: ABC
# Date: 10 April 2024
# Contact: abc@mail.com
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
set.seed(123)

#### Simulate data ####
n <- 1000

simulated_data <- data.frame(
  Country = sample(paste("Country", 1:50), n, replace = TRUE),
  Year = sample(2000:2015, n, replace = TRUE),
  Status = sample(c("Developed", "Developing"), n, replace = TRUE, prob = c(0.2, 0.8)),
  LifeExpectancy = rnorm(n, mean = 70, sd = 10),
  AdultMortality = rnorm(n, mean = 100, sd = 20),
  Alcohol = runif(n, min = 0, max = 15),
  GDP = rnorm(n, mean = 10000, sd = 5000),
  HepatitisB = round(runif(n, min = 70, max = 100), 0),
  Measles = round(runif(n, min = 0, max = 1000), 0),
  BMI = runif(n, min = 18, max = 35),
  InfantDeaths = round(rpois(n, lambda = 5), 0),
  UnderFiveDeaths = round(rpois(n, lambda = 10), 0),
  Polio = round(runif(n, min = 70, max = 100), 0),
  TotalExpenditure = runif(n, min = 4, max = 10),
  Diphtheria = round(runif(n, min = 70, max = 100), 0),
  HIV_AIDS = runif(n, min = 0.1, max = 3),
  Population = round(runif(n, min = 100000, max = 10000000), 0),
  Thinness_1_19_years = runif(n, min = 0.1, max = 15),
  Thinness_5_9_years = runif(n, min = 0.1, max = 15),
  IncomeCompositionOfResources = runif(n, min = 0.0, max = 1.0),
  Schooling = runif(n, min = 0, max = 20)
)

# View the first few rows of the simulated data
head(simulated_data)

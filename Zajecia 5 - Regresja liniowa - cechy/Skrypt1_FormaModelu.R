# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Biblioteki reresja
#install.packages("regclass")
library("regclass")

# Link do danych: 
#   https://www.kaggle.com/datasets/kumarajarshi/life-expectancy-who

filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "Life Expectancy Data.csv"

data <- read.csv(paste0(filePath, fileName))

# Filtrujemy dane 
data2015 <- data %>% filter(Year == 2015) %>% 
  mutate(GDP_PC = GDP / Population) %>%
  mutate(Status = factor(Status))

# Rozne interpretacje danych 
  # Formula 1 - zmienne absoultne
  colnames(data2015)
  model1 <- lm(Life.expectancy ~ GDP_PC + Schooling, data = data2015)
  summary(model1)
  
  # Formula 2 - elastycznosci
  model2 <- lm(log(Life.expectancy) ~ log(GDP_PC) + log(Schooling), data = data2015)
  summary(model2)
  
  # Formula 3 - semi - elastycznosci
  model3 <- lm(log(Life.expectancy) ~ GDP_PC + Schooling, data = data2015)
  summary(model3)

# Czy zmienne sa od siebie zalezne?
  VIF(model1)

# Dodajemy zmienne = zmianiamy stala  
  model1 <- lm(Life.expectancy ~ GDP_PC + Schooling, data = data2015)
  summary(model1)
  
  model2 <- lm(Life.expectancy ~ GDP_PC + Schooling + Status, data = data2015)
  summary(model2)
  
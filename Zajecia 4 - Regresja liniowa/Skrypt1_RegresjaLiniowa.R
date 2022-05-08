# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Biblioteki wykresowe
library("ggplot2")
library("ggpubr")

# inne
library("readxl")
library("fastDummies")

# Wczytywanie danych
filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
XLSWorkbook <- "Zajecia4_dane.xlsx"
XLSSheet1Name <- "Pokemon"

danePokemon <- read_excel(paste0(filePath, XLSWorkbook), 
                          sheet = XLSSheet1Name)

# Pytanie 1: Czy ciezkie pokemony atakuja mocniej? - jedna zmienna
  
  # Zrobmy mniejsza ramke - wybierzmy tylko te kolumny ktore sa potrzebne i wyczyscmy dane
  ramkaPytanie1 <- danePokemon %>% select(sp_attack, weight_kg) %>% 
    drop_na() 

  # Na poczatek dobrze wygenerowac sobie wykres
  plot(sp_attack ~ weight_kg, data = ramkaPytanie1)

  # Wniosek: Warto usunac czesc nietypowych danych - na razie zrobmy to na oko 
  ramkaPytanie1 %<>% filter(weight_kg < 200)
  plot(sp_attack ~ weight_kg, data = ramkaPytanie1)
  
  # Stwórzmy ilosciowy model: 
  model <- lm(sp_attack ~ weight_kg, data = ramkaPytanie1)
  summary(model)
  
  # Wykres jak w Excelu
  attack_plot <- ggplot(ramkaPytanie1, aes(x=weight_kg, y=sp_attack)) + geom_point() + 
    geom_smooth(method="lm", col="black")
  attack_plot
  
  # Dodajemy rownanie 
  attack_plot <- attack_plot +  stat_regline_equation(label.x = 50, label.y = 175)
  attack_plot
    
# Pytanie 2: Czy dodatkowy wplyw moze miec plec pokemona? - wiele zmiennych
  
  # Jak poprzednio zaczynamy od wybrania danych i usuniecia brakow
  ramkaPytanie2 <- danePokemon %>% select(sp_attack, percentage_male, weight_kg) %>% 
    drop_na() 

  # Dluzsza formule mozna zapisac do zmiennej
  formula2 <- sp_attack ~ weight_kg + percentage_male
  
  model2 <- lm(formula2, data = ramkaPytanie2)
  summary(model2)
  
# Pytanie 3: Jaki wplyw ma typ pokemona - zmienne kategoryczne
  
  # Info: 
  # https://stats.oarc.ucla.edu/r/modules/coding-for-categorical-variables-in-regression-models/
  
  # Przeksztalcmy zmienna tekstowa w tzw. factor
  danePokemon %<>% mutate(type1_factor = factor(type1))

  # Wybieramy dane i usuwamy braki 
  ramkaPytanie3 <- danePokemon %>% select(sp_attack, percentage_male, weight_kg, type1_factor) %>% 
    drop_na() 
  
  # Dluzsza formule mozna zapisac do zmiennej
  formula3 <- sp_attack ~ weight_kg + percentage_male + type1_factor 
  
  model3 <- lm(formula3, data = ramkaPytanie3)
  summary(model3)
  
  # Czegos brakuje?
  levels(ramkaPytanie3$type1_factor)
  
# Poboczne: Czy zawsze musimy uzywac wszystkich zmiennych w factor?
  # Przeksztalcamy dane
  factorDummies <- dummy_cols(ramkaPytanie3$type1_factor)
  ramkaDummies <- cbind(ramkaPytanie3, factorDummies$.data_fire, factorDummies$.data_water)
  
  # Zmienimy nazwe nowych kolumn
  ramkaDummies %<>% rename(ogien = `factorDummies$.data_fire`) %>%
    rename(woda = `factorDummies$.data_water`)

  # Nowy model
  formula4 <- sp_attack ~ weight_kg + percentage_male + ogien + woda
  
  model4 <- lm(formula4, data = ramkaDummies)
  summary(model4)
  
# Poboczne: Idnentyfikacja obserwacji wplywowych
  # Sluzy do tego tzw statystyka Cooka 
  cooksd <- cooks.distance(model3)
  
  plot(cooksd)  
  text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")  # add labels
  
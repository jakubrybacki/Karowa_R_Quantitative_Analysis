# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

library("ggplot2")
library("ggpubr")

library("readxl")

# Wczytywanie danych
filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
XLSWorkbook <- "Zajecia4_dane.xlsx"
XLSSheet1Name <- "Samochody_R"

daneForza <- read_excel(paste0(filePath, XLSWorkbook), 
                        sheet = XLSSheet1Name)

# Cwiczenie 1: Zrobmy regresje ktora wytlumaczy jak srednia waga samochodow zmieniala sie w kolennych latach?


# Cwiczenie 2: Powtorzmy przyklad z XLS - jak liczba koni mechanicznych wplywa na ocene przyspieszenia


# Cwiczenie 3: Rozszerzmy model z cwiczenia 2 - czy na ocene wplywa waga? 


# Cwiczenie 4: Jak prezentuja sie oceny przyspieszenia po markach? 

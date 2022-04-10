# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Paczka której sie uczymy:
install.packages("intsvy")
library("intsvy")
help (p = "intsvy")

options(scipen=999)
options(digits=2)

# Link do danych: 
#   https://www.census.gov/data/datasets/2018/demo/health-insurance/2018-cps-asec-split-panel-test.html

# Sciezki do danych 
filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "CY07_MSU_STU_QQQ.sav"

# Zadanie: 
# 1. Pobierz dane dotyczace wynikow egzaminu PISA w 2018 roku ze strony OECD (plik SPSS)
# https://www.google.com/search?q=oced+pisa&oq=oced+pisa&aqs=chrome..69i57.1961j0j4&sourceid=chrome&ie=UTF-8

# Zalezy nam na pliku - CY07_MSU_STU_QQQ.sav

# 2. Wczytaj liste zmiennych za pomoca komendy pisa.var.label


# 3. Wykorzystaj komende pisa.select.merge do sciagniecia danych dla Polski i Niemiec
# Interesuja nas zmienne:
#     MISCED       'Mother's Education (ISCED)'                                                                                              
#     TMINS        'Learning time (minutes per week) - in total
#     PA042Q01TA   'What is your annual household income?'                                                                                   


# 4 Sprawdz jakie sa czestosci poszczegolnych poziomów wyksztalcenia matek w Polsce i w Niemczech
#   Uzyj komendy pisa.table 


# 5. Policz srednie wyniki testów z matematyki korzystajac z komendy pisa.mean.pv   


# 6. Wykonaj regresje z wykorzystaniem sciagnietych zmiennych - komenda pisa.reg.pv  


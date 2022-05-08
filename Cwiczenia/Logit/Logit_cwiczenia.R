# Dane:
# https://www.pewresearch.org/journalism/dataset/american-trends-panel-wave-90/

# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Biblioteka dane 
library("foreign")
library("mfx")
library("ROCR")

filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "ATP W90.sav"

# Uwaga: Na zajeciach pracujemy z danymi bez wag. 
# library(devtools)
#install_github("pewresearch/pewmethods", build_vignette = TRUE)
#library(pewmethods)
#?pewmethods
#vignette("pewmethods_weighting")

dane_Media <- read.spss(paste0(filePath, fileName))

# Przeksztalcenie duzej listy z SPSS w ramke danych. 
dane_MediaDF <- dane_Media %>% as.data.frame()
colnames(dane_MediaDF)

# Zadanie 1: 
# W trakcie dzisiejszych zajec analizujemy do kogo trafia przekaza na 
# Twitterze w USA.Sprawdzmy ktor korzysta z portalu do pobierania informacjcji.
# (Zmienna TWITTER_NEWS_W90). Usunmy obserwacje gdzie nie ma odpowiedzi. 
  

# Zadanie 2: 
# Zbudujmy nastepujacy model za pomoca regresji liniowej. Uzyjemy nastepujacych 
# zmiennych: Plec (F_GENDER), wysztalcenie (F_EDUCCAT), 
# poglady polityczne (F_PARTY_FINAL). 
# Bedziemy potrzebowali stworzyc zmienna binarna na podstawie TWITTER_NEWS_W90.
# Wyczyscmy zbiór danych z odmow odpowiedzi. 


  
# Zadanie 3: 
# Spróbujmy utworzyc podobny model logitowy - wykorzystajmy komende GLM.
# Odpowiedzmy na pytania:
#  1. O czym mówia nam parametry modelu? 
#  2. Ile razy czesciej wiadomosci czytaja ludzie z wyksztalceniem college+ 
#     wzgledem niewyksztalconych. 
#  2. Ile razy czesciej wiadomosci czytaja Demokraci niz Republikanie 
  
  
# Zadanie 4:
# Ile razy czesciej Twittera czyta Demokrata z wyksztalceniem Colleague plus 
# niz Republikanin z wyksztalceniem S.Graduate or Less
  

# Zadanie 5:
# Ile wynosi R-2 dla modelu logit? 

  
# Zadanie 6: 
# Jakie jest prawdopodobienstwo, ze Twittera bedzie czytal:
# 1: mezczyna, Republikanin z wyksztalceniem college+ 
# 2: kobieta, Demokratka z wyksztalceniem Some College H.S.
# 3: kobieta, Glos niezalezny, bez wyksztalcenia. 
# Do ilu osób moze dotrzec kampania Twitterowa na potencjalny milion wyborców?

  
# Zadanie 7: 
# Dodajmy do modelu kolejne zmienne: Wiek (), przyjecie szczepionki na Covid-19
#  (COVID_VAXD)
  
  
# Zadanie 8: 
# Ktory z tych modeli lepiej prognozuje uzytkowanie Twittera? 
# Wykonaj krzywa ROC. Skorzystaj z linku: 
# https://stackoverflow.com/questions/14085281/multiple-roc-curves-in-one-plot-rocr

  
# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Wczytanie danych 
filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "FIFA22_official_data.csv"

data <- read.csv(paste0(filePath, fileName))

# *Dzisiaj bedziemy pracowac na zbiorze danych z gry FIFA 2022
# z serwisu Kaggle.com:
# https://www.kaggle.com/datasets/bryanb/fifa-player-stats-database


#### Zadania pod kolokwium.

# Zadanie 1: Czyscimy dane:
# Zmienne dotyczace wartosci (Value) i pensji pilkarza (Wage) zawieraja dziwne
# znaki oraz M/K. Przeksztalcmy je z tekstu na liczbe z wykorzystaniem 
# Tidyverse. Podobne problemy wystepuja ze wzrostem (Height) i waga (Weight). 

  
# Zadanie 2: Przekzsztalc zmienne dotyczace pozycji (Best.Position) 
#  oraz dominujacej nogi(Preferred.Foot) jako factor

  
# Zadanie 3: Stwórz tablice, która pokazuje sredni wzrost i wage w zaleznosci 
#  od pozycji na boisku. 


# Zadanie 4: Stwórz ramke w których filtrujemy srodkowych napastników (CF) 
#  oraz obronców (CB). Rozrysuj Box-plot pokazujacy wartosc takowych. 
# Z uwagi na rozpietosc przeksztalcmy wyniki na logarytmy. 

  
# Zadanie 5: Stworzmy regresje która oceni umiejetnosci pilkarza (overall)
# w zaleznosci od wieku, kwadratu wieku oraz numeru na koszulce. 
# Najpierw wykorzystajmy formule select aby pobrac te dane do opdowiedniej ramki. 
# Jak zinterpretowac parametry przy wieku?
  

# Zadanie 7: Stwórz predykcje z modelu dla Cristiano Ronaldo (wiek 37, numer 7).
# O ile jego rating rózni sie od sredniej? 

  
# Zadanie 8: Wykorzystaj funkcje aggregate, aby policzyc srednie oceny pilkarzy
# na konrketnych pozycjach. Przedstaw je na wykresie z posortowanymi kolumnami. 


# Zadanie 9: Wykorzystaj funkcje aggregate, aby policzyc srednie zarobki pilkarzy
# po wieku. Zrób wykres liniowy. 
  
  
#### Zadania logit / ML

# Zadanie 10: Stwórz model, który objasnia prawdopodobienstwo posiadania 
# unikatowej twarzy w FIFA na podstawie zarobków zawodnika. O ile wzrasta
# iloraz szans z kazdym milionem? 
  
# Zadanie 11: Stwórz wielomianowy logit, który tlumaczy prawdopodobienstwo 
# posiadania numeru w zaleznosci od pozycji (Best.Position), wieku (Age),
# Zarobków. Jaka bedzie predykcja dla takiego modelu dla Roberta Lewandowskiego?
  
  
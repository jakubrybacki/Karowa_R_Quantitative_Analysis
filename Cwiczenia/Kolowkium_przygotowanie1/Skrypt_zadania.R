# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Wczytanie danych 
filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "music_genre.csv"

data <- read.csv(paste0(filePath, fileName))

# *Dzisiaj bedziemy pracowac na zbiorze danych muzycznych z serwisu Kaggle.com:
# https://www.kaggle.com/datasets/vicsuperman/prediction-of-music-genre

#### Zadania pod kolokwium.

# Zadanie 1: Dane zawieraja brakujace wartosici - ustaw je w pliku:
# W kolumnie duration_ms -> -1
# W kolumnie tempo -> -99 
# W kolumnie instrumentalness -> -99.


# Zadanie 2: Przygotuje tabele przestawna, ktora zlicza tonacje (key) dla róznych gatunkow muzyki. 
# Przedstaw dane procentowo W Pierwszej tabeli w wierszach, w drugiej tabeli w kolumnach. 

  
# Zadanie 3: Przeksztalc zmienna duration_ms, tak aby pokazywala liczbe sekund a nie milisekund (podziel przez 1000). 
#  Policz sredni czas dla utworów róznych typów. 

  
# Zadanie 4: Czy Hip-hop i Rap maja srednio podobny czas trwania piosenek - sprawdz za pomoca testu T. 
# Jaka jest hipoteza zerowa testu? Jaka decyzje podejmiemy oraz na jakiej podstawie?.

    
# Zadanie 5: Stwórz ramke, ktora wybierze wylacznie muzyke klasyczna. Sprawdz czy dlugosc piosenek ma 
# rozklad normalny? A moze jej logarytm?.

    
# Zadanie 6 - stworz zmienna bedaca logarytmem dlugosci w minutach, Zrób regresje takiej zmiennej na: 
# Glosnosc (loudness) 
# Logarytm ze zmiennej tempo 
# Jak zinterpretowac parametry modelu?. 


# Zadanie 7 - sprawdz srednie oceny popularnosci po typach muzyki..


# Zadanie 8 - przeprowadz analize ANOVA, gdzie sprawdzimy czy popularnosc rocku, hip-hopu i rapu jest taka sama..
# Jaka jest hipoteza zerowa? Jaka decyzje podejmiemy na podstawie wydruku?.


# Zadanie 9 - stworz regresje, ktora wyjasni popularnosc w zaleznosci od dlugosci piosenki i energicznosc i tempai. 


#### Zadania - uczenie maszynowe:

# Zadanie 10 - Zróbmy ramke opisujaca tylko ilosiowe parametry muzyki: 
# acousticness, danceability, duration_ms, energy, instrumentalness, liveness, liveness, speechiness, tempo
# Przeprowadz analize glównych skladowych. Zrób wydruk w przestrzeni 2D, z przedstawionymi klastrami. 


# Zadanie 11 - Czy wykres dobrze przybliza dane? Stwórz scree-plot.


# Zadanie 12 - Zbuduj dwa drzewa decyzyjne pozwalajace klasyfikowac rodzaj muzyki i tonacje
# w zaleznosic od charakterystyk utworu. 


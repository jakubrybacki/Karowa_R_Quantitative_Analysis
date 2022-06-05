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
  data %<>% filter(duration_ms != -1) %>%
    filter(tempo != -99) %>%
    filter(instrumentalness != -99) 

# Zadanie 2: Przygotuje tabele przestawna, ktora zlicza tonacje (key) dla róznych gatunkow muzyki. 
# Przedstaw dane procentowo W Pierwszej tabeli w wierszach, w drugiej tabeli w kolumnach. 

  require("summarytools")
  help(p  = "summarytools")
  
  colnames(data)
  
  # Pierwsza tabela
  pivot_obiekt <- ctable(x= data$key, y = data$music_genre)
  pivot_obiekt$proportions
  
  # Pierwsza tabela
  pivot_obiekt2 <- ctable(x=  data$music_genre, y =data$key)
  pivot_obiekt2$proportions

# Zadanie 3: Przeksztalc zmienna duration_ms, tak aby pokazywala liczbe sekund a nie milisekund (podziel przez 1000) . 
# i minuty. Policz sredni czas dla utworów róznych typów. 
  data %<>% mutate(duration_s = duration_ms/1000) %>%
    mutate(duration_min = duration_s/60)
  
  wynik <- by(data$duration_min, data$music_genre, mean)
  
# Zadanie 4: Czy Hip-hop i Rap maja srednio podobny czas trwania piosenek - sprawdz za pomoca testu T. 
# Jaka jest hipoteza zerowa testu? Jaka decyzje podejmiemy oraz na jakiej podstawie?.
  data %<>% mutate(music_genre = as.factor(music_genre))
  summary(data$music_genre)

  data_HipHop <- data %>% filter(music_genre == "Hip-Hop")
  data_Rap <- data %>% filter(music_genre == "Rap")
  t.test(data_HipHop$duration_min, data_Rap$duration_min)
  
# Zadanie 5: Stwórz ramke, ktora wybierze wylacznie muzyke klasyczna. Sprawdz czy dlugosc piosenek ma 
# rozklad normalny? A moze jej logarytm?.
  data_Classical <- data %>% filter(music_genre == "Classical")
  
  require("car")
  qqPlot(data_Classical$duration_min)
  
  data_Classical %<>% mutate(Log_duration = log(duration_min))  
  qqPlot(data_Classical$Log_duration)
  
# Zadanie 6 - stworz zmienna bedaca logarytmem dlugosci w minutach, Zrób regresje takiej zmiennej na: 
# Glosnosc (loudness) 
# Logarytm ze zmiennej tempo 
# Jak zinterpretowac parametry modelu?. 
  formula <- log(duration_min) ~ loudness + log(tempo)
  model1 <- lm(formula, data = data)
  summary(model1)
  
  summary(data$loudness)

# Zadanie 7 - sprawdz srednie oceny popularnosci po typach muzyki..
  by(data$popularity, data$music_genre, mean)

# Zadanie 8 - przeprowadz analize ANOVA, gdzie sprawdzimy czy popularnosc rocku, hip-hopu i rapu jest taka sama..
# Jaka jest hipoteza zerowa? Jaka decyzje podejmiemy na podstawie wydruku?.
  gatunki_testowe <- c("Hip-Hop", "Rap", "Rock")
  dataANOVA <- data %>% filter(music_genre %in% gatunki_testowe)
  
  ANOVA_oceny <- aov(popularity ~ music_genre, data = dataANOVA)
  
  summary(ANOVA_oceny)
  # Roznice miedzy srednimi
  TukeyHSD(ANOVA_oceny)
  
# Zadanie 9 - stworz regresje, ktora wyjasni popularnosc w zaleznosci 
# od dlugosci piosenki, energicznosci i tempa. 


#### Zadania - uczenie maszynowe:

# Zadanie 10 - Zróbmy ramke opisujaca tylko ilosiowe parametry muzyki: 
# acousticness, danceability, duration_ms, energy, instrumentalness, liveness, liveness, speechiness, tempo
# Przeprowadz analize glównych skladowych. Zrób wydruk w przestrzeni 2D, z przedstawionymi klastrami. 


# Zadanie 11 - Czy wykres dobrze przybliza dane? Stwórz scree-plot.


# Zadanie 12 - Zbuduj dwa drzewa decyzyjne pozwalajace klasyfikowac rodzaj muzyki i tonacje
# w zaleznosic od charakterystyk utworu. 


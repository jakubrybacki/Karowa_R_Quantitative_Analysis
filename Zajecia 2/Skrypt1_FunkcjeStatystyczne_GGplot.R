install.packages("summarytools")
install.packages("psych")

library("dplyr")
library("tidyr")
library("magrittr")
library("summarytools")
library("psych")

help(p="dplyr")

# Wczytywanie danych 
filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "DaneMecze.csv"

dane <- read.csv(paste0(filePath, fileName))

# Podstawowe statystyki opisowe
  summary(dane)
  
  # Zamiast calego obiektu mozemy wybrac poszczególna kolumne:
  summary(dane$home_score)
  
  # Kilka kolumn najlatwiej wykonac w dplyr
  dane %>% select(home_score, away_score) %>% summary()
  
  # Kazda statystyke mozna uzyskac z funkcji 
  # Zakres
  c(minimum = min(dane$home_score), 
    maksimum = max(dane$home_score))
  
  # srednie
  c(srednia = mean(dane$home_score), 
    mediana = median(dane$home_score))
  
  # kwantyle
  c(percentyl = quantile(dane$home_score, 0.25), 
    percentyl = quantile(dane$home_score, 0.5), 
    percentyl = quantile(dane$home_score, 0.75), 
    percentyl = quantile(dane$home_score, 0.90))
  
  # Rozproszenie 
  c(odchylenie_standardowe = sd(dane$home_score), 
    wariancja = var(dane$home_score))

  # Gotowy widok - paczka summarytools
  descr(dane,
        headings = FALSE, # remove headings
        stats = "common")

# Srednie warunkowe 
  # Pytanie badawcze - czy zawodnicy inaczej graja o stawke i inaczej towarzyszko.
  
  # Stwórzmy zmienna która podpowie czy mecz byl towarzyski
  dane %<>% mutate(isFriendly = ifelse(tournament == "Friendly", 
                                       "Towarzyski",
                                       "Mistrzostwa"))
  
  # Chcemy przedstawic statystyki opisowe warunkowo:
  by(dane$home_score, dane$isFriendly, summary)
  
  # Kilka kolumn ponownie najlatwiej wykonac w dplyr
  dane %>% select(home_score, away_score, isFriendly) %>% 
    by(dane$isFriendly, summary)

  # Gotowy opis - paczka psych
  describeBy(
    dane,
    dane$isFriendly # grouping variable
  )
  
# Czestosci 
  # Pytanie badawcze: Czy w pilce wystepuje efekt gospodarza?
  
  # Na poczatek spróbujmy zmierzyc sie ze stworzeniem Tabeli liczebnosci,
  # która pokaze ile meczy zakonczylo sie zdobyciem x- bramek przez 
  # gospodarzy i gosci.
  
  # Zmniejszymy liczbe wierszy tabeli - pozbadzmy sie duzych wyników 
  dane_filtr <- dane %>% 
    filter(home_score <= 10) %>%
    filter(away_score <= 10)
  
  # Pytanie: ile meczy skonczylo sie zdobyciem x bramek przez gospodarza
  table(dane_filtr$home_score)
  
  # Mozemy to wykorzystac do oblicznia czestosci warunkowych 
  table(dane_filtr$home_score, dane_filtr$isFriendly)
  
  # Paczka summarytools
  freq(dane_filtr$home_score) 
  freq(dane_filtr$away_score) 
  
  # Inne widoki z summarytools
  ctable(
    y = dane_filtr$isFriendly,
    x = dane_filtr$home_score)
  
  dfSummary(dane)

# Wykresy - paczka GGPlot
  
  # Spróbujmy zwizualizowac efekt gospodarza na wykresie 
  # chcemy stowrzyc histogram bramek zdobytych przez gospodarzy i gosci
  
  # Wykresy w R robi sie duzo latwiej w formie dlugiej. Przeksztalcimy te dane 
  dane_wykres <- dane_filtr %>% select(home_score, away_score) %>%
    pivot_longer(everything())
  
  # Tworzymy histogram
  HistGoals <- ggplot(data=dane_wykres, aes(x=value, fill = name)) + 
    geom_histogram(binwidth=1, position="dodge")
  HistGoals
  
  # Modyfikujemy wyglad 
  HistGoals <- HistGoals + theme_classic()
  HistGoals
  
  # zmieniamy osie i dodajemy tytul
  HistGoals <- HistGoals + labs( x = "Ilosc bramek", 
                                 y = "Ilosc meczy",
                                 title = "Histogram - bramki")
  HistGoals
  
  # zmieniamy kolory kolumn: 
  HistGoals <- HistGoals + scale_fill_manual(values=c("#999999", "#E69F00"))
  HistGoals
  
  # Usunmy legende
  HistGoals <- HistGoals + theme(legend.position="none")
  HistGoals
  
  # Zapiszmy go do pliku EPS
  ggsave(file = paste0(filePath, "Wykres.eps"), 
         plot = HistGoals,
         device= "eps",  
         family = "Times")
  
  # Czy serie musza byc obok siebie? Czy musze ogladac liczebnosci?
  HistGoals2 <- ggplot(data=dane_wykres, aes(y=..density.., 
                                             x=value, 
                                             fill = name)) + 
    geom_histogram(binwidth=1, position="Identity")
  HistGoals2
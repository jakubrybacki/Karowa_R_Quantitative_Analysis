install.packages("lubridate")

library("dplyr")
library("tidyr")
library("magrittr")
library("lubridate")

help(p="dplyr")

# Wczytywanie danych 
filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "DaneMecze.csv"

dane <- read.csv(paste0(filePath, fileName))

# Pytanie: czy efekt gospodarza narasta w czasie?

# Przeksztalcanie dat
   # Pierwsza próba
  dane %<>% mutate(rok = year(ï..date))
  
  # Dzialamy dalej 
  dane %<>% mutate(format_daty = ymd(ï..date))
  dane %<>% mutate(format_daty2 = dmy(ï..date))
  
  dane %<>% mutate(rok = ifelse(is.na(format_daty), 
                                year(format_daty2),
                                year(format_daty)))
  
  # Usunmy mecze przed 2010
  dane_filtr <- dane %>% filter(rok >= 2010) %>% 
    filter(home_score <= 10) %>%
    filter(away_score <= 10)
  
# Obliczenia 
  # Policzmy srednie dla kolejnych lat 
  dane_filtr %>% select(home_score, away_score) %>% 
    by(dane_filtr$rok, summary)
  
  # Funckja aggregate
  podsumowanie <- aggregate(dane_filtr$home_score,
                          by = list(dane_filtr$rok), 
                          FUN = mean)
  
  podsumowanieAway  <- aggregate(dane_filtr$away_score,
                                 by = list(dane_filtr$rok), 
                                 FUN = mean)
  # Laczymy ramki
  podsumowanie %<>% left_join(podsumowanieAway, 
                              by = c("Group.1" = "Group.1"))
  colnames(podsumowanie) <- c("rok", "gospodarz", "gosc")
  
  # Policzmy roznice po latach 
  podsumowanie %<>% mutate(roznica = gospodarz - gosc)
  
# Dane:
# http://www.europeansocialsurvey.org/

# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Biblioteka dane 
library("foreign")
library("MASS")
library("nnet")

# Ustawienia formatowania
options(scipen=999)
options(digits=2)

filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "ESS8PL.sav"

dane <- read.spss(paste0(filePath, fileName))

# Przeksztalcenie duzej listy z SPSS w ramke danych. 
dane_DF <- dane %>% as.data.frame()
colnames(dane_DF)

# Dotychczas analizowalismy jedynie zmienne binarne (0 albo 1).
# Na tych zajeciach przyjrzymy sie pytaniom o róznych skalach porównawczych 
# np. od 1 do 10. 

# Bedziemy rozrózniali 2 typy danych - porzadkowe, gdzie kolejne wartosci sa
# lepsza ocena od poprzednich. Do modelowania takich zmiennych posluzy 
# uporzadkowany logit (ang. Ordinal logit). 

# Chcemy sprawdzic ocene sluzby zdrowia (stfhlth), w zaleznosci od:
#   oceny stanu wlasnego zdrowia (health), satysfakcji z zycia (stflife),
#   plci (gndr), wieku / roku urodzenia (yrbrn)

  # Podsumowanie danych
  summary(dane_DF$stfhlth)
  summary(dane_DF$stflife)
  summary(dane_DF$gndr)
  summary(dane_DF$yrbrn)
  
  # Wybór zmiennych 
  daneModel <- dane_DF %>% select(stfhlth, health, stflife, gndr, yrbrn) 
    
  # Filtrujemy braki danych 
  braki_danych <- c("Refusal", "Don't know", "No answer")
  daneModel %<>% filter(!(stfhlth %in% braki_danych)) %>%
    filter(!(health %in% braki_danych)) %>%
    filter(!(stflife %in% braki_danych)) %>%
    filter(!(gndr %in% braki_danych)) %>%
    filter(!(yrbrn %in% braki_danych)) 
    
  # Przeksztalcenia
  daneModel %<>% mutate(ocena_zadowolenie = as.numeric(stflife)) %>%
    mutate(yrbrn = as.numeric(yrbrn)) 
  
  daneModel$stfhlth %<>% droplevels()
  
  # Prosty model same zmienne ilosciowe:
  formula <- stfhlth ~ ocena_zadowolenie + yrbrn
  model <- polr(formula, data = daneModel, Hess = TRUE)
  summary(model)
  
  # Dodajemy factor
  formula <- stfhlth ~ ocena_zadowolenie + health + yrbrn + gndr
  model <- polr(formula, data = daneModel, Hess = TRUE)
  summary(model)
  
  # Problemy z paczka - nie mamy p-value, mozliwe jest jego przyblizenie: 
  ctable <- coef(summary(model))
  p <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2 
  p <- round (p, digits = 2)
  ctable <- cbind(ctable, "p value" = p)
  ctable
  
  # Odds - ratio - wyliczane manualnie
  exp(coef(model))
  
# Mozemy jednak miec dwie sytuacje w których zalozenia tego modelu nie sa 
# spelnione - np. wyniki nie sa uporzadkowane badz wplyw zmiennej bedzie 
# rózny mieDzy poziomami. W takim przypadku uzywamy wielomianowy logit 
# (multinominal logit)
  
# Wyjasniajmy taka zmienna: prtclgpl- partia na która planujemy oddac glos.
# uzyjmy zmiennych prtvtdpl - wynik glosowania w poprzednich wyborach. 
# lrscale - deklaracja poglady lewicowe / prawicowe
  
  # podglad
  summary(dane_DF$prtclgpl)
  summary(dane_DF$yrbrn)
  summary(dane_DF$lrscale)
  
  # Wybor zmiennych
  daneModel <- dane_DF %>% select(prtclgpl, yrbrn, lrscale) %>%
    mutate(lrscale = as.numeric(lrscale)) %>%
    mutate(yrbrn = as.numeric(yrbrn))
  
  # Filtrujemy braki danych 
  braki_danych <- c("Refusal", "Don't know", "No answer", 
                    "Other", "Not applicable")
  daneModel %<>% filter(!(prtclgpl %in% braki_danych)) %>%
    filter(!(yrbrn %in% braki_danych)) %>%
    filter(!(lrscale %in% braki_danych))
  
  # Usuwamy niepotrzebne poziomy
  daneModel$prtclgpl %<>% droplevels()

  # Szacujemy model
  daneModel$prtclgpl <- relevel(daneModel$prtclgpl,
                                ref = "Prawo i Sprawiedliwosc")
  
  formula <- prtclgpl ~ yrbrn + lrscale
  model <- multinom(formula, data = daneModel)
  summary(model)
  
  
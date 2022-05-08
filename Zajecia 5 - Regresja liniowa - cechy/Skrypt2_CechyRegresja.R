# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

#install.packages("lmtest")
library("sandwich")
library("lmtest")
library("forecast")

# Link do danych: 
#   https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

# Wczytywanie danych
  filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
  fileName <- "WA_Fn-UseC_-HR-Employee-Attrition.csv"
  
  dataHR <- read.csv(paste0(filePath, fileName))

# Przeksztalcenia danych 
  colnames(dataHR)
  
  dataHR %<>% mutate(Department = factor(Department)) %>%
    mutate(EducationField = factor(EducationField)) %>% 
    mutate(JobRole = factor(JobRole)) %>% 
    mutate(BusinessTravel = factor(BusinessTravel)) %>% 
    mutate(Gender = factor(Gender)) %>% 
    mutate(MaritalStatus = factor(MaritalStatus)) %>% 
    mutate(OverTime = factor(OverTime)) 
  
# Podstawowy model - czy zarobki zaleza od stanowiska pracy
  levels(dataHR$JobRole)
  formula <- MonthlyIncome ~ JobRole
  model1 <- lm(formula, data = dataHR)
  summary(model1)

# Hackujemy r kwadrat. 
  # Dodawanie bezsensownych zmiennych do modelu powieksza statystyke R-kwadrat. 
  # Dlatego liczona jest druga statystyka tzw. skorygowany R-kwadrat. 
  dataHR %<>% mutate(WLB2 = WorkLifeBalance ^ 2 ) %>% 
    mutate(WLB3 = WorkLifeBalance ^ 3 ) %>%
    mutate(RLS2 = RelationshipSatisfaction ^ 2) %>%
    mutate(RLS3 = RelationshipSatisfaction ^ 3) %>%

  formula <- MonthlyIncome ~ JobRole + WorkLifeBalance + RelationshipSatisfaction
  model1 <- lm(formula, data = dataHR)
  summary(model1)
  
  formula <- MonthlyIncome ~ JobRole + WorkLifeBalance + RelationshipSatisfaction + WLB2 + WLB3
  model1 <- lm(formula, data = dataHR)
  summary(model1)

  formula <- MonthlyIncome ~ JobRole + WorkLifeBalance + RelationshipSatisfaction +
    WLB2 + WLB3 +  RLS2 + RLS3
  model1 <- lm(formula, data = dataHR)
  summary(model1)
  
# Homoskedastycznosc. 
  # Modele regresji liniowej zakladaja, ze bledy maja stale odchylenie standrdowe. 
  # To nie zawszej jest spelnione - sprawdzmy jakie sa tego konsekwencje. 
  residual <- resid(model1)
  plot(dataHR$MonthlyIncome, residual)
  
  # Estymujemy macierz Neweya-Westa i korygujemy odchylenie standardowe. 
  NW_VCOV <- NeweyWest(model1)
  coeftest(model1, vcov = NW_VCOV)
  
  # Porownajmy wspolczynniki obydwu modeli 
  
# Skalowanie parametrow 
  # Dolozmy do modelu kolejna zmienna - liczbe lat od ostatniego awansu. 
  formula <- MonthlyIncome ~ JobRole + YearsSinceLastPromotion
  model1 <- lm(formula, data = dataHR)
  summary(model1)
  
  # Przeksztalcamy te zmienna na liczbe miesiecy
  dataHR %<>% mutate(MonthsSinceLastPromotion = YearsSinceLastPromotion * 12) 
  
  # jak zmienia sie parametry modelu?
  formula <- MonthlyIncome ~ JobRole + MonthsSinceLastPromotion
  model1 <- lm(formula, data = dataHR)
  summary(model1)
  
# Interakcje miedzy zmiennymi 
  # Sprawdzmy czy firma IBM dyskriminuje kobiety?
  formula <- MonthlyIncome ~ JobRole + MonthsSinceLastPromotion + Gender
  model1 <- lm(formula, data = dataHR)
  summary(model1)
  
  # To polaczmy plec i stanowisko
  formula <- MonthlyIncome ~ JobRole + JobRole*Gender + MonthsSinceLastPromotion 
  model1 <- lm(formula, data = dataHR)
  summary(model1)
  
  # W badaniach o roznicach placowych zawszse warto sprawdzac tez nadgodziny i podroze sluzbowe
  formula <- MonthlyIncome ~ JobRole + JobRole*Gender + MonthsSinceLastPromotion + BusinessTravel + OverTime
  model1 <- lm(formula, data = dataHR)
  summary(model1)
  
# Regresja pozorna
  # Wygenerujemy 100 losowych liczb od 0 do 1. 
  sztuczneDane <- runif(100) %>% as.data.frame() 
  colnames(sztuczneDane) <- c("x")
  
  # stworzmy szereg, ktory wartoscia tych liczb podniesionych do kwadratu
  sztuczneDane %<>% mutate(y = x^2)

  # Robimy modle ktory wyjasnia y przez x
  formula <- y ~ x
  model1 <- lm(formula, data = sztuczneDane)
  summary(model1)
  
  # Sprawdzmy wykres bledow.
  residual <- resid(model1)
  plot(sztuczneDane$x, residual)

# Mniej (zmiennych) znaczy wiecej (efektow) 
  # wygenerujmy osbie 3 serie z rozkladu jednostajnego i jedno z normalnego
  # zlaczmy je w jedna ramke danych 
  sztuczneDane <- data.frame(replicate(5,sample(0:1,200,rep=TRUE)))
  modelResid <- rnorm(200)
  sztuczneDane$skladnik_losowy <- modelResid
  
  # Stworzmy takie rownanie w ktorym realne znaczenie ma tylko zmienna x1 
  sztuczneDane %<>% mutate(y = 95*X1 + 0.001*X2 + 0.003*X3 + 0.005*X4 + 0.0001*X5 + skladnik_losowy)

  # Przygotujemy model na probie uczacej. Skutecznosc bedziemy weryfikowac na probie uczacej
  dane_uczace <- sztuczneDane[1:100,]
  dane_testowe <- sztuczneDane[101:200,] 
  
  # Model 1: Tylko zmienna X1
  formula <- y ~ X1
  model1 <- lm(formula, data = dane_uczace)
  summary(model1)

  # Model 2: Wszystkie zmienne faktycznie generujace proces. 
  formula2 <- y ~ X1 + X2 + X3 + X4 + X5
  model2 <- lm(formula2, data = dane_uczace)
  summary(model2)
  
  # Prognozujemy za pomoca modeli 
  prognozy_prosty <- forecast(model1, newdata =  dane_testowe)
  prognozy_pelny <- forecast(model2, newdata = dane_testowe)
  
  # Liczymy o ile sie pomylilismy
  bledy_prosty <- prognozy_prosty$mean - dane_testowe$y
  bledy_pelny <- prognozy_pelny$mean - dane_testowe$y
  
  # sredni blad kwadratowy
  bledyKw_prosty <- bledy_prosty^2 
  bledyKw_pelny <- bledy_pelny^2 
  
  # Ktory model ma wieksze bledy.
  mean(bledyKw_prosty)
  mean(bledyKw_pelny)
  
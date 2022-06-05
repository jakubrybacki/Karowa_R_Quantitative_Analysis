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
  ?gsub
  data %<>% mutate(value_nume = gsub("â‚¬", '', Value)) %>%
    mutate(value_nume = gsub("M", '', value_nume)) %>%
    mutate(value_nume = as.numeric(value_nume))

  data %<>% mutate(Height_numer = gsub("cm", '', Height)) %>%
    mutate(Height_numer = as.numeric(Height_numer))

  data %<>% mutate(Weight_numer = gsub("kg", '', Weight)) %>%
    mutate(Weight_numer = as.numeric(Weight_numer))
  
# Zadanie 2: Przekzsztalc zmienne dotyczace pozycji (Best.Position) 
#  oraz dominujacej nogi(Preferred.Foot) jako factor
  data %<>% mutate(Best.Position = as.factor(Best.Position)) %>%
    mutate(Preferred.Foot = as.factor(Preferred.Foot)) 
    
# Zadanie 3: Stw???rz tablice, kt???ra pokazuje sredni wzrost i wage w zaleznosci 
#  od pozycji na boisku. 
  require("summarytools")
  pivot_obiekt2 <- ctable(x=  data$Height_numer, y = data$Best.Position)

  srednie <- by(data$Height_numer, data$Best.Position, mean)
  srednie
  
  srednie_waga <- by(data$Weight_numer, data$Best.Position, mean)
  srednie_waga
  
# Zadanie 4: Stw???rz ramke w kt???rych filtrujemy srodkowych napastnik???w (CF) 
#  oraz obronc???w (CB). Rozrysuj Box-plot pokazujacy wartosc takowych. 
# Z uwagi na rozpietosc przeksztalcmy wyniki na logarytmy. 
  summary(data$Best.Position)
  data_CF <- data %>% filter(Best.Position == "ST")
  data_CB <- data %>% filter(Best.Position == "CB")
  
  boxplot(log(data_CF$value_nume), log(data_CB$value_nume), 
          names = c("Napastnik", "Obroñca"),
          main = "Porównanie rozkladów wartoœci pi³karzy")
  
# Zadanie 5: Stworzmy regresje kt???ra oceni umiejetnosci pilkarza (overall)
# w zaleznosci od wieku, kwadratu wieku oraz numeru na koszulce. 
# Najpierw wykorzystajmy formule select aby pobrac te dane do opdowiedniej ramki. 
# Jak zinterpretowac parametry przy wieku?
  data_reg <- data %>% select(Overall, Age, Jersey.Number) %>%
    mutate(Age_sq = Age^2)

  formula <- Overall ~ Age + Age_sq + Jersey.Number
  model <- lm(formula, data = data_reg)
  summary(model)
  
# Zadanie 7: Stw???rz predykcje z modelu dla Cristiano Ronaldo (wiek 37, numer 7).
# O ile jego rating r???zni sie od sredniej? 
  frame <- data.frame(Age = 37 , Age_sq = 37^2, Jersey.Number = 7)
  
  library("forecast")
  forecast(model, newdata = frame)
  
  CR7 <- data %>% filter (Name == "Cristiano Ronaldo")
  CR7$Overall
  
# Zadanie 8: Wykorzystaj funkcje aggregate, aby policzyc srednie oceny pilkarzy
# na konrketnych pozycjach. Przedstaw je na wykresie z posortowanymi kolumnami. 
  ?aggregate
  
  srednie_umiejetnosci <- aggregate(x = data$Overall,
                                    by = list(data$Best.Position), 
                                    FUN = mean)
  srednie_umiejetnosci
  colnames(srednie_umiejetnosci) <- c("Pozycja", "Srednia_Overall")
  
  require("ggplot2")
  plotAD <-ggplot(data=srednie_umiejetnosci, 
                  aes(x= reorder(Pozycja, -Srednia_Overall), 
                      y= Srednia_Overall)) +
    geom_bar(stat="identity", position = "dodge")  
  plotAD
  
# Zadanie 9: Wykorzystaj funkcje aggregate, aby policzyc srednie wartoœæ pilkarzy
# po wieku. Zr???b wykres liniowy. 
  
  data_aggregate <- data %>% filter(value_nume > 0)
  srednia_placa <- aggregate(x = data_aggregate$value_nume,
                                    by = list(data_aggregate$Age), 
                                    FUN = mean)
  srednia_placa
  colnames(srednia_placa) <- c("Wiek", "Pieniadze")
  
  
  plotAD <-ggplot(data=srednia_placa, 
                  aes(x= Wiek, 
                      y= Pieniadze)) +
    geom_line(stat="identity", position = "dodge")  
  plotAD

#### Zadania logit / ML

# Zadanie 10: Stw???rz model, kt???ry objasnia prawdopodobienstwo posiadania 
# unikatowej twarzy w FIFA na podstawie zarobk???w zawodnika. O ile wzrasta
# iloraz szans z kazdym milionem? 

# Zadanie 11: Stw???rz wielomianowy logit, kt???ry tlumaczy prawdopodobienstwo 
# posiadania numeru w zaleznosci od pozycji (Best.Position), wieku (Age),
# Zarobk???w. Jaka bedzie predykcja dla takiego modelu dla Roberta Lewandowskiego?


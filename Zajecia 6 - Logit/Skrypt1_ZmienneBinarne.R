# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Biblioteki logit
# install.packages("mfx")
# install.packages("ROCR")
library("mfx")
library("ROCR")

# Link do danych: 
#   https://web.stanford.edu/class/archive/cs/cs109/cs109.1166/problem12.html

filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "titanic.csv"

data <- read.csv(paste0(filePath, fileName))

# Drobne przeksztalcenia danych: 
data %<>% mutate(Pclass = factor(Pclass)) %>%
  mutate(Age_DM = Age - mean(Age))

# Zmienne binarne - Liniowy model prawdopodobienstwa 
  # Chcemy oszacowac prawdopodobienstwo przezycia na Titanicu w zaleznosci od plci (Sex),
  #   klasy biletu (Pclass) i wieku (Age). Spróbujmy najpierw wykonac regresje liniowa
  formula <- Survived ~ Sex + Age_DM + Pclass
  model <- lm(formula, data = data)
  summary(model)
  
  # Wygenerujemy prognozy takie modelu - wartosci chcemy interpretowac jako procentowe 
  #   szanse na przezycie. Efekty beda ciekawe - zwrócmy uwage na najwieksze i
  #   najmniejsze wartosci. 
  predLM <- predict(model, newdata = data) %>% 
    as.data.frame()
  
  # Model wygenerowal wartosci zarówno wieksze niz 1 oraz mniejsze niz 0. Tego nie chcemy. 
  # Aby pozbyc sie tego problemu powstala regresja logistyczna - model logit.

# Zmienne binarne - Logit 
  # W takiej regresji modelujemy dystrybuante rozkladu logistycznego: 
  #   https://pl.wikipedia.org/wiki/Rozk%C5%82ad_logistyczny
  modelLogit <- glm(formula, data = data, family ="binomial")
  summary(modelLogit)
  
  # Sprawdzmy predykcje takiego modelu - dostajemy wartosci od -4 do 4. O co chodzi? 
  predLogit <- predict(modelLogit, newdata = data) %>% 
    as.data.frame()
  
  # W pierwszej próbie analizowalismy zmienna ukryta, która wplywala na dystrybuante. 
  # Aby uzyskac prawdopodbienstwo do komendy dodajemy dodatkowy argument response 
  predLogit <- predict(modelLogit, newdata = data, type = "response") %>% 
    as.data.frame()
  predLogit$predLM <- predLM
  
  # Interpretacja parametrów:
  # + - rosnie prawdopodobienstwo przezycia. 
  # - - spada prawdopodobienstwo przezycia. 
  summary(modelLogit)
  
# Logit - ilorazy szans (odds ratio)
  help(p="mfx")
  logitor(formula, data)  

  # O co chodzi: Chcemy odpowiedziec ile razy wiecej szans na przezycie ma kobieta niz mezsczyzna 
  # Najpierw oszacowujemy empiryczne prawdopodobienstwo przezycia w podziale na plec: 
  tabela <- by(data$Survived, data$Sex, mean)
  summary(tabela)
  
  # Nastepnie liczymy szanse ze przezyjesz bedac kobieta / mezczyzna
  # Wzor: prawdopodobienstwo / (1 - prawdopodobienstwo)
  szanse_kobieta = tabela[1] / (1 - tabela[1])
  szanse_mezczyzna = tabela[2] / (1 - tabela[2])
  
  # Liczymy iloraz szans:
  szanse_mezczyzna / szanse_kobieta
  
  # W regresji logitowej szanse mozna opisac jako exp(parmetry)
  szanse_kobieta_logit_1stClass = exp(modelLogit$coefficients[1])
  szanse_mezczyzna_logit_1stClass = exp(modelLogit$coefficients[1] + modelLogit$coefficients[2])
  szanse_mezczyzna_logit_1stClass / szanse_kobieta_logit_1stClass 

# Logit -  efekty krancowe (ang. marginal effects)
  # Aby poznac ilosciowy wplyw parametru na zmienna bedziemy potrzebowali policzyc tzw.
  # efekty krancowe
  logitmfx(formula, data)
  
  # Liczenie roznic prawdopodobienstw: 
  pred1 <- predict(modelLogit, newdata = data.frame(Sex=factor("female"),
                                                    Age_DM = mean(data$Age_DM),
                                                    Pclass = factor(2)),
                   type = "response")
  
  pred2 <- predict(modelLogit, newdata = data.frame(Sex=factor("male"),
                                                    Age_DM = mean(data$Age_DM),
                                                    Pclass = factor(2)),
                   type = "response")
  pred2 - pred1
  
# Oszacowania - diagnostyka
  #Interesuje nas celnosc modelu w 2 przypadkach 
  # Sensitivity - Ilosc prawdziwie rozpoznanych zgonow
  # Specificity - Liczba prawdziwie rozpoznanych osob, ktore przezylu
  #Obrazuje to tzw. confusion matrix
  predLogit <- predict(modelLogit, newdata = data, type = "response")
  table(data$Survived, predLogit > 0.5)

  # Pewien obraz daje Tzw. krzywa ROC  
  ROCRpred <- prediction(predLogit, data$Survived)
  ROCRperf <- performance(ROCRpred, 'tpr','fpr')
  plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7))
  

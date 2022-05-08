s# W trakcie zajec pracowac bedziemy z zestawem danych dotyczacym degustacji wina:
#   https://archive.ics.uci.edu/ml/datasets/wine+quality

install.packages("ggpubr")
install.packages("tseries")

# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

library("car") 
library("tseries")
library("ggpubr")

# Wczytywanie danych
  filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
  fileName <- "winequality-red.csv"
  fileName2 <- "winequality-white.csv"
  
  wina_czerwone <- read.csv2(paste0(filePath, fileName))
  wina_biale <- read.csv2(paste0(filePath, fileName2))

# Konwersja - dane tekstowe do numerycznych
  wina_biale$alcohol %<>% as.numeric()
  wina_czerwone$alcohol %<>% as.numeric()
  
# Testowanie hipotez statystycznych - metoda r
  # Pytanie - które wina sa mocniejsze biale czy czerwone?
  t.test(wina_biale$alcohol, wina_czerwone$alcohol)
  t.test(wina_biale$alcohol, wina_czerwone$alcohol, alternative = "greater")
  t.test(wina_biale$alcohol, wina_czerwone$alcohol, alternative = "less")
  
  # Wyniki mozna zapisac do obiektu
  wyniki_testu <- t.test(wina_biale$alcohol, wina_czerwone$alcohol)

  # I operowac na skladowych 
  wyniki_testu$null.value
  wyniki_testu$statistic
  wyniki_testu$p.value
  
  # Przydatny wykres 
  boxplot(wina_biale$alcohol, wina_czerwone$alcohol, 
          names = c("Czerwone", "Biale"),
          main = "Porównanie rozkladów win")

  # Pytanie 2: Znajduje butelke z napisem 11% i biala ciecza - czy to wino?
  # Formalnie sprawdzamy czy to mozliwe ze srednia rozkladu wynosi 11
  t.test(wina_biale$alcohol, mu = 11, alternative = "greater")
  t.test(wina_biale$alcohol, mu = 11, alternative = "less")
  
# Testowanie hipotez - jak to dziala - przyklad 2
  
  # Na wstepie zobaczmy dzialanie kilku funkcji: 
  # Wartosci krytyczne dla rozkladów - mozna sprawdzic funkcja Q+nazwa rozkladu
  qnorm(0.05,lower.tail = TRUE) 
  qt(0.05, df = 9, lower.tail = TRUE)
  qchisq(0.05, df = 5, lower.tail = TRUE) 
  qf(0.05, df1 =9, df2 = 2, lower.tail = TRUE) 
  
  # podobnie wartosci p-value
  pnorm(-1.644854,lower.tail = TRUE) 
  pt(-1.833113, df = 9, lower.tail = TRUE)
  pchisq(1.145476, df = 5, lower.tail = TRUE) 
  pf(0.2349351, df1 =9, df2 = 2, lower.tail = TRUE) 
  
  # Teraz zajmijmy sie matematyka 
  # Liczymy statystyke testowa 
  testowana_wartosc <- 12
  statystyka_testowa <- (mean(wina_biale$alcohol) - testowana_wartosc) / 
                      (sd(wina_biale$alcohol) / sqrt(length(wina_biale$alcohol)))
  
  # Wybierzmy funkcje pt 
  stopanie_swobody = length(wina_biale$alcohol) - 1
  pt(statystyka_testowa, df = stopanie_swobody, lower.tail = TRUE)
  pt(statystyka_testowa, df = stopanie_swobody, lower.tail = FALSE)
 
# Statystyka T wymaga, zeby rozklad byl normalny - sprawdzimy to  
  # Wykres podstawowy
  ggplot(wina_biale, aes(alcohol)) + geom_histogram(aes(y = ..density..), fill = "red", colour = "black", binwidth = 1) + 
    labs(x = "Zawartosc alkoholu", y = "Czestosc") + theme_classic() +
    stat_function(fun=dnorm, args=list(mean = mean(wina_biale$alcohol, na.rm = TRUE), 
                                       sd = sd(wina_biale$alcohol, na.rm = TRUE)), 
                  colour = "black", size=1)
  
  # Testowanie czy rozklad jest normalny - QQ-plot
  # Wykres który obrazuje zgodnosc kolejnych percentyli z wartosciami rozkladu normalnego:
  qqnorm(wina_biale$alcohol)

  # Dodaje linie na wykresie - odpowiadajaca rozkladowi normalnemu
  qqline(wina_biale$alcohol)

  # Paczka Car - gotowe ujecie + podzial na grupy
  qqPlot(wina_biale$alcohol)
  
  wina_biale %<>% mutate(typ_Wina = case_when(alcohol < 9.5 ~ "Slabe",
                                             alcohol < 13  ~ "Standard",
                                             TRUE ~ "Mocne"))
  
  qqPlot(wina_biale$alcohol, groups = wina_biale$typ_Wina)
  
  # Na pracy MGR czasami cos trzeba wpisac do tabelki - sprawdzimy 3 testy: 
  shapiro.test(wina_biale$alcohol)
  ks.test(wina_biale$alcohol, 'pnorm')
  jarque.bera.test(wina_biale$alcohol) # paczka tseries
  
# Testy nieparametryczne - nie generuja zadnych zalozen. 
  wilcox.test(wina_biale$alcohol, wina_czerwone$alcohol) 
  
# ANOVA - chcemy sprawdzic czy srednie w kilky grupach sa sobie równe
  
  # Wykres Box plot - rózne grupy
  ggboxplot(wina_biale, x = "typ_Wina", y = "quality", 
            color = "typ_Wina", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
            order = c("Slabe", "Standard", "Mocne"),
            ylab = "Ocena", xlab = "Zawartosc alkoholu")
  
  # Pytanie: które alkohole sa lepiej oceniane - mocne, slabe, standardowe 
  ANOVA_oceny <- aov(quality ~ typ_Wina, data = wina_biale)
  
  summary(ANOVA_oceny)
  
  # Roznice miedzy srednimi
  TukeyHSD(ANOVA_oceny)

# ANOVA zalozenie - stala wariancja w grupach
  # Jezeli rozklad jest normalny:
  bartlett.test(quality ~ typ_Wina, data = wina_biale)
  
  # Ogólnie:
  leveneTest(wina_biale$quality, wina_biale$typ_Wina)
  
# Nieparametryczny odpowiednik ANOVA  
   kruskal.test(quality ~ typ_Wina, data = wina_biale)

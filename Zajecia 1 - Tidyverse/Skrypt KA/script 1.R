#--------------------------------------------------------------------
# Analiza danych ilosciowych z wykorzystaniem R
# zajecia 1
#------------------------------------------------------------------

# Instalacje bibliotek - najlepiej robic zawsze na gorze kodu. 
# Kazdy uzytkownik wie jakich pakietow bedzie potrzebowac
install.packages("tidyverse")
install.packages("writexl")
install.packages("readxl")

# Zaladowanie bilbiotek
library(readxl)
library(tidyverse)
library(writexl)

# Najpotezniejsza komenda r
help(p = "readr")

# Instalacja warunkowa
?installed.packages

if (!("tidyverse" %in% installed.packages()[, 1])) {
  install.packages("tidyverse")
}

# Podstawowe przypisania
  a <- 1
  a
  
  # Zla praktyka - dziala kontekstowo. 
  b = 1
  b
  
  # Za takie przypisanie programisci serdecznie podziekuja ci na rozmowie
  "x" -> b
  b

# Struktury danych  -------------------------------------------------------

# Wektory
  stronyNazwy <- c("StronaA", "StronaB", "StronaC", "stronaD" )
  stronyLinkiZew <- c(3, 10, 15, 7)

#tworzenie i dodawanie zmiennych do ramki danych:
  strony <- data.frame(Nazwa = stronyNazwy, LinkiZ = stronyLinkiZew)
  strony
  
  # Ramka danych umozliwia imienne odwolywanie sie do konkretnych serii.
  strony$Nazwa 
  
  # Oraz ich elementów 
  strony$Nazwa[1]

  # Obiekt jest stosunkowo prosto rozszerzalny, ale nie bedzie dodawal typów zlozonych
  strony$Jednyka <- 1
  strony$Struktura[1] <- c(1,2)
  
# Lista
  stronyL <- list(stronyNazwy, stronyLinkiZew)
  stronyL
  
  # lista moze zawierac w sobie typy zlozone
  temp <- list("Adam","Glapinski", c("Prezes NBP", 2022))

# Macierz
  stronyM <- cbind(stronyNazwy, stronyLinkiZew)
  stronyM
  
  # Test - jak wyjdzie dodanie takiego elementu:
  nowy <- c(1, stronyM)

# Tibble
  stronyT <- as_tibble(strony)
  stronyT
  
  stronyT <- tibble(stronyNazwy, stronyLinkiZew)
  stronyT
  
  #informacja o roznicach miedzy tibble a data.frame
  #https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html
  
# Rodzaje zmiennych -------------------------------------------------------

#int (liczba linkow prowadzacych na zewnatrz)
  stronyT <- tibble(stronyNazwy, as.integer(stronyLinkiZew))
  stronyT
  
  names(stronyT)
  names(stronyT) <- c("Nazwa", "LinkiZ")

  # Deklarowanie int:
  tablica_int <- c(8L, 6L, 4L)
  typeof(tablica_int)

#dbl (sredni czas trwania wizyty)
  stronyT$Wizyta <- c(2.5, 3.5, 1.1, 5.7)
  stronyT

#date (data utworzenia)
  stronyT$Data <- as.Date(c("2018-04-05", "2015-01-04","2020-11-30", "2022-01-15"))

#factors
  Temat <- c(1,2,1,1)
  Temat <- factor(Temat, levels = c(1,2), labels = c("medycyna", "uroda"))
  stronyT$Temat <-Temat

  stronyT$Ocena <- factor(c(1,2,2,3), ordered = TRUE, levels = (1:3), labels = c("niska", "Å›rednia", "wysoka"))

#logiczne (czy ma wersje dostepna dla slabo widzacych)
  stronyT$Dostepna <- c(FALSE, FALSE, FALSE, TRUE)

  stronyT
#more types here: https://tibble.tidyverse.org/articles/types.html
  
#braki danych (liczba linkow wewnetrznych)
  stronyT$LinkiW <- as.integer(c(4, NA, 10, 3))
  
# Podstawowe operacje -------------------------------------------------------

#wyciaganie elementow ramki (pakiet - base)

  View(stronyT)
  
  stronyT
  stronyT[,]
  stronyT[1,]
  stronyT[,1]
  stronyT[1,1]
  stronyT[,c(1,3)]
  stronyT[,2:4]

  # Uwaga - programisci nigdy nie zostawiaja w kodzie cyfr. 
  # To zawsze wywoluje bol glowy przy rotacjach w pracy - lepiej uzywac nazw kolumn
  colnames(stronyT)
  stronyT[,c("Nazwa","Dostepna")]
  
#tworzenie nowych zmiennych - pakiet base 
  stronyT$Linki <- stronyT$LinkiW + stronyT$LinkiZ
  stronyT$Czas <- Sys.Date()-stronyT$Data

# inne operatory: https://www.datamentor.io/r-programming/operator/

# Praca z plikami -------------------------------------------------------

# zachowywanie danych
  
  save(stronyT, file = "strony.RData")
  
  write_xlsx(stronyT, "strony.xlsx")

# zapis do CSV - czesc pakietu readr
  write.csv2(stronyT, "strony.csv")
  write.csv2(stronyT, "strony.csv",
             row.names = FALSE, na = "", fileEncoding = "UTF-8")
  
# oproznienie pamieci
  ls()
  rm(strony)
  rm(list = ls())

# import danych

  # Wazny hack - wygeneruje nazwe sciezki gdzie jest skrypt i ustawi ja jako obecna
  filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/")
  setwd(filePath)
  
  load("strony.RData")
  pisa <- read_excel("PISA-2009-pogimnazjalne.xlsx")
  
  pisa <- read_excel("C:/Users/ .....")
  pisa <- read_excel(file.choose())

# zapis do CSV - czesc pakietu readr
  pisazcsv <- read.csv2("PISA-dane.csv")
  rm(pisazcsv)

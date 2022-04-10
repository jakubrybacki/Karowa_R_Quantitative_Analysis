# Biblioteki Tidyverse
library("dplyr")
library("tidyr")
library("magrittr")

# Usuniemy notacje naukowa
options(scipen=999)
options(digits=2)

# Link do danych: 
#   https://www.kaggle.com/datasets/camnugent/california-housing-prices

filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/")
fileName <- "housing.csv"

dataHousing <- read.csv(paste0(filePath, fileName))

### Zadanie 1 ###
# Stwótrz model, ktory pokaze o ile procent zmieni sie wartosc nieruchomosci, w ktorej mieszkali 
# Kalifornijczycy w momencie gdy dochod zmieni sie o 1%


## Zadanie 2 ### 
# Doloz do modelu informacje czy mieszkanie znajduja sie blisko wybrzeza. O ile procent rosnie cena?

  
## Zadanie 3 ## 
# Wyswietlmy reszty naszego modelu - czy rozrzut wielkosci bledu jest zalezne od dochodu? 

  
## Zadanie 4 ## 
# Powtórzmy estymacje naszego modelu dla osob wylacznie o dochodach ponizej 8 tys.USD 


## Zadanie 5 ### 
# Sprawdzmy na ile nasze wnioski pokrywaja sie z prostymi tabelami krzyzowymi - chcemy znalezc:
#   srednia cene dla mieszkan roznych typow. 

  
# Zadanie 6 ###
# Zarowno model statystyczny oraz tabele krzyzowe pokazuja ze ceny mieszkan w zatoce i przy oceanie sa podobne
# Wykonajmy box plot i formalny test t


# Zadanie 7 ##
# Stworzmy troche prostszy model - na poziomach zmiennych. Zobaczmy jak na cene mieszkan wplywaja 
# wspolrzedne geograficzne i wiek mieszkania


# Zadanie 8 ##
# Zobaczmy rozrzut bledow dopasowan w zaleznosic od wspolrzednych geograficznych 

  
# Zadanie 9 ## 
# Sprawdzmy czy tak samo beda zachowywac sie wyniki dla osób o najnizszych dochodach
# Badamy dochody ponizej 2 tys. 


# Zadanie 10 ##
# Zobaczmy, ze miedzy dwoma wydrukami mocno zmienila sie wartosc dla wspolrzednych geograficznych
# Dodajmy zmienne opisujace bliskosc oceanu


# Zadanie 11 ## 
# Wydruki modelu opartego o wartosci absolutne sa malo czytelne - moze wrocmy do formy na logarytmie zmiennej


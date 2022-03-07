# W zadaniu stworzymy wykres liniowy pokazujacy stope odpodatkowania pracy
# singla zarabiajacego x-krotnosc sredniego wynagrodzenia w Polsce i strefie euro

# Te paczki oraz zaptyanie przygotuja zbiór danych - uruchom je: 
library("ggplot2")
library("eurostat")
library("dplyr")
library("magrittr")

NazwyKolumn <- c("P1_NCH_AW50", "P1_NCH_AW67", "P1_NCH_AW80", "P1_NCH_AW100",
              "P1_NCH_AW125", "P1_NCH_AW167")

dane  <- get_eurostat("earn_nt_taxrate",
                                filters = list(geo = c("PL", "EA19"),
                                               ecase = NazwyKolumn,
                                               lastTimePeriod  = 1))

# 1. Uzyj pipes i funkcji mutate, aby usunac przedrostki nazw "P1_NCH_AW"
# Z kolumny ecase. Zmien typ tych danych z tekstowego na numeryczny.


# 2. Stórz podstawowy wykres liniowy: 


# 3. Dodaj punkty dla kolejnych danych oraz zaaplikuj styl klasyczny


# 4. Dodaj tytuly osi i tytul wykresu


# 5. Zmien kolory wykresu na czerwony i szary 


# 6. Zmien kolory wykresu na czerwony i szary 



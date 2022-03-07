# W zadaniu stworzymy wykres kolumnowy obrazujacy zadluzenie panstw UE w relacji 
# do PKB

# Ta paczka oraz kolejne zapytanie przygotuja zbiór danych 
library("ggplot2")
library("eurostat")
library("dplyr")
library("magrittr")

NazwyKolumn <- c("P1_NCH_AW50", "P1_NCH_AW67", "P1_NCH_AW80", "P1_NCH_AW100",
                 "P1_NCH_AW125", "P1_NCH_AW167")

dane <- get_eurostat("gov_10dd_edpt1", 
                     filters = list(geo = eu_countries$code, 
                                    sector = "S13",
                                    na_item = "GD",
                                    unit = "PC_GDP",
                                    lastTimePeriod  = 1))

# 1. Uzyj pipes i funkcji mutate, aby stworzyc nowa zmienna binarna, 
# która przyjie 1 dla etykiety PL oraz 0 w innym przypadku


# 2. Stórz podstawowy wykres slupkowy z posortowanymi wynikami
# Wyróznij w nim Polske 


# 3. Usun etykiety osii, dodaj tytul oraz ustaw styl klasyczny


# 4. Zmien kolory na czerwony i szary


# 5. Dodaj etykiety z wynikami


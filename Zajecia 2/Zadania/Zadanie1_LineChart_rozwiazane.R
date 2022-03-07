# W zadaniu stworzymy wykres liniowy pokazujacy stope odpodatkowania pracy
# singla zarabiajacego x-krotnosc sredniego wynagrodzenia w Polsce i strefie euro

# Ta paczka oraz kolejne zaptyanie przygotuja zbiór danych 
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
dane %<>% mutate(ecase = gsub("P1_NCH_AW", "", ecase)) %>%
  mutate(ecase = as.numeric(ecase))

# 2. Stórz podstawowy wykres Liniowy, gdzie: 
plotSingiel <- ggplot(data=dane, 
                      aes(x=ecase, 
                          y=values, 
                          color=geo)) + geom_line(size=1) 
plotSingiel

# 3. Dodaj punkty dla kolejnych danych oraz zaaplikuj styl klasyczny
plotSingiel <- plotSingiel + geom_point() + theme_classic() 
 
plotSingiel 

# 4. Dodaj tytuly osi i tytul wykresu
plotSingiel <- plotSingiel +
  labs(x="Dochody (% sredniego wynagrodzenia)",
       y="Stopa opodatkowania (%)",
       title = "Progresja podatkwa - Polska vs. strefa euro")

plotSingiel   

# 5. Zmien kolory wykresu na czerwony i szary 
plotSingiel <- plotSingiel + scale_color_manual(values = c("gray", "red"), 
                                                guide = "none")
plotSingiel   

# 6. Zmien kolory wykresu na czerwony i szary 
plotSingiel <- plotSingiel + geom_text(aes(label=ifelse(ecase == 167,
                                                        as.character(geo),'')),
                                       hjust=0,
                                       vjust=1)
plotSingiel

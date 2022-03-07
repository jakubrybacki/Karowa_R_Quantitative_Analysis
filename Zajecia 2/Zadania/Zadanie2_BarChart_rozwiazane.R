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
dane %<>% mutate(isPoland = ifelse(geo =="PL", "1", "0"))

# 2. Stórz podstawowy wykres slupkowy z posortowanymi wynikami
# Wyróznij w nim Polske 
plotDebt <-ggplot(data=dane, aes(x= reorder(geo, -values), 
                                      y=values, 
                                      fill=isPoland)) +
  geom_bar(stat="identity", position = "dodge")  
  
plotDebt

# 3. Usun etykiety osii, dodaj tytul oraz ustaw styl klasyczny
plotDebt <- plotDebt + theme_classic() + 
  labs(x="", 
       y="", 
       title = "Dlug publiczny w 2020 roku (%PKB)")
plotDebt

# 4. Zmien kolory na czerwony i szary
plotDebt <- plotDebt + scale_fill_manual(values = c("1"="red", "0"="gray" ), 
                                         guide = "none")
plotDebt

# 5. Dodaj etykiety z wynikami
plotDebt <- plotDebt + geom_text(aes(label = round(values, digits = 1)), 
                                 position=position_dodge(width=0.9),
                                 vjust = -0.5, colour = "black", 
                                 size=2)
plotDebt


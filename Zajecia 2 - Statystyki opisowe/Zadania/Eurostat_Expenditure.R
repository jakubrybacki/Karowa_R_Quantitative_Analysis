require("eurostat")
require("ggplot2")
require("dplyr")
require("extrafont")

help(p = "eurostat")

# Czcionki instalacja:
#library(remotes)
#remotes::install_version("Rttf2pt1", version = "1.3.8")
#extrafont::font_import()

loadfonts(device = "postscript", quiet = FALSE)
loadfonts(device = "win", quiet = FALSE)

filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/")

#eu_countries 
dictCountries <- eu_countries
countries <- c("CZ", "HU", "PL", "SK", "RO", 
               "DE", "FR" , "IT", "ES", "NL", "BE", "AT",
               "NO", "FI", "SE")

# Wykres: Dlug (%PKB)
queryDebt <- get_eurostat("gov_10dd_edpt1", 
                          filters = list(geo = eu_countries$code, 
                                         sector = "S13",
                                         na_item = "GD",
                                         unit = "PC_GDP",
                                         lastTimePeriod  = 1))
queryDebt <- queryDebt  %>%
  mutate(isPoland = ifelse(geo =="PL", "1", "0"))

plotDebt <-ggplot(data=queryDebt, aes(x= reorder(geo, -values), 
                                      y=values, 
                                      fill=isPoland)) +
  geom_bar(stat="identity", position = "dodge") + 
  theme_classic() + theme(legend.position = "none", 
                          plot.title = element_text(hjust = 0.5,  face="bold")) + 
  labs(x="", y="", 
       title = "Dlug publiczny w 2020 roku (%PKB)") +
  scale_fill_manual(values = c("1"="red", "0"="gray" ), guide = FALSE) +
  geom_text(aes(label = round(values, digits = 1)), position=position_dodge(width=0.9),
            vjust = -0.5, colour = "black")

plotDebt
ggsave(file = paste0(filePath, "wykresy/", "debtToGDPUE.eps"), 
       plot = plotDebt,
       device= "eps",  
       family = "Times",
       width = 14.98,
       height = 6.77)

# Wykres: Deficit (%PKB)
queryDeficit <- get_eurostat("gov_10dd_edpt1", 
                             filters = list(geo = countries, 
                                            sector = "S13",
                                            na_item = "B9",
                                            unit = "PC_GDP",
                                            time  = "2019"))
queryDeficit <- queryDeficit  %>%
  mutate(isPoland = ifelse(geo =="PL", "1", "0"))

plotDeficit <-ggplot(data=queryDeficit, aes(x= reorder(geo, -values), 
                                            y=values, 
                                            fill=isPoland)) +
  geom_bar(stat="identity", position = "dodge") + 
  theme_classic() + theme(legend.position = "none", 
                          plot.title = element_text(hjust = 0.5,  face="bold")) + 
  labs(x="", y="", 
       title = "Deficyt w 2019 roku (%PKB)") +
  scale_fill_manual(values = c("1"="red", "0"="gray" ), guide = FALSE) +
  geom_text(aes(label = round(values, digits = 1)), vjust = -0.5, colour = "black")

plotDeficit
ggsave(file = paste0(filePath, "wykresy/", "deficitToGDPUE.eps"), 
       plot = plotDeficit,
       device= "eps",  
       family = "Times")

# Wykres: Struktura wydatków publicznych w Polsce - klasyfikacja Eurostat (%)
COFOG_main <- c("GF01", "GF02", "GF03", "GF04", "GF05", "GF06",
                "GF07", "GF08", "GF09", "GF10")
COFOG_PL <- c("Uslugi ogólne", "Obrona narodowa", "Bezpieczenstwo publiczne",
              "Gospodarka", "Ochrona srodowiska", "Polityka mieszkaniowa",
              "Zdrowie", "Sport i kultura", "Edukacja", "Wydatki spoleczne")

queryPLExp <- get_eurostat("gov_10a_exp", 
                           filters = list(geo = "PL", 
                                          cofog99 = COFOG_main, 
                                          sector = "S13",
                                          na_item = "TE",
                                          unit = "PC_TOT",
                                          time  = "2019"))
queryPLExp$cofog99 <- COFOG_PL 

# Wykres slupkowy: 
plotPLExp <-ggplot(data=queryPLExp, aes(x= reorder(cofog99, -values),
                                        y=values)) +
  geom_bar(stat="identity", position = "dodge") + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5,  face="bold"),
        axis.text.x = element_text(angle = 45, hjust=1)) +
  labs(x="", y="", title = "Struktura wydatków z 2019 roku (%)") +
  scale_fill_manual(values = c("1"="red", "0"="gray" ), guide = FALSE) +
  geom_text(aes(label = values), vjust = 1, colour = "white")

plotPLExp
ggsave(file = paste0(filePath, "wykresy/", "PL_COFOG.eps"), 
       plot = plotPLExp,
       device= "eps",  
       family = "Times")

# Wykres kolowy: 
plotPLExpPIE <-ggplot(data=queryPLExp, aes(x= "", y=values, fill= cofog99)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)+ 
  theme_void() +
  theme(legend.position="right", 
        plot.title = element_text(hjust = 0.5,  face="bold")) +
  labs(x="", y="", title = "Struktura wydatków z 2019 roku (%)") +
  geom_label(aes(label = values), position = position_stack(vjust = 0.5),
             show.legend = FALSE)

plotPLExpPIE

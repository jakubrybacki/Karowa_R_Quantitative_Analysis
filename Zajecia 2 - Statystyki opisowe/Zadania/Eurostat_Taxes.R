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

# Wykres: Stopa odpodatkowania pracy - singiel (%)
  examples <- c("P1_NCH_AW50", "P1_NCH_AW67", "P1_NCH_AW80", "P1_NCH_AW100",
                "P1_NCH_AW125", "P1_NCH_AW167")
  
  querySingleRate <- get_eurostat("earn_nt_taxrate",
                                  filters = list(geo = c("PL", "EA19"),
                                                 ecase = examples,
                                                 lastTimePeriod  = 1))
  
  querySingleRate <- querySingleRate %>%
    mutate(ecase = gsub("P1_NCH_AW", "", ecase)) %>%
    mutate(ecase = as.numeric(ecase))
  
  plotSingle <- ggplot(data=querySingleRate, aes(x=ecase,
                                                 y=values, 
                                                 color=geo)) +
    geom_line(size=1)+
    geom_point() +
    theme_classic() +
    theme(legend.position="right", 
          plot.title = element_text(hjust = 0.5,  face="bold"),
          axis.text=element_text(size=11)) +
    labs(x="Dochody (% sredniego wynagrodzenia)",
         y="Stopa opodatkowania (%)", 
         title = "Progresja podatkwa - Polska vs. strefa euro") +
    scale_color_manual(values = c("gray", "red"), guide = "none") +
    geom_text(aes(label=ifelse(ecase == 167,as.character(geo),'')),hjust=0,vjust=-1)
  
  plotSingle
  
  ggsave(file = paste0(filePath, "wykresy/", "progresjaUE.eps"), 
         plot = plotSingle,
         device= "eps",  
         family = "Times")
  
# Wykres: Stopa odpodatkowania pracy - singiel 50% sredniego wynagrodzenia po krajach.
  query50UE <- get_eurostat("earn_nt_taxrate", 
                              filters = list(geo = dictCountries$code,
                                             ecase = "P1_NCH_AW50",
                                             lastTimePeriod  = 1))
  
  query50UE <- query50UE  %>%
    mutate(isPoland = ifelse(geo =="PL", "1", "0"))
  
  plotSingle50UE <-ggplot(data=query50UE, aes(x= reorder(geo, -values),
                                                y=values, 
                                                fill=isPoland)) +
    geom_bar(stat="identity", position = "dodge") + 
    theme_classic() + theme(legend.position = "none", 
                            plot.title = element_text(hjust = 0.5,  face="bold")) + 
    labs(x="", y="", title = "Stopa opodatkowania - singiel 50% srednich dochodów (%)") +
    scale_fill_manual(values = c("1"="red", "0"="gray" ), guide = FALSE) +
    geom_text(aes(label = values), vjust = -1, colour = "black")
  
  plotSingle50UE
  ggsave(file = paste0(filePath, "wykresy/", "Single50EU.eps"), 
         plot = plotSingle50UE,
         device= "eps",  
         family = "Times",
         width = 14.98,
         height = 6.77)
  
  # Wykres: Stopa odpodatkowania pracy - rodzina 50% sredniego wynagrodzenia na glowe - 2 dzieci po krajach.
  queryFamily50UE <- get_eurostat("earn_nt_taxrate", 
                            filters = list(geo = dictCountries$code,
                                           ecase = "CPL_CH2_AW100",
                                           lastTimePeriod  = 1))
  
  queryFamily50UE <- queryFamily50UE  %>%
    mutate(isPoland = ifelse(geo =="PL", "1", "0"))
  
  plotFamily50UE <-ggplot(data=queryFamily50UE, aes(x= reorder(geo, -values),
                                              y=values, 
                                              fill=isPoland)) +
    geom_bar(stat="identity", position = "dodge") + 
    theme_classic() + theme(legend.position = "none", 
                            plot.title = element_text(hjust = 0.5,  face="bold")) + 
    labs(x="", y="", title = "Stopa opodatkowania - rodzina z dwójka dzieci, która zarabia srednia pensje (%)") +
    scale_fill_manual(values = c("1"="red", "0"="gray" ), guide = FALSE) +
    geom_text(aes(label = values), vjust = -1, colour = "black")
  
  plotFamily50UE
  ggsave(file = paste0(filePath, "wykresy/", "Family50EU.eps"), 
         plot = plotFamily50UE,
         device= "eps",  
         family = "Times",
         width = 14.98,
         height = 6.77)
  
  
  
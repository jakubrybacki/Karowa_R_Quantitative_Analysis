# Pakiet R jest w stanie obslugiwac pliki innych pakietów statystycznych. 
# Sluzy do tego biblioteka foreign - za jej pomoca odczytamy plik SPSS.  
library(foreign)
library(dplyr)
library(magrittr)

fileDirectory <- paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/")
fileName <- "ATP W82.sav"

dataset = read.spss(paste0(fileDirectory, fileName), to.data.frame=TRUE)

# 1. Przefiltruj dane tak, aby dane dotyczace preferencji politycznych (F_PARTY_FINAL)
#    zawieraly wylaczenie poziomy: Republican, Democrat, Independent. 
#    Policzmy czestosci kazdej z ankiet. 


# 2. Przefiltruj dane tak, aby dane dotyczace ocen walki z Covid-19 w USA (GAP21Q7_a_W82)
#    zawieraly wylaczenie poziomy: "Very good", "Somewhat good", "Somewhat bad". "Very bad"
#    Policzmy czestosci kazdej z ankiet. 


# 3. Przedstawmy tabele krzyzowa, która przedstawi stosunek do Covid-19 


# 4. Wykonaj test Chi-2. Wykorzystaj komende chisq.test
#    Wyniki zapisz w osobnym obiekcie.


# 5. Wydrukuj liczbe obserwowanych i oczekiwanych wartosci w tescie. 


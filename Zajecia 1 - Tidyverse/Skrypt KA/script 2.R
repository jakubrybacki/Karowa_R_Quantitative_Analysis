#install.packages("magrittr")

# wczytywanie bibliotek
require("dplyr")
require("magrittr")
library(readxl)

# Wczytanie danych 
  filePath <- paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/")
  setwd(filePath)

  pisa <- read_excel("PISA-2009-pogimnazjalne.xlsx", "data")
  codebook <- read_excel("PISA-2009-pogimnazjalne.xlsx", "codebook")

# Strukutra pliku

  # Opis struktury
  str(pisa) 
  colnames(pisa)
  
  # Liczba wierszy / kolumn
  nrow(pisa)
  ncol(pisa)

  # Pierwsze / ostatnie wiesze
  head(pisa)
  head(pisa, n = 10)
  tail(pisa)

# Operatory porownania i wektory logiczne
  
  # Dzialania zwracaja zmienna logiczna jak w Python
  y <- head(pisa$scoreKKS)
  y
  y == 182
  y > 190

  z <- head(pisa$scoreKKS_5cat)
  z
  z == "high"
  z > "medium"

  # Wynik mozna zapisac do pliku
  porownanie <- z == "high"
  str(porownanie)

  # Operator NoT - zmienia prawde na falsz
  l <- c(TRUE, FALSE, NA)
  !l

  # OR - zwraca prawde, gdy jest jeden element ma wartosc prawda (TRUE)
  l
  l | TRUE
  l | FALSE

  # AND - zwraca prawde, gdy oba elementy maja wartosc prawda (TRUE)
  l
  l & TRUE
  l & FALSE

## Okreslanie, ktore elementy sa brakami danych
  
  # Tak tego sie nie zrobi
  l
  l == NA

  # Trzeba uzyc funkcji
  is.na(l)

  # wyniki testu PISA z matematyki nie zawieraja braków danych:
  any(is.na(pisa$scorePISAMath))
  
  # ale wyniki Testu Matryc Ravena juÅ¼ tak:
  any(is.na(pisa$scoreTMR))
  
  # alternatywnie:
  all(!is.na(pisa$scorePISAMath))
  all(!is.na(pisa$scoreTMR))

# Filtrowanie danych 

  # Filtrowanie data frame
  scorePISAMathLO <- pisa$scorePISAMath[pisa$schoolType == "LO"]

  scorePISAMathF <- pisa$scorePISAMath[pisa$sex == "female"]
  mean(scorePISAMathF)
  var(scorePISAMathF)
  c <- pisa$score5KNS_5cat[1:5]
  
  pisaLP <- pisa[pisa$schoolType == "LP", ]
  str(pisaLP)

# Maski 
  x <- 1:5 # Tworzy ciag od 1 do 5
  x
  
  # Maska instrukcja rep powtarza komende z pierwszego argumentu x-razy. 
  # Wartosc x-zapisana w drugim argumencie
  y <- c(NA, rep("K", 4)) 
  y
  
  # Instrukcja przetworzy zmienne logiczne
  z <- y == "K"
  z
  x[z]
  
# Operator %in%
  # Pytanie - czy dana wartosc zmiennej jest w wektorze
  a <- 4
  a %in% x
  
  # Inny przyklad:
  a <- LETTERS[1:10]
  a
  b <- c("A", "B", "X")
  b %in% a

  # Operator wykorzystany do przefiltrowania konkretnych danych
  x[z %in% TRUE]

  # i zwrocenia wartosci, ktorych oczekujemy
  x <- 1:5
  y <- c(NA, rep("K", 4))
  z <- y %in% "K"
  x[z]

# Tidyverse - Instrukcja filter
  # Sluzy do wybieranie obserwacji z konkretnych wierszy
  pisaLP <- filter(pisa, schoolType == "LP")
  nrow(pisaLP)
  
  pisaLP_2 <- filter(pisa, schoolType == "LP", sex == "female")
  
  pisaLPT <- filter(pisa, schoolType %in% c("LP", "ZSZ"))

  ## Braki danych przy wybieraniu obserwacji funkcja `filter()`
  pisaHead <- head(pisa)

  # porowwnajmy:
  pisaHead[pisaHead$scoreKKS > 185, ]
  filter(pisaHead, scoreKKS > 185)

# Tidyverse - Instrukcja select
  
  # Instrukcja select sluzy do wybierania kolumn na podstawie zadanych kryteriow
  select(pisa, starts_with("score"))
  select(pisa, contains("PISA"))

  select(pisa, where(is.character))
  select(pisa, where(is.numeric))

  #Opisy innych funkcji, ktore mozna wykorzystac w ramach `select(): 
  # https://tidyselect.r-lib.org/reference/select_helpers.html.
  wybrane <- select(pisa, id, ends_with("pos"), parEdu:income)
  wybrane

  # Instrukcja minus mowi, aby pominac dana zmienna
  select(pisa, -sex)
  select(pisa, -c(id, schoolType, sex, age))

  relocate(pisa, sex)
  relocate(pisa, sex, .after = id)
  relocate(pisa, sex, .before = schoolId)

# Operator `%>%` - tzw. Pipes
  
  # Cel - skrocic kodowanie
  x <- 4
  x <- exp(x)
  x <- sin(x)
  x
  
  # W pipes wyglada nastepujaca
  x <-4 %>% 
    exp() %>% 
    sin() 
  x
  
  # Kolejnosc operacji ma znaczneie
  x <-4  %>%exp() %>% sin() 
  x
  
  x <-4 %>% sin() %>%exp() 
  x

  # przyklad praktyczny  
  pisa %>%
    filter(schoolType == "LP") %>%
    select(starts_with("score")) 
  
  # Operator %<>% - paczka magrittr
  # Aby modyfikowac w dplyr jakas zmienna trzeba zaczac od jej przypisania
  x <-3 
  x <- x %>% sin()
  x
  
  # Takze to mozna uproscic z paketem magrittr 
  y <-3 
  y %<>% sin()
  y
  
# Sortowanie obserwacji
  # rosnaco
  pisa %>%
    arrange(scorePISARead)
  
  # malejaco
  pisa %>%
    arrange(desc(scorePISARead))


# Instrukcja MUTATE - Przeksztalcanie zmiennych przy zachowaniu struktury zbioru
  pisa %<>% mutate(log_income = log(income),
                 scoreTMR = scoreTMR - mean(scoreTMR, na.rm = TRUE))

  # obejrzyjmy wynik
  pisa

## Funkcje `ifelse()` i `case_when()`
  ifelse(c(TRUE, FALSE, TRUE), c(1, 2, 3) , c(10, 11, 12))

  #Chcemy przeksztalcac zmienna `noPersHous` - 
  # opisujemy liczbe osob w gospodarstwie domowym ucznia.
  # Cenzurujemy wartosci wieksze od 7 
  pisa$noPersHous[pisa$noPersHous > 7 & !is.na(pisa$noPersHous)] = 7


# Z tidyverse
  pisa %<>% mutate(noPersHous = ifelse(noPersHous > 7 & !is.na(noPersHous), 7, noPersHous))
  
  pisa %>%
    mutate(math_read = ifelse(scorePISAMath > scorePISARead, "math", "read")) %>%
    select(scorePISAMath, scorePISARead, math_read)
  
  pisa %>%
    mutate(math_avg = case_when(scorePISAMath < quantile(scorePISAMath, 0.25) ~ "very low",
                                scorePISAMath < median(scorePISAMath) ~ "low",
                                scorePISAMath < quantile(scorePISAMath, 0.75) ~ "high",
                                TRUE ~ "very high")) %>%
    select(scorePISAMath, math_avg)
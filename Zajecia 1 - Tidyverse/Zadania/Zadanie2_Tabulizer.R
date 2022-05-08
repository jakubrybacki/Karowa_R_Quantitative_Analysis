# Tabulizer to pakiet, który pozwala na sprawne pobieranie tablic z PDF
# Stosowanie pozwala oszczedzic duzych nakladów pracy przy kopiowaniu i wklejaniu.

# Wykorzystamy ja do skonstruowania bazy danych o strukturze gospodarczej polskich województw na podstawie:
# https://ec.europa.eu/info/research-and-innovation/statistics/performance-indicators/regional-innovation-scoreboard_en

# Paczka wymaga instalacji dwóch elementów miniUI oraz samego tabulizer. 
install.packages("miniUI")
install.packages("tabulizer")

require(tabulizer)

# Ponizsza linijka zapisuje do zmiennej sciezke pod która dostepny jest plik (dziala tylko w RStudio):
fileDirectory <- paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/")

# Nazwy plików, które wykorzystamy w zadaniu:
filePDF <- "Regional profiles Poland.pdf"
fileCSV <- "OutputTable.csv"

# Polecenia 1:
# 1. Uzyj instrukcji paste badz paste0, aby polaczyc nazwe sciezki i pliku PDF


# 2. Wykorzystaj funkcje help, aby poznac sposób wykorzystania funkcji extract_areas
#   Funkcja otwiera obrazek ze strona. 
#   W interfejsie zaznaczacie myszka zakres danych na stronach, które chcemy pobrac


# 3. Wykorzystaj funkcje, aby pobrac mniejsza z tabel na pierwszych 5 stronach PDF


# 4. Przypisz pierwszy element listy do wektora.


# 5. Napisz petle, która doda do naszego wektora druge kolumne z kazdego pozostalego elementu listy


# 6. Wykorzystaje metode paste0, aby polaac nazwe sciezki i docelowa nazwe pliku CSV.


# 7. Zapisz plik w formacie CSV (nazwa ze zmiennej fileCSV):


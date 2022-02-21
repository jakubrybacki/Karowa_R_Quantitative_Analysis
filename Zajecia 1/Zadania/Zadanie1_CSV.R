# Na stronei Dane.Gov.pl mozna znalezc duza liczbe zbiorów danych w formie CSV.

# Dzis wykorzystamy R, aby dowiedziec sie jakie samochody kupuja Polacy - link:
# https://dane.gov.pl/pl/dataset/2189,marki-samochodow-osobowych-w-roku-2021

# Ponizej znajduja sie linki do informacji o rejestracjach samochodów za ostatnie 3 miesiace: 
rejestracje <- c("https://api.dane.gov.pl/media/resources/20220209/MARKI_WOJEW_2022_01.csv",
                 "https://api.dane.gov.pl/media/resources/20220111/MARKI_WOJEW_2021_12_9N3CXqn.csv",
                 "https://api.dane.gov.pl/media/resources/20211217/MARKA_WOJEW_2021_11_D1rxTJr.csv")

okres <- c("Styczen 2022", "Grudzien 2021", "Listopad 2021")

# Polecenia:
# 1. Wczytaj pliki kryjace sie za linkami z wektora rejestracje - mozesz uzyc 3 róznych obiektów 
#   Uwaga: Link podaje sie tak samo jak adres lokalny na dysku twardym. 


# 2. Do kazdej zmiennej dodaje kolumne okres, w której 


# 3. Zlacz trzy obiekty w jeden


# 4. Ile samochodów zarejestrowana lacznie przez ostatni kwartal?
#    Uwaga na braki danych - pomoze opcja na.rm


# 5. Wyfiltruj tylko te obserwacjie, gdzue obserwowalismy przynajmniej 100 rejestracji 
#    w województwie w danym miesiacu.


# 6. Ile marek zawierala poczatkowa tablica, a ile ta z wyfiltrowanymi danymi?
#    Wykorzystaj funkcje Unique i length


# 7. Uzyj funkcji aggregate, aby zsumowac wielkosci po markach.


# 8. Rozszerz rozwiazanie zadania 8, aby sumowac po markach i miesiacach



# Tu zaladuj biblioteki

# Wczytaj dane music_genre.csv

# Sa to dane muzyczne z serwisu Kaggle.com:
# https://www.kaggle.com/datasets/vicsuperman/prediction-of-music-genre

# Zadanie 1: Dane zawieraja braki danych - przekoduj je w pliku:
#   W kolumnie duration_ms -> -1
#   W kolumnie tempo -> -99 
#   W kolumnie instrumentalness -> -99.


# Zadanie 2: Przygotuj nowa ramke, ktora bedzie zawierala wylacznie zmienne 
#   id, acousticness i danceability. 
#   Uzyskana ramke przeksztalc do postaci dlugiej ze zmienna "measure" 
#   zawierajaca nazwe mierzonej wlasnosci (acousticness i danceability) 
#   i zmienna "value" zawierajaca wartosc danej miary dla danej piosenki.


# Zadanie 3: Wyznacz wszytkie tercyle zmiennej popularity.
#   Stworz w zbiorze nowa zmienna "pop_cat", ktora bedzie factorem i ktora bedzie 
#   przyjmowala wartosci "low", "medium" i "high" dla utworow o popularnosci z pierwszego,
#   drugiego i trzeciego tercyla.


# Zadanie 4:
# Przygotuj rozklady zmiennej pop_cat dla roznych gatunkow muzyki. 
# a) Rozklad laczny liczebnosci wraz z marginesami 
# b) Rodzine rozkladow warunkowych kategorii 
#    popularnosci wzgledem gatunku muzyki z odpowiednimi sumami 
# c) Narysuj rodzine rozkladow warunkowych z podpunktu b na wykresie.
#    Ktore gatunki ciesza sie najwieksza, a ktore najmniejsza popularnoscia?


# Zadanie 5: Stworz nowa ramke, ktora bedzie zawierala wylacznie 
#   dane o utworach z gatunku muzyka klasyczna.
#   Zrob histogram i wykres pudelkowy dlugosci trwania utworu (duration_ms) dla tej ramki. 
#   Podpisz osie i wykres.

# Zadanie 6: Stworz zmienna duration_s tak, aby pokazywala liczbe sekund a nie milisekund 
#  (podziel duration_ms przez 1000). Policz srednia, wszystkie kwartyle,
#  odchylenie standardowe i skosnosc czasu trwania utworu wyrazonego w sekundach.

# Zadanie 7: Oblicz sredni czas trwania utworu dla utworoW roznych gatunkow 
#   i przedstaw wyniki na wykresie. Do wykresu dodaj slupki bledow.

# Zadanie 8: Zrob regresje popularnosci utworow rockowych wzgledem dlugosci
#   trwania i danceability.Jak zinterpretowac parametry modelu? 
#   Sprawdz czy w zbiorze sa jakies obserwacje odstajace, 
#   czy zaleznosc faktycznie jest liniowa i czy wspolliniowosc moze stanowic problem.





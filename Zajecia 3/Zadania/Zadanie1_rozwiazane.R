library(dplyr)
library("car") 

# Pakiet R posiada kilkanascie wbudownaych zbiorow danych do cwiczen - aby je podejrzec wpisujemy
data()

# Bedziemy pracowac na pakiecie iris - obrazuje informacje o 3 gatunkach irysow:
#   setosa, versicolor i virginica
data("iris")

# 1. Stworz ramke danych z samymi kwiatami setosa - jaka jest srednia dlugosc jego kwiata (sepal.lenght)
  setosa <- iris %>% filter(Species == "setosa")
  mean(setosa$Sepal.Length)
  
# 2. Stwórzmy druga ramke wylacznie z odmiana versicolor.
#    Wykorzystajmy test-t, aby sprawdzic czy dlugosc kwiata jest równa 5 cm.  
  versicolor <- iris %>% filter(Species == "versicolor")  
  t.test(versicolor$Sepal.Length, mu = 5)
  
# 3. Stwórzmy ostatnia ranmke z odmiana virginica.
#    Wykorzystajmy test-t, aby porownac czy odmiany versicolor i virginica maja taka sama dlugosc kwiata. 
  virginica <- iris %>% filter(Species == "virginica")  
  t.test(versicolor$Sepal.Length, virginica$Sepal.Length)
  
# 4. Pokaz jak wyglada graficzna reprezentacja testow z punktow 2 i 3 w aplikacji:  
#      https://antoinesoetewey.shinyapps.io/statistics-201/ 
#    Zdrob zdjecie za pomoca aplikacji wycinanie
  paste0(versicolor$Sepal.Length, collapse=", ")
  paste0(virginica$Sepal.Length, collapse=", ")
  
# 5. Obejrzyj na wykresach czy dlugosc kwiata w kazdej z grup ma rozklad zblizony do normalnego 
  qqPlot(setosa$Sepal.Length)
  qqPlot(versicolor$Sepal.Length)
  qqPlot(virginica$Sepal.Length)
  
# 6. Przeprowadz formalne testy Shapiro-Wilka lub Kolmogorowa- Smirnova
  shapiro.test(setosa$Sepal.Length)
  shapiro.test(versicolor$Sepal.Length)
  shapiro.test(virginica$Sepal.Length)
  
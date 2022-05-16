#install.packages("factoextra")
library("factoextra")
library("rpart")
library("rpart.plot")

data("iris")

# 1. Principal component analysis (PCA)
# Za pomoca algorytmu przeksztalcamy dowolny zbiór danych
#   do przestrzeni dwuwymiarowej - mozna umiescic go na wykresie
  
  # Komenda
  PCA <- prcomp(iris[,1:4], scale = TRUE)
  PCA
  summary(PCA) 
  
  # Jak powstaja obliczenia - najpierw ususwamy srednia z danych: 
  PCA$center
  summary(iris)
  
  # Zazwyczaj pracujemy na wystandaryzowanych danych - 
  # Odsrednione informacje dzielimy przez odchylenia standardowe .
  PCA$scale
  sapply(iris[,1:4],sd, na.rm = TRUE)
  
  # Budujemy komponenty -  to srednia wazona wlasciwych zmiennych. 
  PCA$rotation
  PCA$x

  # Jak powstaje: https://setosa.io/ev/principal-component-analysis/
  
  # Przedstawienie danych 
  fviz_pca_ind(PCA,
               col.ind = iris$Species,
               palette = c("#00AFBB", "#E7B800", "#FC4E07"),
               repel = TRUE)
  
  fviz_pca_biplot(PCA, repel = TRUE,
                  col.var = "#2E9FDF", # Variables color
                  col.ind = iris$Species,  
                  palette = c("#00AFBB", "#E7B800", "#FC4E07"),
  )
  
  # Czy przyblizenie jest wystarczajace? 
  # Podpowie Wykres lokciowy - amg. scree plot:
  fviz_eig(PCA, addlabels = TRUE, ylim = c(0, 80))
  
  fviz_eig(PCA, addlabels = TRUE, choice = "eigenvalue",ylim = c(0, 3))

# 2. Drzewo decyzyjne 
# Jak sklasyfikowac, które zmienne wplywaja na gatunek kwiatka: 
  
  # Budujemy drzewo decyzyjne tzw. dendrogram
  tree <- rpart(Species ~., data = iris)
  rpart.plot(tree)

  # Wysokoscia drzewa mozna sterowac poprzez argument control:
  #   Minsplit - najmniejsza liczba obserwacji w pojedynczym wezle
  #   cp - o ile % musi poprawiac sie klasyfikacja. 
  
  tree <- rpart(Species ~., data = iris, 
                control=rpart.control(minsplit=10, cp=0.001))
  rpart.plot(tree)
  
# 3. Metoda K-srednich (K-means)
# Ten algorytm bedzie dopasowywal poszczególne obserwacje do gatunków, 
# bez wiedzy o ich przynleznosci. Poinformujemy jedynie o ich ilosci 
  
  Kclusters <- kmeans(iris[, 1:4], centers = 3, iter.max = 100, nstart = 25)
  
  # Wykres - wlasciwe dane
  fviz_pca_ind(PCA,
               col.ind = iris$Species,
               repel = TRUE)

  # Wykres - dopasowanie przez K-means  
  fviz_pca_ind(PCA,
               col.ind = Kclusters$cluster,
               repel = TRUE)
  
  # Inny wykres tego typu
  fviz_cluster(Kclusters, data = iris[,1:4])
  
  # Jak ustalic liczbe klastrów? 
  fviz_nbclust(iris[,1:4], kmeans, method = "wss")
  
  
  
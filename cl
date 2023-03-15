library(cluster)
library(factoextra)
library(NbClust)
library(corrplot)
library(FactoMineR)
library(stringr)
library(maps)
library(dbscan)
library(dplyr)
library(leaflet)
library(RColorBrewer)

#-------------------------------------
# Read data
#-------------------------------------
data$legal_entities_of_small_business=as.numeric(data$legal_entities_of_small_business)
data$medium_business_legal_entities=as.numeric(data$medium_business_legal_entities)
data$individual_entrepreneurs=as.numeric(data$individual_entrepreneurs)
data$peasant_and_farm_enterprises=as.numeric(data$peasant_and_farm_enterprises)
data$all=as.numeric(data$all)

my.path <- paste0("C:/Users/Alina/Desktop/AITU/2 course/Practice-НИЦ/Week1")
setwd(my.path)
data           <- read.csv2("Data1.csv")
rownames(data) <- data[, 1]
data           <- data[, -1]
data[, 1:4]    <- data[,1:4]/data[,5]

df             <- data[, 1:4]

corrplot(cor(df), type="upper")

#-------------------------------------
# Optimal number of clusters with Elbow
#-------------------------------------
sum(as.matrix(dist(df)^2))/(2 * nrow(df))

fviz_nbclust(df, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")


#-------------------------------------
# Optimal number of clusters with Silhouette
#-------------------------------------
fviz_nbclust(df, kmeans, method = "silhouette") +
  labs(subtitle = "Silhouette method")


#-------------------------------------
# Optimal number of clusters with Gap-stat
#-------------------------------------
fviz_nbclust(df, kmeans, method = "gap_stat", nstart=30, nboot = 10)+
  labs(subtitle = "Gap statistic method")


#-------------------------------------
# Optimal number of clusters with Nbclust
#-------------------------------------
res.nbclust <- NbClust(df, distance = "euclide",
                       min.nc = 2, max.nc = 8, 
                       method = "complete", index ="all")

factoextra::fviz_nbclust(res.nbclust) +  
  ggtitle("NbClust's optimal number of clusters")


#-------------------------------------
# k-MEANS
#-------------------------------------
k      <- 4
colors <- brewer.pal(k, "Dark2")

km     <- kmeans(df, center=k, nstart=30)
pca    <- PCA(df, graph = FALSE)

fviz_cluster(km, df, axes=c(1,2), 
             ellipse.type = "convex", 
             palette=colors,
             labelsize=9) + 
  ggtitle(k)

round(km$centers, 3)
round(km$withinss, 5)

df$Cluster <- km$cluster
write.table(df$Cluster, "clipboard", 
            sep="\t", col.names=TRUE, row.names = T)


#-------------------------------------
# PCA
#-------------------------------------
fviz_eig(pca, ylim=(c(0, 100)))
x <- get_eig(pca)
round(x[,2:3], 2)

fviz_pca_ind(pca, col.ind = as.factor(km$cluster), 
             palette = colors, axes=c(1,2), labelsize=3,
             legend.title = "Cluster", addEllipses=F)
fviz_contrib(pca, choice = "var", axes = 1)
fviz_contrib(pca, choice = "var", axes = 2)


var <- get_pca_var(pca)
var$contrib

fviz_pca_biplot(pca, col.ind = as.factor(km$cluster), 
                palette = colors, 
                col.var = "black",
                legend.title = "Cluster",
                addEllipses=F)

library(ggmap)
kz <- get_map(location = "Kazakhstan", zoom = 4)
p = ggmap(Europe)

p = p + geom_point(data = TestCluster, aes(LON, LAT, color = Cluster), size = 1) + 
  scale_color_manual(name = "Cluster", values = c("1" = "yellow",
                                                  "2" = "orange",
                                                  "3" = "red",
                                                  "4" = "green",
                                                  "5" = "blue"))
p

#-------------------------------------
# HCLUST
#-------------------------------------
h=hclust(dist(df[,-4]), "ward.D2")
plot(h)


#-------------------------------------
# DBSCAN
#-------------------------------------
clusters <- dbscan(data, eps=4.5, minPts=2)
clusters
N        <- max(clusters$cluster)
colors   <- c("grey2", brewer.pal(N, "Set1"))

dbs         <- data
dbs$cluster <- clusters$cluster
dbs$size    <- ifelse(dbs$cluster==0, 20, 40)
dbs$color   <- colors[dbs$cluster+1]

map1 <- leaflet(df) %>% addTiles() %>%
  addCircleMarkers(~Lon, ~Lat, popup = ~Children,
                   color = ~cluster, radius=~size, 
                   fillOpacity = 0.7, stroke = FALSE)
map1

hullplot(select(dbs, Elderly, Children), dbs$cluster, 
         col=colors[dbs$cluster], hull_lwd = 2)
hullplot(select(dbs, Elderly, Adults), dbs$cluster, 
         col=dbs$color, hull_lwd = 2)

hullplot(select(dbs, Lon, Lat), cl=dbs$cluster, 
         col=dbs$color, hull_lwd = 2)

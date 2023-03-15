# Cl-r
R
The provided code conducts cluster analysis of the number of people employed in small and medium enterprises in Kazakhstan for the year 2021. The code imports necessary packages, reads the data from a CSV file, preprocesses the data by converting some columns to numeric and dividing columns by the total number of employees, and creates a new data frame with relevant columns. It then calculates the correlation between columns, determines the optimal number of clusters using different methods (Elbow, Silhouette, Gap-stat, NbClust), performs k-means clustering with four clusters, conducts principal component analysis (PCA), and visualizes the clusters on a map using Leaflet. Additionally, hierarchical clustering and DBSCAN are also performed, but not used for further analysis.

The code is well-organized with informative comments and a clear workflow. The use of various clustering methods is good practice and demonstrates the importance of selecting the optimal number of clusters. The use of PCA is also useful in reducing the dimensionality of the data for visualization purposes. The visualization of clusters on a map using Leaflet is an interesting approach to spatial data analysis and helps to understand the geographical distribution of the clusters.

One possible improvement would be to provide a brief explanation of the meaning of each variable/column in the data frame. Also, it would be helpful to include a brief discussion of the results and any insights gained from the clustering analysis. Overall, the code provides a good framework for conducting cluster analysis of the data of the Republic of Kazakhstan.
![image](https://user-images.githubusercontent.com/119506615/225388888-a518e2ed-6175-47f8-b505-2e4418e9b8ac.png)
![image](https://user-images.githubusercontent.com/119506615/225389148-88865d7c-ad59-4877-9f31-5f2710b8a3e1.png)
![image](https://user-images.githubusercontent.com/119506615/225389289-c10369ad-4384-4a12-a5da-f5e8268cee09.png)
![image](https://user-images.githubusercontent.com/119506615/225389415-a8f85176-eed5-4116-8550-a83941ef915b.png)
![image](https://user-images.githubusercontent.com/119506615/225389899-04631682-69ec-4e4d-b8b7-2610e4a30e43.png)
![image](https://user-images.githubusercontent.com/119506615/225390733-4ad239b7-6082-4beb-b966-ffe174405e8a.png)
![image](https://user-images.githubusercontent.com/119506615/225390905-ff9054fc-e6f5-4d17-9ba5-603d847fbc07.png)
![image](https://user-images.githubusercontent.com/119506615/225391058-2c66ad30-966b-40cd-8964-fc3b99f10353.png)
![image](https://user-images.githubusercontent.com/119506615/225391214-edab45d4-8991-4361-bfa8-88d57748f2d9.png)
![image](https://user-images.githubusercontent.com/119506615/225391384-c51d3e7c-1643-479c-8904-d3427565d2fb.png)
![image](https://user-images.githubusercontent.com/119506615/225392199-f05823f7-531e-4dcb-a987-ce8c61f2406b.png)


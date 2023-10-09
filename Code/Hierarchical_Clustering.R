library(stats)  ## for dist
library(NbClust)
#library(cluster)
#library(mclust)
#library(amap)  ## for using Kmeans (notice the cap K)
library(factoextra) ## for cluster vis, silhouette, etc.
#library(purrr)
#library(philentropy)  ## for distance() which offers 46 metrics
#library(SnowballC)
#library(caTools)
library(dplyr)
library(textstem)
library(stringr)
library(wordcloud)
library(dendextend)


file_path = "C:/Users/Amith Nandivada/Desktop/Amith/MS/CUB/Boulder Course Material/Fall23/Machine Learning/Assignment/Data/cleaned_data.csv"

property_df<-read.csv(file_path)
head(property_df)


property_df_clust <- property_df[ ,-c(14) ]
colnames(property_df_clust)

# Create a new column 'mktTtlValue_in_thousands' by dividing 'mktTtlValue' by 1000
property_df_clust$mktTtlValue_in_thousands <- property_df_clust$mktTtlValue / 1000
print(property_df_clust)

property_df_clust <- subset(property_df_clust, select = c(grosssize, mktTtlValue_in_thousands))
head(property_df_clust)


sampled_df <- sample_n(property_df_clust, 20)
Dist <- dist(sampled_df, method = "minkowski", p=2) #Euclidean
print(Dist)

fviz_nbclust(sampled_df, method = "silhouette", 
             FUN = hcut, k.max = 10)

## Using Man with Ward.D2
Dist_C <- stats::dist(sampled_df, method="manhattan")
HClust_Ward_CosSim_df <- hclust(Dist_C, method="ward.D2")

plot(HClust_Ward_CosSim_df, cex=.7, hang=-30,main = "Hierarchical Clustering using Manhattan Distance")
rect.hclust(HClust_Ward_CosSim_df, k=4)



# compute cosine similarity
similarity_matrix <- tcrossprod(scale(sampled_df, center = TRUE, scale = TRUE))

# perform hierarchical clustering using cosine similarity
hclust_results <- hclust(as.dist(1 - similarity_matrix), method = "ward.D2")

# plot the dendogram
plot(hclust_results, main = "Hierarchical Clustering using Cosine Similarity")
rect.hclust(hclust_results, k=2)
# MachineLearning
- Repo contains projects related to ML

# Data
- This folder contains data related to Property Prices.
- property_data.csv is the raw data extracted from ATTOM API.
- cleaned_data.csv is the data extracted after cleaning the property_data.csv dataset. This is the data obtained after cleaning the raw data.
- property_df_normalized.csv is the normalized format of the cleaned_data.csv. In this dataset, all the categorical columns were converted to       numerical format using Target Encoder and then the data was normalized.
- transactional_data.csv was created from categorical columns in the cleaned_data.csv. Categorical columns which had more than 6 classes in it were eliminated and the rest of the categroical data was converted to the transactional data.
  # Kaggle
  - This folder contains the dataset realtor-data.zip.csv downloaded from USA Real Estate Data from Kaggle.
  - URL: https://www.kaggle.com/datasets/ahmedshahriarsakib/usa-real-estate-dataset?resource=download
  
# Code
- ARM.R is the R code for Assoication Rule Mining Analysis on the property data.
- EDA.ipynb is the ipynb file for merging, cleaning the dataset and for Exploratory Data Analysis.
- ExtractDataFromATTOMApi.ipynb is the ipynb file for extracting data from ATTOM API.
- Hierarchical_Clustering.R has the R code for Hierarchical Clustering code using property data.
- KMeans_Clustering.ipynb is the ipynb file for k-Means cluster analysis on property data.
- TransactionalDataPreparation.ipynb is the ipynb file for creating transactional data from the cleaned_data.csv for ARM analysis.
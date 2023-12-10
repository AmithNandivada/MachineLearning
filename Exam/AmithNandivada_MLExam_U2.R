library(viridis)
library(arules)
library(TSP)
library(data.table)
library(dplyr)
library(devtools)
library(purrr)
library(tidyr)
library(arulesViz)

setwd("C:/Users/Amith Nandivada/Desktop/Amith/MS/CUB/Boulder Course Material/Fall23/Machine Learning/Assignment/Exam/")
#setwd("/content/")

previous_items_df <- read.transactions("transactional_exam_data.csv",
                                       rm.duplicates = FALSE, 
                                       format = "basket",  ##if you use "single" also use cols=c(1,2)
                                       sep=",",  ## csv file
                                       cols=NULL)
inspect(previous_items_df)


purchased_items_rules = arules::apriori(previous_items_df, parameter = list(support=0.01, 
                                                                            confidence=0.01,minlen=2))
inspect(purchased_items_rules)


# Find which terms are more frequent.
itemFrequencyPlot(previous_items_df, topN=30, type="absolute", cex.names = 0.6)


# Print the item frequencies
item_frequencies <- itemFrequency(previous_items_df)
item_frequencies_df <- as.data.frame(item_frequencies)
print(item_frequencies_df)



# Sorting the rules with lift, support, confidence
SortedRules_lift <- sort(purchased_items_rules, by="lift", decreasing=TRUE)
inspect(SortedRules_lift[1:20])
# (summary(SortedRules_lift))

SortedRules_support <- sort(purchased_items_rules, by="support", decreasing=TRUE)
inspect(SortedRules_support[1:20])

SortedRules_confidence <- sort(purchased_items_rules, by="confidence", decreasing=TRUE)
inspect(SortedRules_confidence[1:20])


# Visualize top rules sorted on the basis of lift.
subrules_lift <- head(sort(SortedRules_lift, by="lift"), 15)
plot(subrules_lift)
plot(subrules_lift, method="graph", engine="htmlwidget")


# Visualize top 15 rules sorted on the basis of support
subrules_support <- head(sort(SortedRules_support, by="support"),15)
plot(subrules_support)
plot(subrules_support, method="graph", engine="htmlwidget")


# Visualize top 15 rules sorted on the basis of confidence
subrules_confidence <- head(sort(SortedRules_confidence, by="confidence"),15)
plot(subrules_confidence)
plot(subrules_confidence, method="graph", engine="htmlwidget")


#In the context of my Association Rule Mining (ARM) analysis, I efficiently organized the identified rules based on various criteria, 
#providing a comprehensive understanding of the inherent patterns in customer purchasing behavior. By sorting rules according to lift, 
#support, and confidence, I gained insights into the strength and significance of associations between items. For example, rules with 
#high lift values, such as {Smartwatch} => {Shoes}, indicate a significant increase in the likelihood of purchasing Shoes when a 
#Smartwatch is bought. Conversely, rules sorted by confidence, like {Clothes} => {Makeup}, reveal a perfect association, signifying 
#that customers who buy Clothes almost always purchase Makeup as well. These sorted rules offer a valuable guide for strategic 
#decision-making, enabling me to prioritize and focus on the most impactful associations in optimizing product placement, marketing 
#strategies, and customer recommendations.


#The rule {Cooker} => {Phone} suggests that customers who purchase a "Cooker" are highly likely to also buy a "Phone," presenting an 
#opportunity to bundle or promote these items together. The rule {Blender} => {Smartphone} indicates a strong association between
#"Blender" and "Smartphone" purchases, suggesting cross-category promotions or targeted marketing strategies. Moreover, the rule 
#{Clothing} => {Makeup} with a high lift of 7.22 implies a significant synergy between buying "Clothing" and "Makeup." This finding 
#could guide retail strategies, such as creating special offers for combined purchases. Additionally, the rule {Furniture} => {Books} 
#reveals a notable association, potentially leading to strategies that enhance the shopping experience by co-locating these items in 
#physical stores or recommending them online. These identified rules provide actionable insights into customer behavior and offer 
#strategic directions for enhancing product placement, promotions, and personalized recommendations to maximize sales and customer 
#satisfaction.

library(viridis)
library(arules)
library(TSP)
library(data.table)
library(dplyr)
library(devtools)
library(purrr)
library(tidyr)
library(arulesViz)


setwd("C:/Users/Amith Nandivada/Desktop/Amith/MS/CUB/Boulder Course Material/Fall23/Machine Learning/Assignment/Data/")
property_details <- read.transactions("transactional_data.csv",
                                      rm.duplicates = FALSE, 
                                      format = "basket",  ##if you use "single" also use cols=c(1,2)
                                      sep=",",  ## csv file
                                      cols=NULL)
inspect(property_details)


# Find rules with minimum support, minimum confidence, and minimum length of 2
property_rules = arules::apriori(property_details, parameter = list(support=0.1, 
                                                                    confidence=0.1,minlen=2))
inspect(property_rules)


# Find which terms are more frequent.
itemFrequencyPlot(property_details, topN=20, type="absolute", cex.names = 0.6)


# Sorting the rules with lift, support, confidence
SortedRules_lift <- sort(property_rules, by="lift", decreasing=TRUE)
inspect(SortedRules_lift[1:15])
(summary(SortedRules_lift))

SortedRules_support <- sort(property_rules, by="support", decreasing=TRUE)
inspect(SortedRules_support[1:15])

SortedRules_confidence <- sort(property_rules, by="confidence", decreasing=TRUE)
inspect(SortedRules_confidence[1:15])


# House Condition is Good
HouseCondition_Good_Rules_lift <- apriori(data=property_details,parameter = list(supp=.1, conf=.1, minlen=2),
                          appearance = list(default="lhs", rhs={"GOOD"}),
                          control=list(verbose=FALSE))
HouseCondition_Good_Rules_lift <- sort(HouseCondition_Good_Rules_lift, decreasing=TRUE, by="lift")
inspect(HouseCondition_Good_Rules_lift)


# House Type is a CONVENTIONAL HOUSE
HouseType_Conventional_Rules_lift <- apriori(data=property_details,parameter = list(supp=.1, conf=.1, minlen=2),
                                          appearance = list(default="lhs", rhs={"CONVENTIONAL HOUSE"}),
                                          control=list(verbose=FALSE))
HouseType_Conventional_Rules_lift <- sort(HouseType_Conventional_Rules_lift, decreasing=TRUE, by="confidence")
inspect(HouseType_Conventional_Rules_lift)



# Plots
# Visualize top 15 rules sorted on the basis of lift.
subrules_lift <- head(sort(SortedRules_lift, by="lift"),15)
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

# Rules for House Condition being Good, sorted on the basis of lift
HouseCondition_Good_Rules_lift <- head(sort(HouseCondition_Good_Rules_lift, by="lift"),15)
plot(HouseCondition_Good_Rules_lift)
plot(HouseCondition_Good_Rules_lift, method="graph", engine="htmlwidget")
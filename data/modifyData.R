#!/usr/bin/env Rscript

#This original dataset which we laod was generated using https://github.com/fhdsl/Intro_to_R/blob/main/classroom_data/gen_classroom_data.R
#Its raw data was downloaded from https://depmap.org/portal/download/all specifically version DepMap Public 23Q2

library(tidyverse)
library(here)
library(openxlsx)

load(url("https://github.com/fhdsl/S1_Intro_to_R/raw/main/classroom_data/CCLE.RData"))

#join the datasets into one large dataframe
analysis <- full_join(metadata, expression, by = "ModelID") %>%
  full_join(mutation, by = "ModelID")

#add some noise to the dataset for data wrangling/teaching purposes
#Specifically we're going to add acronyms/abbreviations/alternate spellings for
##Female/F
##Male/M
##Non-Cancerous/Noncancerous
##Lung Neuroendocrine Tumor/NET
##Esophagogastric Adenocarcinoma/EAC
##Non-Hodgkin Lymphoma/NHL/non-Hodgkin's Lymphoma
#Already there's oesophagus vs esophagus within SampleCollectionSite
set.seed(28)

#' a function to do the random altering of a column in the dataframe since I do that a lot
#' @param df the input dataframe
#' @param coi the column of interest that will be mutated
#' @param po the percent of observations that will be randomly mutated as a decimal (e.g., 0.05 for 5%)
#' @param ov the original value that will be overwritten
#' @param nv the new value that will replace the original value
#' @return df the altered input dataframe
#' @examples \dontrun{
#' 
#' #example used to build the function
#' #whichF <- sample(1:sum(analysis$Sex == "Female"), size=floor(0.05*sum(analysis$Sex == "Female")))
#' #analysis[which(analysis$Sex == "Female")[whichF], "Sex"] <- "F"
#' 
#' #given the example above
#' df <- alter_column(df, "Sex", 0.05, "Female", "F")
#' 
#' }
#' 
alter_column <- function(df, coi, po, ov, nv){
  whichOV <- sample(1:sum(df[[coi]] == ov), size=floor(po*sum(df[[coi]] == ov)))
  df[which(df[[coi]] == ov)[whichOV], coi] <- nv
  return(df)
}

analysisOrig <- analysis
##turn some Female into F and some Male into M
analysis <- alter_column(analysis, "Sex", 0.05, "Female", "F")
analysis <- alter_column(analysis, "Sex", 0.05, "Male", "M")

##turn some Non-Cancerous into Noncancerous in the OncotreePrimaryDisease
analysis <- alter_column(analysis, "OncotreePrimaryDisease", 0.03, "Non-Cancerous", "Noncancerous")

##turn some OncotreePrimaryDisease into acronyms
analysis <- alter_column(analysis, "OncotreePrimaryDisease", 0.09, "Lung Neuroendocrine Tumor", "NET")
analysis <- alter_column(analysis, "OncotreePrimaryDisease", 0.08, "Esophagogastric Adenocarcinoma", "EAC")
analysis <- alter_column(analysis, "OncotreePrimaryDisease", 0.03, "Non-Hodgkin Lymphoma", "NHL")
analysis <- alter_column(analysis, "OncotreePrimaryDisease", 0.1, "Non-Hodgkin Lymphoma", "non-Hodgkin's Lymphoma")

#save the dataset as RData and as an excel sheet
save(analysis, file = here("data/depMapData_benchToBytes.RData"))
write.xlsx(analysis, here('data/depMapData_benchToBytes.xlsx'))

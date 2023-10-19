

# Perform Main and Interaction effect analysis on multiple disease cohorts


## Description 

Given a dataset comprising of four different combination of control/disease data (Control samples, Disease_1 only samples, Disease_2 only samples, and Disease_1_2 samples(affected by both the disease)), this function returns a list of main and interaction effect features.

## Usage 

MI_func(Control_data, Disease_1_data, Disease_2_data, Disease_1_2_data, covariates, disease_terms, cut_off, wk_dir)

## Arguments
|Arguments|Description|
|---|---|
|Control_data|A data frame of size **a x n**, where a is the number of healthy samples and n is the number of features|
|Disease_1_data|A data frame of size **b x n**, where b is the number of samples affected by Disease 1 and n is the number of features|
|Disease_2_data|A data frame of size **c x n**, where c is the number of samples affected by Disease 2 and n is the number of features|
|Disease_1_2_data|A data frame of size **d x n**, where d is the number of samples affected by both Disease 1 and 2 and n is the number of features|
|covariates|A character vector (of length x+2; where x is the number of co-variates in the data) containing the co-variates, along with the disease status terms. These are the names of the corresponding columns in the input dataframe|
|disease_terms|A character vector (of length 2) containing only the disease status terms. These are the names of the corresponding columns in the input dataframe|
|cut_off|cut-off to be used for adjusted p-value|
|wk_dir|working directory to store the output of this function|
## Details

This function performs main and interaction effect on data with four different cohorts. The four cohorts are control case, 

## Value

**MI_func** returns a list of lists. 

|Output|Description|
|output$features_m_df|A dataframe containing the list of features, it's p value, and adjusted p value. When a cut-off (cut_off argument) is applied on the adjusted p value, **main effect** features can be filtered out|
|output$features_i_df|A dataframe containing the list of **main effect** features, it's p value, and adjusted p value. When a cut-off (cut_off argument) is applied on the adjusted p value, **interaction effect** features can be filtered out|
|output$Main_effect_variables|The list of **main effect features** obtained from the analysis|
|output$Interaction_effect_variables|The list of **interaction effect features** obtained from the analysis|





















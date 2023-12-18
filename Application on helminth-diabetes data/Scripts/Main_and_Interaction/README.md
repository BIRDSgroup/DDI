# Instructions to run "MI_script.R" file
## Preface
This R file contains the code to reproduce the results from the Main and Interaction analysis.
The details of the outputs generated from this script are given below.

## Instruction
1. Modify the code at line 325 (shown below) to the working directory containing the main and interaction effect data.
```R
wd_m <- c("D:/work/DM_Hel/reproduce/data/")
```
2. After making this adjustment, save the script and execute it.

# Output from "MI_script.R"
Running this script will generate two folders **before_treatment** and **after_treatment** folders in the working directory that you have specified in the above section.
Here is the list of output files generated in both the folders:
|Output|Description|
|---|---|
|Ternary_plot|PNG image of Ternary plot|
|Main_effect_pvals|CSV file containing the list of variables, p-values, and adjusted p-values from Main effect analysis|
|Interaction_effect_pvals|CSV file containing the list of features, p-values, and adjusted p-values from Interaction effect analysis|
|DATA_main_effect|Text file containing output from main effect analysis|
|DATA_interaction_effect|Text file containing output from interaction effect analysis|
|Main_eff_DATA_coeff|Text file containing the coefficients of the main effect linear model; outputs: model intercept, the coefficient for Helminth term, and the coefficient for Diabetes term|
|Int_eff_DATA_coeff|Text file containing the coefficients of the interaction effect linear model; outputs: model intercept, the coefficient for Helminth term, the coefficient for Diabetes term, and the coefficient for Helminth:Diabetes interaction term |
|Main_eff_coeff_terms_data|CSV containing variables and the main effect model's intercept, the coefficient for Helminth term, and the coefficient for Diabetes term|
|Int_eff_coeff_terms_data|CSV containing variables and the interaction effect model's intercept, the coefficient for Helminth term, and the coefficient for Diabetes term, and the coefficient for Helminth:Diabetes interaction term|
|per_exp_variance_BT/per_exp_variance_AT|RDS file containing the list of features and the percentage of variance explained by the helminth term (class), diabetes term (group), and the interaction term. "per_exp_variance_BT" is for before-treatment samples and "per_exp_variance_AT" is for after-treatment samples.|
|rela_per_exp_variance_BT/rela_per_exp_variance_AT|RDS file containing the features and the relative percentage of variance explained by the helminth term (class), diabetes term (group), and the interaction term. "rela_per_exp_variance_BT" is for before-treatment samples and "rela_per_exp_variance_AT" is for after-treatment samples.|
|BT_mi_obj/AT_mi_obj|list containing the main and interaction effect analysis output. "BT_mi_obj" is for before-treatment samples and "AT_mi_obj" is for after-treatment samples.|
|Supp_Figure_3|This folder (which is generated in **before_treatment** folder) contains the **.jpg** figures of interaction plots to get Supplementary Figure 3|
|Supp_Figure_4|This folder (which is generated in **after_treatment** folder) contains the **.jpg** figures of interaction plots to get Supplementary Figure 4|
|Supp_Tbl_2|CSV file - Supplementary Table 2 from our paper generated in **before_treatment** folder|
|Supp_Tbl_3|CSV file - Supplementary Table 3 from our paper generated in **after_treatment** folder|



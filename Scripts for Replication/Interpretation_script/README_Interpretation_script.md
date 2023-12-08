# Instructions to run "Interpretation_script.R" file
## Preface
This R file contains the code to reproduce the results from the interpretation analysis.
The details of the output generated from this script are given below.
## Instruction
1. Modify the code at line 115 (shown below) to the folder containing the supplementary data 1.
```R
wd_5 <- c("D:/work/DM_Hel/Manuscript/new_interpret/")
```
2. Modify the code at line 120 (shown below) to the working directory containing the supplementary data 1 (with .xlsx extension).
```R
path_to_file <- c("D:/work/DM_Hel/Manuscript/Extra_analysis/DDI_TGs/Recatome_webgestaltR/results_from_WebGestaltR/all_pval_reactome.xlsx")
```
3. After making this adjustment, save the script and execute it.

# Output from "Interpretation_script.R"
Running this script will generate two outputs (RDS objects) for Figures 5 and 6 from the main figure. 

|Output|Description|
|---|---|
|Figure_5| RDS object for figure 5 from the main paper generated in the working directory provided in instruction point 3 above.|
|Figure_6| RDS object for figure 6 from the main paper generated in the working directory provided in instruction point 2 above.|





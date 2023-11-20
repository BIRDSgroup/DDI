# Instructions to run "Interpretation_script.R" file
## Preface
This R file contains the code to reproduce the results from the interpretation analysis.
The details of the output generated from this script are given below.
## Instruction
1. Modify the code at line 102 (shown below) to the path containing the supplementary data 1.
```R
path_to_file <- c("D:/work/DM_Hel/Manuscript/Extra_analysis/DDI_TGs/Recatome_webgestaltR/results_from_WebGestaltR/all_pval_reactome.xlsx")
```
2. Modify the code at line 104 (shown below) to the working directory of the same.
```R
wd <- c("D:/work/DM_Hel/Manuscript/Extra_analysis/DDI_TGs/Recatome_webgestaltR/results_from_WebGestaltR")
```
3.  Modify the code at line 109 (shown below) to the working directory to store Figure 5.
```R
wd <- c("D:/work/DM_Hel/Manuscript/Extra_analysis/DDI_TGs/Recatome_webgestaltR/results_from_WebGestaltR")
```
4. After making this adjustment, save the script and execute it.

# Output from "Interpretation_script.R"
Running this script will generate two outputs (RDS objects) for Figures 5 and 6 from the main figure. 

|Output|Description|
|---|---|
|Figure_5| RDS object for figure 5 from the main paper generated in the working directory provided in instruction point 3 above.|
|Figure_6| RDS object for figure 6 from the main paper generated in the working directory provided in instruction point 2 above.|





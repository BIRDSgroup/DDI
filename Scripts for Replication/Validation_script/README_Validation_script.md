# Instructions to run "Validation_script.R" file
## Preface
This R file contains the code to reproduce the results from the validation analysis.
The details of the outputs generated from this script are given below.

## Instruction
1. Modify the code at line 400 (shown below) to the working directory containing the validation data.
```R
wr_dr <- c("D:/work/DM_Hel/reproduce/Validation/validation_data/")
```
2. Modify the code at line 417 (shown below) to the working directory containing the main and interaction effect data (discovery cohort).
```R
wd_m <- c("D:/work/DM_Hel/reproduce/data/")
```
3. After making this adjustment, save the script and execute it.

# Output from "Validation_script.R"
Running this script will generate a few results in the same folder where the validation data is stored (same working directory mentioned in the above section). 
Here is the list of output files generated in the folder:
1) **Validation_results.RDS**<br>
This file contains 7 outputs.

|Output|Description|
|---|---|
|replication_image| Figure 4A in the main paper.|
|Robust t-test pval - hel-dm- vs hel+dm+| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm- vs hel+dm+** in the validation analysis.|
|Robust t-test pval - hel-dm+ vs hel+dm+| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm+ vs hel+dm+** in the validation analysis.|
|Robust t-test pval - hel-dm+ vs hel-dm-| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm+ vs hel-dm-** in the validation analysis.|
|TNFalpha_image| Figure 4B in the main paper.|
|IFNgamma_image| Figure 4C in the main paper.|
|pvalue_validation_discovery_cohort|A data frame (35 x 7) consisting of the adjusted p values from the main effect analysis performed on the three pairs of datasets in the validation analysis. First column corresponds to the feature names, 2nd column p values from the hel-dm- vs hel+dm+ pair of groups in the validation cohort, 3rd column p values from the hel-dm- vs hel+dm+ pair of groups in the discovery cohort, 4th column p values from the hel-dm+ vs hel+dm+ pair of groups in the validation cohort, 5th column p values from the hel-dm+ vs hel+dm+ pair of groups in the discovery cohort, 6th column p values from the hel-dm+ vs hel-dm- pair of groups in the validation cohort, 7th column p values from the hel-dm+ vs hel-dm- pair of groups in the discovery cohort |
2) **Supplementary_Figs_6_7.RDS**<br>
This file contains 9 outputs (3 figures and 6 are Yuen's robust t-test p values associated with three pairs of groups used in the validation analysis under 0.01 and 0.05 FDR.

|Output|Description|
|---|---|
|IL2_image| Supplementary figure 7|
|Replication_image_cutoff0.01| Supplementary figure 6|
|Replication_image_cutoff0.05| Supplementary figure 6|







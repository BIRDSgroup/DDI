# Instructions to run "Validation_Script.R" file
## Preface
This R file contains the code to reproduce the results from the validation analysis.
The details of the outputs generated from this script are given below.

## Instruction
1. Modify the code at line 445 (shown below) to the working directory containing the validation data.
```R
wr_dr <- c("D:/work/DM_Hel/reproduce/Validation/validation_data/")
```
2. Modify the code at line 465 (shown below) to the working directory containing the main and interaction effect data (discovery cohort).
```R
wd_dir_disco <- c("D:/work/DM_Hel/reproduce/data/")
```
3. After making this adjustment, save the script and execute it.

# Output from "Validation_script.R"
1) Running this script will generate a few results (R objects) in the same folder where the validation data is stored (the working directory mentioned above). Load these R objects in your local R studio to view the outputs.
2) Two folders - **Main_figures** and **Supplementary_Figures** will be generated in the working directory where the validation data is stored. The **Main_Figures** folder will contain four JPG images that are part of the **Figure 4** in the manuscript. The **Supplementary_Figures** folder will contain eight JPG images that form **Supplementary Figure 6** and **Supplementary Figure 7** in the manuscript.

Here is the list of output files generated in the folder:
1) **Validation_results.RDS**<br>
This file contains 7 outputs.

|Output|Description|
|---|---|
|replication_image| Figure 4B in the main paper.|
|Robust t-test pval - hel-dm- vs hel+dm+| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm- vs hel+dm+** in the validation analysis.|
|Robust t-test pval - hel-dm+ vs hel+dm+| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm+ vs hel+dm+** in the validation analysis.|
|Robust t-test pval - hel-dm+ vs hel-dm-| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm+ vs hel-dm-** in the validation analysis.|
|TNFalpha_image| Figure 4A in the main paper.|
|IFNgamma_image| Figure 4A in the main paper.|
|IL2_image| Figure 4A in the main paper.|
|pvalue_validation_discovery_cohort|A data frame (35 x 7) consisting of the adjusted p-values from the main effect analysis performed on the three pairs of datasets in the validation analysis. The first column corresponds to the feature names, 2nd column p-values from the hel-dm- vs hel+dm+ pair of groups in the validation cohort, 3rd column p-values from the hel-dm- vs hel+dm+ pair of groups in the discovery cohort, 4th column p-values from the hel-dm+ vs hel+dm+ pair of groups in the validation cohort, 5th column p-values from the hel-dm+ vs hel+dm+ pair of groups in the discovery cohort, 6th column p-values from the hel-dm+ vs hel-dm- pair of groups in the validation cohort, 7th column p-values from the hel-dm+ vs hel-dm- pair of groups in the discovery cohort |
2) **Supplementary_Figs_6_7.RDS**<br>
This file contains 14 outputs (8 figures and 6 are Yuen's robust t-test p-values associated with three pairs of groups used in the validation analysis under 0.01 and 0.05 FDR).

|Output|Description|
|---|---|
|IL4_image| Supplementary figure 6|
|IL5_image| Supplementary figure 6|
|IL10_image| Supplementary figure 6|
|IL17a_image| Supplementary figure 6|
|Visfatin_image| Supplementary figure 6|
|Replication_image_cutoff0.01| Supplementary figure 7|
|Replication_image_cutoff0.05| Supplementary figure 7|

3) Supplementary Table 4 - CSV file





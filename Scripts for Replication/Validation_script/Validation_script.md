# Instructions to run "Validation_script.R" file
## Preface
This R file contains the code to reproduce the results from the validation analysis.
Refer to the Primary_README.md file for a detailed explanation of the results obtained.

## Instruction
1. Modify the code at line 400 (shown below) to the working directory containing the validation data.
```R
wr_dr <- c("D:/work/DM_Hel/reproduce/Validation/validation_data/")
```
2. Modify the code at line 400 (shown below) to the working directory containing the main and interaction effect data (discovery cohort).
```R
wd_m <- c("D:/work/DM_Hel/reproduce/data/")
```
3. After making this adjustment, save the script and execute it.

# Output from "MI_script.R"
Running this script will generate a few results in the same folder where the validation data is stored (same working directory mentioned in the above section). 
Here is the list of output files generated in the folder:
1) **Validation_results.RDS**
This file contains 7 outputs.

|Output|Description|
|---|---|
|replication_image| Figure 4A in the main paper.|
|Robust t-test pval - hel-dm- vs hel+dm+| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm- vs hel+dm+** in the validation analysis.|
|Robust t-test pval - hel-dm+ vs hel+dm+| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm+ vs hel+dm+** in the validation analysis.|
|Robust t-test pval - hel-dm+ vs hel-dm-| This contains the statistics of Yuen's robust t-test for the pair of group **hel-dm+ vs hel-dm-** in the validation analysis.|

2) 





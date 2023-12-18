# Instructions to run "BN_reconstruction_Script.R" file
## Preface
This R file contains the code to reproduce the Bayesian network reconstruction done for before- and after-treatment cohorts (Supplementary Figures 2a and 2b).
The details of the output generated from this script are given below.
## Instruction
1. Modify the code at line 1 (shown below) to the folder containing the main and interaction effect analysis data.
```R
wd_hp <- c("D:/work/DM_Hel/Heatmap/data/checking/")
```
2. After making this adjustment, save the script and execute it.

# Output from "BN_reconstruction_Script.R"
Running this script will generate two CSV files, "**BT_BN_reconstruction_arcs.csv**" and "**AT_BN_reconstruction_arcs.csv**" in the folder **Supplementary_Figures_2a_and_2b** created in the working directory mentioned above. 

# Supplemntary Figure 2a and 2b
Load the two CSV files separately into the **Cytoscape** app (version: 3.9.1) to visualize the reconstructions of the Bayesian networks.



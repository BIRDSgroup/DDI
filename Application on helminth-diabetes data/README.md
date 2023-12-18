# Application on helminth-diabetes data

## Section 1: Scripts
This folder contains  R codes to run the various analyses that are mentioned in our paper.

### R Studio
The codes were developed/run on R Studio -  R version 4.2.1 (2022-06-23 ucrt).

## Section 2: Main Figures, Supplementary Figures and Supplementary Tables
### Instructions to get the Main Figures, Supplementary Figures, and Supplementary Tables
There are a total of 6 main figures, 7 supplementary figures, and 4 supplementary tables. 
This file will provide the necessary instructions to generate the figures, supplementary figures, and sheets given in the main text.

## Section 1 - Main Figures 
### Figure 1 - Methods Overview 

### Figure 2 - Data Overview
Run the ["Heatmaps_Script.R"](Scripts/Heatmaps/Heatmaps_Script.R) under the **Scripts** section. Refer to the [README](Scripts/Heatmaps/README.md) file on how to run this script. This will generate **heatmap_fig2a.png** in the folder set as the working directory. 

### Figure 3 - Ternary plot
Two figures in the ternary plot:

1. Before treatment 
2. After treatment 

Run the ["MI_Script.R"](Scripts/Main_and_Interaction/MI_Script.R) under the **Scripts** section. This will generate both before and after-treatment ternary plots, which are for **Figure 3**. Refer to the [README](Scripts/Main_and_Interaction/README.md) file on how to run this script.

### Figure 4 - Replication analysis

Run the ["Validation_Script.R"](Scripts/Validation/Validation_Script.R) under the **Script** section. This will generate the plots for **Figure 4**. Please take a look at the [README](Scripts/Validation/README.md) file for reference.
Three figures in **Figure 4** (Check **Main_Figures** folder generated after running this script):

1. Replication.jpg
2. IFN-gamma.jpg
3. TNF-alpha.jpg
   
### Figure 5 - Source immune cells of some of the DDI markers

Run the ["Interpretation_Script.R"](Scripts/Interpretation/Interpretation_Script.R) under the **Script** section. **Figure_5.jpg** is generated in the folder **Figure_5_and_6** after running the script. Please take a look at the [README](Scripts/Interpretation/README.md) file for reference.

### Figure 6 - Reactome pathway heatmap 

Run the ["Interpretation_Script.R"](Scripts/Interpretation/Interpretation_Script.R) under the **Script** section. **Figure_6.jpg** is generated in the folder **Figure_5_and_6** after running the script. Please take a look at the [README](Scripts/Interpretation/README.md) file for reference.


## Section 2 - Supplementary Figures

### Supplementary Figure 1 - Overview of adjusted data
Run the ["Heatmaps_Script.R"](Scripts/Heatmaps/Heatmaps_Script.R) under the **Scripts** section. Refer to the [README](Scripts/Heatmaps/README.md) file on how to run this script. This will generate **Suppl_Fig_2.png** in the folder set as the working directory. 

### Supplementary Figure 2a and 2b - Bayesian network reconstruction

Run the ["BN_reconstruction_Script.R"](Scripts/BN_reconstruction/BN_reconstruction_Script.R) under the **Scripts** section. The [README](Scripts/BN_reconstruction/README.md) file provided instructions to run the script and visualize the Bayesian network reconstructions corresponding to supplementary figures 2a and 2b.

### Supplementary Figures 3 and 4 - Interaction plots
Run the ["MI_Script.R"](Scripts/Main_and_Interaction/MI_Script.R) under the **Scripts** section. This will generate two folders **Supp_Figure_3** and **Supp_Figure_4** which contain **.jpg** figures of the interaction plots used to obtain **Supplementary Figure 3** and **Supplementary Figure 4** from the manuscript respectively. Refer to the [README](Scripts/Main_and_Interaction/README.md) file on how to run this script.

### Supplementary Figure 5 - Unexplained variance plot
Run the ["MI_Script.R"](Scripts/Main_and_Interaction/MI_Script.R) under the **Scripts** section. This will generate two folders **Supp_Figure_3** and **Supp_Figure_4** which contain **.jpg** figures of the interaction plots used to obtain **Supplementary Figure 3** and **Supplementary Figure 4** from the manuscript respectively. Refer to the [README](Scripts/Main_and_Interaction/README.md) file on how to run this script.


### Supplementary figure 6 and 7 - Additional replication results/Boxplots from replication analysis

Run the ["Validation_Script.R"](Scripts/Validation/Validation_Script.R) under the **Script** section. This will generate the plots for **Supplementary Figure 6** and **Supplementary Figure 7** in the folder **Supplementary Figures**. Please take a look at the [README](Scripts/Validation/README.md) file for instructions to run the script.

Run the code in **Section 4** in the **Replication analysis** file to obtain supplementary figures 6 and 7.

 

## Section 3 - Supplementary tables

### Supplementary Table 2 (Before-Treatment analysis data) and Supplementary Table 3 (After-Treatment analysis data)

There are 15 columns in these tables. They are **Variables**, **Main effect p-values**, **Main effect adjusted p-values**, **Interaction effect p-values**, **Interaction effect adjusted p-values**, **Main effect model - b0 (Intercept coefficient)**, **Main effect model - b1 (Helminth term coefficient)**, **Main effect model - b2 (Diabetes term coefficient)**, **Relative explained variance (Helminth term)**, **Relative explained variance (Diabetes term)**, **Relative explained variance (Helminth:Diabetes interaction term)**, **Unexplained variance by the three terms**, **Interaction effect model - c0 (Intercept coefficient)**, **Interaction effect model - c1 (Helminth term coefficient)**, **Interaction effect model - c2 (Diabetes term coefficient)**, and **Interaction effect model - c3 (Helminth:Diabetes interaction term coefficient)**.

#### Supplementary Table 2 
Run the ["MI_Script.R"](Scripts/Main_and_Interaction/MI_Script.R) under the **Scripts** section. This will generate **Suppl_Tbl_2.csv** which is Supplementary Table 2 from our paper. Refer to the [README](Scripts/Main_and_Interaction/README.md) file on how to run this script.
#### Supplementary Table 3
Run the ["MI_Script.R"](Scripts/Main_and_Interaction/MI_Script.R) under the **Scripts** section. This will generate **Suppl_Tbl_3.csv** which is Supplementary Table 3 from our paper. Refer to the [README](Scripts/Main_and_Interaction/README.md) file on how to run this script.

### Supplementary Table 4
Run the ["Validation_Script.R"](Scripts/Validation/Validation_Script.R) under the **Script** section. This will generate the CSV file for **Supplementary Table 4**. Please take a look at the [README](Scripts/Validation/README.md) file for reference.













# Application on helminth-diabetes data

## Section 1: Scripts
This folder contains  R codes to run the various analyses that are mentioned in our paper.

### R Studio


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

### Supplementary Figure 1 - Heatmap
Run the ["Heatmaps_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/26bbae2344943f81b10cf8dfd8a9558a16a10e53/Application%20on%20helminth-diabetes%20data/Scripts/Heatmaps/Heatmaps_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/1aaa425683109655346223341a5b75c0e83b0a63/Application%20on%20helminth-diabetes%20data/Scripts/Heatmaps/Heatmaps_Script_Readme.md) file on how to run this script. This will generate **Suppl_Fig_2.png** in the folder set as the working directory. 

### Supplementary Figure 2a and 2b - Bayesian network reconstruction

Run the ["BN_reconstruction_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/eea560bc98f86b59c8138af5153c73550a0feb53/Application%20on%20helminth-diabetes%20data/Scripts/BN_reconstruction/BN_reconstruction_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. The [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/4c9780f3a700960deffab8ff0c01050fa9768f06/Application%20on%20helminth-diabetes%20data/Scripts/BN_reconstruction/BN_reconstruction_Script_Readme.md) file provided instructions to run the script and visualize the Bayesian network reconstructions corresponding to supplementary figures 2a and 2b.

### Supplementary Figures 3 and 4 
Run the ["MI_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/bc6704ea3221b41adb6e40a91735d8751d800b07/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate two folders **Supp_Figure_3** and **Supp_Figure_4** which contain **.jpg** figures of the interaction plots used to obtain **Supplementary Figure 3** and **Supplementary Figure 4** from the manuscript respectively. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/6772a411d79ad1e053ac20b7e2bb3286f29f3493/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script_Readme.md) file on how to run this script.

### Supplementary Figure 5 - Residual plots
Run the ["MI_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/bc6704ea3221b41adb6e40a91735d8751d800b07/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate two folders **Supp_Figure_3** and **Supp_Figure_4** which contain **.jpg** figures of the interaction plots used to obtain **Supplementary Figure 3** and **Supplementary Figure 4** from the manuscript respectively. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/6772a411d79ad1e053ac20b7e2bb3286f29f3493/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script_Readme.md) file on how to run this script.


### Supplementary figure 6 and 7

Run the ["Validation_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/ee65c741df4c442d3dd4999b45d1d904c8fde3b6/Application%20on%20helminth-diabetes%20data/Scripts/Validation/Validation_Script.R) under the [**Script**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate the plots for **Supplementary Figure 6** and **Supplementary Figure 7** in the folder **Supplementary Figures**. Please take a look at the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/321c1f03f647dfc5596a123997a580f5c261f8d2/Application%20on%20helminth-diabetes%20data/Scripts/Validation/Validation_Script_Readme.md) file on instructions to run the script.

Run the code in **Section 4** in the **Replication analysis** file to obtain supplementary figures 6 and 7.

 

## Section 3 - Supplementary tables

### Supplementary Table 2 (Before-Treatment analysis data) and Supplementary Table 3 (After-Treatment analysis data)

There are 12 columns in these tables. They are **Variables**, **Main effect p-values**, **Main effect adjusted p-values**, **Interaction effect p-values**, **Interaction effect adjusted p-values**, **b0 (Intercept coefficient)**, **b1 (Helminth term coefficient)**, **b2 (Diabetes term coefficient)**, **Relative explained variance (Helminth term)**, **Relative explained variance (Diabetes term)**, **Relative explained variance (Helminth:Diabetes interaction term)** and **Unexplained variance by the three terms**.

#### Supplementary Table 2 
Run the ["MI_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/bc6704ea3221b41adb6e40a91735d8751d800b07/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate **Suppl_Tbl_2.csv** which is Supplementary Table 2 from our paper. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/6772a411d79ad1e053ac20b7e2bb3286f29f3493/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script_Readme.md) file on how to run this script.
#### Supplementary Table 3
Run the ["MI_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/bc6704ea3221b41adb6e40a91735d8751d800b07/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate **Suppl_Tbl_3.csv** which is Supplementary Table 3 from our paper. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/6772a411d79ad1e053ac20b7e2bb3286f29f3493/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script_Readme.md) file on how to run this script.

### Supplementary Table 4
Run the ["Validation_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/ee65c741df4c442d3dd4999b45d1d904c8fde3b6/Application%20on%20helminth-diabetes%20data/Scripts/Validation/Validation_Script.R) under the [**Script**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate the CSV file for **Supplementary Table 4**. Please take a look at the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/321c1f03f647dfc5596a123997a580f5c261f8d2/Application%20on%20helminth-diabetes%20data/Scripts/Validation/Validation_Script_Readme.md) file for reference.













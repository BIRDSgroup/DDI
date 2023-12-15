# Instructions to get the Main Figures, Supplementary Figures, and Supplementary Tables
There are a total of 6 main figures, 7 supplementary figures, and 4 supplementary tables. 
This file will provide the necessary instructions to generate the figures, supplementary figures, and sheets given in the main text.

## Section 1 - Main Figures 
### Figure 1 - Methods Overview 

### Figure 2 - Data Overview
Run the ["Heatmaps_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/26bbae2344943f81b10cf8dfd8a9558a16a10e53/Application%20on%20helminth-diabetes%20data/Scripts/Heatmaps/Heatmaps_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/1aaa425683109655346223341a5b75c0e83b0a63/Application%20on%20helminth-diabetes%20data/Scripts/Heatmaps/Heatmaps_Script_Readme.md) file on how to run this script. This will generate **heatmap_fig2a.png** in the folder set as the working directory. 

### Figure 3 - Ternary plot
Two figures in the ternary plot:

1. Before treatment 
2. After treatment 

Run the ["MI_script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/bc6704ea3221b41adb6e40a91735d8751d800b07/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate both before and after-treatment ternary plots, which are for **Figure 3**. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/6772a411d79ad1e053ac20b7e2bb3286f29f3493/Application%20on%20helminth-diabetes%20data/Scripts/Main_and_Interaction/MI_Script_Readme.md) file on how to run this script.

### Figure 4 - Replication analysis

Run the ["Validation_script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/ee65c741df4c442d3dd4999b45d1d904c8fde3b6/Application%20on%20helminth-diabetes%20data/Scripts/Validation/Validation_Script.R) under the [**Script**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. This will generate the plots for **Figure 4**. Please take a look at the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/321c1f03f647dfc5596a123997a580f5c261f8d2/Application%20on%20helminth-diabetes%20data/Scripts/Validation/Validation_Script_Readme.md) file for reference.
Three figures in **Figure 4** (Check **Main_Figures** folder generated after running this script):

1. Replication.jpg
2. IFN-gamma.jpg
3. TNF-alpha.jpg
   
### Figure 5 - Source immune cells of some of the DDI markers

Run the ["Interpretation_script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/a4c626f93a107d3b809e3a307fc26208423cff7f/Application%20on%20helminth-diabetes%20data/Scripts/Interpretation/Interpretation_Script.R) under the [**Script**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. **Figure_5.jpg** is generated in the folder **Figure_5_and_6** after running the script. Please take a look at the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/990e3bbe91ee5311c880e2a50eebe2116d8ae170/Application%20on%20helminth-diabetes%20data/Scripts/Interpretation/Interpretation_Script_Readme.md) file for reference.

### Figure 6 - Reactome pathway heatmap 

Run the ["Interpretation_script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/a4c626f93a107d3b809e3a307fc26208423cff7f/Application%20on%20helminth-diabetes%20data/Scripts/Interpretation/Interpretation_Script.R) under the [**Script**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. **Figure_6.jpg** is generated in the folder **Figure_5_and_6** after running the script. Please take a look at the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/990e3bbe91ee5311c880e2a50eebe2116d8ae170/Application%20on%20helminth-diabetes%20data/Scripts/Interpretation/Interpretation_Script_Readme.md) file for reference.


## Section 2 - Supplementary Figures

### Supplementary Figure 1 - Heatmap
Run the ["Heatmaps_Script.R"](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/26bbae2344943f81b10cf8dfd8a9558a16a10e53/Application%20on%20helminth-diabetes%20data/Scripts/Heatmaps/Heatmaps_Script.R) under the [**Scripts**](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/tree/987bcd0ff4ecaae35eec570c552b21f13ad0b0b3/Application%20on%20helminth-diabetes%20data/Scripts) section. Refer to the [Readme](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/blob/1aaa425683109655346223341a5b75c0e83b0a63/Application%20on%20helminth-diabetes%20data/Scripts/Heatmaps/Heatmaps_Script_Readme.md) file on how to run this script. This will generate **Suppl_Fig_2.png** in the folder set as the working directory. 

### Supplementary Figure 2a and 2b - Bayesian network reconstruction


### Supplementary Figures 3 and 4 

Run the commom function **interp_s3()** before running the individual codes for S3 and S4.

```r
interp_s3 <- function(id,t){
  ip_name <- c("Adiponectin (pg/ml)", "IL-4 (pg/ml)", "G-CSF (pg/ml)", "IL-13 (pg/ml)", "IL-17A (pg/ml)")
  ip_name_ids <- c()
  for(i in 1:length(ip_name)){
    ip_name_ids <- c(ip_name_ids, which(colnames(id)==ip_name[i]))
  }
  
  ip_data <- id[,ip_name_ids]
  
  id$c <- factor(id$c, labels = c("No infection","Infection"))
  id$g <- factor(id$g, labels = c("No Diabetes","Diabetes"))
  
  for(i in 1:length(ip_name_ids)){
    interaction.plot(x.factor = id$c, trace.factor = id$g, response = ip_data[[i]], ylab = ip_name[i], xlab = "Helminth Status", trace.label = "Diabetes Status", col = c("Red","Blue"),main=t)
  }
  
}

```

#### Supplementary figure 3 - Interaction plots
Interaction plots for some of the DDI markers in the before-treatment samples like  **Adiponectin (pg/ml)**, **IL-4 (pg/ml)**, **G-CSF (pg/ml)**, **IL-13 (pg/ml)**, **IL-17A (pg/ml)**.
```r
bt_supp_3a <- interp_s3(int_data_1,t ="Before-treatment")
```

#### Supplementary figure 4 - Interaction plots
Interaction plots for some of the DDI markers in the after-treatment samples like  **Adiponectin (pg/ml)**, **IL-4 (pg/ml)**, **G-CSF (pg/ml)**, **IL-13 (pg/ml)**, **IL-17A (pg/ml)**.
```r
at_supp_3b <- interp_s3(int_data_3,,t ="After-treatment")
```


### Supplementary figure 5 - Residual plots
Run the function sup_5_fig() before implementing the code below which calls this function. The inputs to this function are the two outputs from **section 3** and **section 4.2** under **Main set of codes**.

```r
sup_5_fig <- function(id1, id2,bt_op, at_op){
  cmn_bt_at_main_var <- intersect(bt_op[[3]],at_op[[3]])
  some_at <- vector("numeric", length = nrow(id2))
  
  for(i in 1:nrow(id2)){
    some_at[i] <- (100 - sum(as.numeric(id2[[2]][i]),as.numeric(id2[[3]][i]),as.numeric(id2[[4]][i])))
  }
  
  
  some_bt <- vector("numeric", length = nrow(id1))
  
  for(i in 1:nrow(id1)){
    some_bt[i] <- (100 - sum(as.numeric(id1[[2]][i]),as.numeric(id1[[3]][i]),as.numeric(id1[[4]][i])))
  }
  
  some_bt_at_df <- data.frame(some_bt, some_at)
  
  some_ids <- which(id2[[1]] %in% cmn_bt_at_main_var)
  
  some_bt_at_df <- some_bt_at_df[some_ids,]
  
  vari_R <- c("Adipsin","Eosinophils","G-CSF","Glucagon","HbA1c","IFNg","IgG","IL-10","IL-12","IL-13","IL-17A","IL-17F","IL-1b","IL-2","IL-4","IL-5","IL-6","IL-8","Leptin","Lymphocytes","MCHC","MCP-1","MIP-1b","Monocytes","Neutrophils","RBG","Resistin","TGF-b","TNF-a","Visfatin")
  
  some_bt_at_df[,3] <- vari_R
  
  
  ggplot2::ggplot(data=some_bt_at_df, ggplot2::aes(x=some_bt,y=some_at))+ggrepel::geom_text_repel(label=vari_R, size=3)+ggplot2::theme(legend.text = element_text(size = 3))+xlab("Before Treatment Residuals")+ylab("After Treatment Residuals")+ggplot2::ylim(0,100)+ggplot2::xlim(0,100)
  
  
}


sup_5_fig(rela_df_BT, rela_df_AT,BT_main_inter,AT_main_inter)
```

### Supplementary figure 6 and 7

Run the code in **Section 4** in the **Replication analysis** file to obtain supplementary figures 6 and 7.

 

## Section 3 - Supplementary tables

### Supplementary Table 2 (Before-Treatment analysis data) and Supplementary Table 3 (After-Treatment analysis data)

There are 12 columns in these tables. They are **Features**, **Main effect p values**, **Main effect adjusted p values**, **Interaction effect p values**, **Interaction effect adjusted p values**, **b0 (Intercept coefficient)**, **b1 (Helminth term coefficient)**, **b2 (Diabetes term coefficient)**, **Relative explained variance (Helminth term)**, **Relative explained variance (Diabetes term)**, **Relative explained variance (Helminth:Diabetes interaction term)** and **Unexplained variance**.

#### Code to get the last column in both supplementary tables 2 and 3
Input to this function is outputs from **Section 4.2**  (*rela_df_BT* and *rela_df_AT*) in **Main and Interaction effect analysis**.
Output of this function is a data frame with columns as features, unexplained variance (other than the helminth, diabetes and the interaction term) in before-treatment and after-treatment cases. 
```r
unexplained_var_sup_sheet <- function(X,Y){
  some_at <- vector("numeric", length = nrow(Y))
  for(i in 1:nrow(Y)){
    some_at[i] <- (100 - sum(as.numeric(Y[[2]][i]),as.numeric(Y[[3]][i]),as.numeric(Y[[4]][i])))
  }
  
  
  some_bt <- vector("numeric", length = nrow(X))
  
  for(i in 1:nrow(X)){
    some_bt[i] <- (100 - sum(as.numeric(X[[2]][i]),as.numeric(X[[3]][i]),as.numeric(X[[4]][i])))
  }
  
  NEW_Df <- data.frame(X$Features,some_bt,some_at)
  colnames(NEW_Df) <- c("Features","Unexplained_BT","Unexplained_AT") 
return(NEW_Df)}

# Call the function
Unexp_Var_data <- unexplained_var_sup_sheet(rela_df_BT,rela_df_AT) 

```

#### Supplementary Table 2 

1. **Main effect p values**, **Main effect adjusted p values**, **Interaction effect p values** and **Interaction effect adjusted p values** are output from **Section 3.1** in **Main and Interaction effect analysis**
2. The values for columns **b0 (Intercept coefficient)**, **b1 (Helminth term coefficient)**, **b2 (Diabetes term coefficient)** are stored as output in a csv file (*Coeff_terms_data.csv*) in the working directory given in **Section 3.1**
3. the values for columns **Relative explained variance (Helminth term)**, **Relative explained variance (Diabetes term)**, **Relative explained variance (Helminth:Diabetes interaction term)** are outout from **Section 4.2**
4. Run the above code. "Unexplained_BT" in the output data frame of this function is the last column of supplementary table 2. 

#### Supplementary Table 3

1. **Main effect p values**, **Main effect adjusted p values**, **Interaction effect p values** and **Interaction effect adjusted p values** are output from **Section 3.2** in **Main and Interaction effect analysis**
2. The values for  **b0 (Intercept coefficient)**, **b1 (Helminth term coefficient)**, **b2 (Diabetes term coefficient)** are stored as output in a csv file (*Coeff_terms_data.csv*) in the working directory given in **Section 3.2**
3. the values for columns **Relative explained variance (Helminth term)**, **Relative explained variance (Diabetes term)**, **Relative explained variance (Helminth:Diabetes interaction term)** are outout from **Section 4.2**
4. Run the above code. "Unexplained_AT" in the output data frame of this function is the last column of supplementary table 3. 

### Supplementary Table 4
Run the code in **Section 5** in the **Replication analysis** file, to obtain a text file containing the contents in the supplementary table 4.












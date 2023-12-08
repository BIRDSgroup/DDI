# Instructions to get the main figures and supplementary figures and supplementary tables
There a total of 4 main figures, 7 supplementary figures, and 4 supplementary tables. 
This file will provide the necessary instructions to generate the figures, supplementary figures, and sheets given in the main text.

## Section 1 - Main Figures 
### Figure 1 - Methods Overview

### Figure 2 - Data Overview
Two figures are under this section:

1. Heatmap
2. Bayesian network

#### Heatmap (2A)
This function will output the heatmap figure 2a in the main text.
The input to this function is the working directory where the data/files necessary to create this heatmap is stored. The output figure will be generated in the same working directory.

```r

heatmap_main_fig <- function(wd_hp){
  library(DMwR2)
  for(file in c('Hel+DM+', 'Hel+DM+_Post-T', 'Hel-DM+', 'Hel+DM-_45v2', 'Hel-DM-', 'Hel+DM-PostT_45v2')){
    print(file)
    data <- read.table(paste(wd_hp,file, ".txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
    data <- data[ , order(names(data))]
    # Set all columns as numeric
    cols = c(1:ncol(data));  
    data[,cols] = apply(data[,cols], 2, function(x) as.numeric(x));
    # KNN Imputation
    if(file == 'Hel+DM+'){
      knnOutput <- knnImputation(data)
    }else if(file == 'Hel+DM+_Post-T'){
      knnOutputPT <- knnImputation(data)
    }else if(file == 'Hel-DM+'){
      knnOutputDM <- knnImputation(data)
    }else if(file == 'Hel+DM-_45v2'){
      knnOutputHel <- knnImputation(data)
    }else if(file == 'Hel-DM-'){
      knnOutputC <- knnImputation(data)
    }else if(file == 'Hel+DM-PostT_45v2'){
      knnOutputHelPT <- knnImputation(data)
    }
  }
  knnOutput_together <- rbind(knnOutputDM, knnOutput, knnOutputPT, knnOutputC, knnOutputHel, knnOutputHelPT)
  together_year <- read.table(paste(wd_hp, "Hel_DM_together_44_res_year_v1.txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
  knnOutput_together$Year <- together_year$Year
  features <- colnames(knnOutput_together)
  features <- features[-c(3,4,5,7,8,45,51)]
  cols <- c(1:ncol(knnOutput_together))
  cols <- cols[-c(3,4,5,7,8,45,51)]
  
  knnOutput_together_res <- c()
  for(i in cols){
    obj <- lm(knnOutput_together[,i]~as.factor(knnOutput_together$Year)+knnOutput_together$`Creatinine (mg/dl)`+knnOutput_together$Age+knnOutput_together$`ALT (U/L)`+knnOutput_together$`AST (U/L)`+knnOutput_together$BMI+as.factor(knnOutput_together$Sex))
    knnOutput_together_res <- cbind(knnOutput_together_res, resid(obj))
  }
  features <- c(features, 'Year', 'Age', 'BMI', 'ALT (U/L)', 'AST (U/L)', 'Creatinine (mg/dl)', 'Sex')
  knnOutput_together_res <- cbind(knnOutput_together_res, knnOutput_together$Year, knnOutput_together$Age, knnOutput_together$BMI, knnOutput_together$`ALT (U/L)`, knnOutput_together$`AST (U/L)`, knnOutput_together$`Creatinine (mg/dl)`, knnOutput_together$Sex)
  colnames(knnOutput_together_res) <- features
  write.table(knnOutput_together_res, paste(wd_hp, "Hel_DM_togetherYearAdj_44_res_year_v1.txt", sep = ""), col.names = TRUE, sep = "\t", quote = FALSE, row.names = FALSE)
  
  
  combined <- as.data.frame(t(knnOutput_together_res))
  colnames(combined)[1:58] <- paste(colnames(combined)[1:58], "DM+Ctl", sep="")
  colnames(combined)[59:118] <- paste(colnames(combined)[59:118], "DM+Inf_PreT", sep="")
  colnames(combined)[119:178] <- paste(colnames(combined)[119:178], "DM+Inf_PostT", sep="")
  colnames(combined)[179:238] <- paste(colnames(combined)[179:238], "DM-Ctl", sep="")
  colnames(combined)[239:282] <- paste(colnames(combined)[239:282], "DM-Inf_PreT", sep="")
  colnames(combined)[283:326] <- paste(colnames(combined)[283:326], "DM-Inf_PostT", sep="")
  library(pheatmap)
  library(RColorBrewer)
  library(Pigengene)
  library(seriation)
  
  my_colour = list(
    #samples=c('DMp+Ctl'="red", 'DM+Inf_PreT'="blue", 'DM+Inf_PostT'="green", 'DM-Ctl'="orange", 'DM-Inf_PreT'="pink", 'DMm-Inf_PostT'="black"),
    samples=c('DM+Ctl'="#1B9E77", 'DM+Inf_PreT'="#D95F02", 'DM+Inf_PostT'="#7570B3", 'DM-Ctl'="#E7298A", 'DM-Inf_PreT'="#66A61E", 'DM-Inf_PostT'="#E6AB02"),
    #samples=brewer.pal(6,"Dark2"),
    #year=c('2013'="red", '2014'="blue", '2015'="green", '2016'="orange"),
    year=c('2013'="#1B9E77", '2014'="#D95F02", '2015'="#7570B3", '2016'="#E7298A"),
    category=c('Adipocytokines'="#A6CEE3", 'Cell count  frequency'="#1F78B4", 'Other Cytokines'="#B2DF8A", 'Pancreatic hormones'="#33A02C", 'Biochemical parameters'="#FB9A99", 'Th1- cytokines'="#E31A1C", 'Th2-cytokines'="#FDBF6F", 'Th17-cytokines'="#FF7F00", 'Anthropometric parameters'="#CAB2D6", 'Batch'="#6A3D9A")
    #category=brewer.pal(10,"Paired")
  )
  metadata <- data.frame(row.names=colnames(combined),samples=c(rep("DM+Ctl",58),rep("DM+Inf_PreT",60),rep("DM+Inf_PostT",60),rep("DM-Ctl",60),rep("DM-Inf_PreT",44),rep("DM-Inf_PostT",44)), year=as.data.frame(t(combined))$Year)
  rownames(combined)
  meta <- data.frame(row.names=rownames(combined),category=c('Adipocytokines', 'Adipocytokines', 'Cell count  frequency', 'Cell count  frequency', 'Other Cytokines', 'Pancreatic hormones', 'Other Cytokines', 'Biochemical parameters', 'Biochemical parameters', 'Biochemical parameters', 'Th1- cytokines', 'Biochemical parameters', 'Th2-cytokines', 'Th1- cytokines', 'Th2-cytokines', 'Th17-cytokines', 'Th17-cytokines', 'Th17-cytokines', 'Th1- cytokines', 'Th17-cytokines', 'Th2-cytokines', 'Th2-cytokines', 'Th2-cytokines', 'Other Cytokines', 'Pancreatic hormones', 'Adipocytokines', 'Cell count  frequency', 'Biochemical parameters', 'Biochemical parameters', 'Other Cytokines', 'Biochemical parameters', 'Other Cytokines', 'Cell count  frequency', 'Cell count  frequency', 'Biochemical parameters', 'Cell count  frequency', 'Biochemical parameters', 'Biochemical parameters', 'Adipocytokines', 'Other Cytokines', 'Th1- cytokines', 'Biochemical parameters', 'Adipocytokines', 'Cell count  frequency', 'Anthropometric parameters', 'Anthropometric parameters', 'Cell count  frequency', 'Cell count  frequency', 'Biochemical parameters', 'Anthropometric parameters', 'Batch'
  ))
  callback <- function(hc, combined){
    # Recalculate distances for reorder method
    dists <- dist(combined)
    
    # Perform reordering according to OLO method
    hclust_olo <- reorder(x=hc, dist=dists, method = "OLO")
    return(hclust_olo)
  }
  hclustfunc <- function(x) {    
    hclust(dist(x))
  }
  hc <- hclustfunc(combined)
  
  ph <- pheatmap::pheatmap(t(scale(t(combined))), clustering_callback = callback, fontsize = 3, treeheight_row = 30, treeheight_col = 30, color = colorRampPalette(rev(brewer.pal(n = 9, name = "RdBu")))(11), breaks = c(-12,-10,-8,-6,-4,-2,0,1,2,3,4,5,6), border_color = NA, cellwidth = 1, cellheight = 3, show_colnames = F, annotation_names_col = FALSE, filename =  paste(wd_hp, "heatmap_fig2a.png", sep = ""),fontsize_row = 3, cluster_rows= T, cluster_cols = T, clustering_distance_cols = "euclidean", clustering_distance_rows = "euclidean", annotation_col=metadata, annotation_row=meta, annotation_colors = my_colour)
  
  
  
}


# Main command
wd_hp <- c("D:/work/DM_Hel/Heatmap/data/checking/")
heatmap_main_fig(wd_hp)


```





### Figure 3 - Ternary plot
Two figures in the ternary plot:

1. Before treatment 
2. After treatment 

Run the "MI_script.R" under the **Scripts for Replication** section. This will generate both before and after-treatment ternary plots, which are for **Figure 3**.

### Figure 4 - Replication analysis

Run the "Validation_script.R" under the **Scripts for Replication** section. This will generate the plots for **Figure 4**.
Three figures in **Figure 4** (Check **Main_Figures** folder generated after running this script):

1. Replication.jpg
2. IFN-gamma.jpg
3. TNF-alpha.jpg
   
### Figure 5 - Source immune cells of some of the DDI markers

Run the "Interpretation_script.R" under the **Scripts for Replication** section. **Figure_5.jpg** is generated in the folder **Figure_5_and_6**.

### Figure 6 - Reactome pathway heatmap 

Run the "Interpretation_script.R" under the **Scripts for Replication** section. **Figure_6.jpg** is generated in the folder **Figure_5_and_6**.


## Section 2 - Supplementary Figures

### Supplementary Figure 1 - Heatmap
This function will output the heatmap supplementary figure 1 provided in the main text.
The input to this function is the working directory where the data/files necessary to create this heatmap are stored (same working directory as main figure 2a).
```r
supp_fig_2 <- function(wd_hp){
  library(lubridate)
  # Day based
  together_day <- read.table(paste(wd_hp, "Hel_DM_together_44_res_date_v1.txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
  Year <- together_day$Year
  together_day <- read.table(paste(wd_hp,"Hel_DM_togetherYearAdj_44_res_year_v1.txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
  together_day$Year <- NULL
  samples <- c(rep("DM+Ctl",58),rep("DM+Inf_PreT",60),rep("DM+Inf_PostT",60),rep("DM-Ctl",60),rep("DM-Inf_PreT",44),rep("DM-Inf_PostT",44))
  together_day <- cbind(together_day, samples)
  together_day <- cbind(together_day, Year)
  together_day$Year <- lubridate::dmy(together_day$Year)
  together_date <- dplyr::arrange(together_day, Year)
  days <- c(17)
  for(i in 2:nrow(together_date)){
    days <- c(days, difftime(together_date[i,"Year"], together_date[1,"Year"], units = "days"))
  }
  years <- substring(together_date$Year,1,4)
  together_date$Year <- NULL
  
  combined <- as.data.frame(t(together_date))
  combined <- combined[c(-51),]
  
  
  library(pheatmap)
  library(RColorBrewer)
  library(Pigengene)
  library(seriation)
  
  col12 <- brewer.pal(12,"Paired")
  
  j <- 1
  Day <- c()
  for(i in unique(days)){
    if(j==13){
      j <- 1
    }
    Day <- c(Day, col12[j])
    j <- j+1
    
  }
  names(Day) <- unique(days)
  Day
  length(Day)
  class(Day)
  my_colour = list(
    #samples=c('DMp+Ctl'="red", 'DM+Inf_PreT'="blue", 'DM+Inf_PostT'="green", 'DM-Ctl'="orange", 'DM-Inf_PreT'="pink", 'DMm-Inf_PostT'="black"),
    Samples=c('DM+Ctl'="#1B9E77", 'DM+Inf_PreT'="#D95F02", 'DM+Inf_PostT'="#7570B3", 'DM-Ctl'="#E7298A", 'DM-Inf_PreT'="#66A61E", 'DM-Inf_PostT'="#E6AB02"),
    #samples=brewer.pal(6,"Dark2"),
    #year=c('2013'="red", '2014'="blue", '2015'="green", '2016'="orange"),
    Day=Day,
    #Day=colorRampPalette(brewer.pal(12,"Paired"))(171),
    Year=c('2013'="#1B9E77", '2014'="#D95F02", '2015'="#7570B3", '2016'="#E7298A"),
    Category=c('Adipocytokines'="#A6CEE3", 'Cell count  frequency'="#1F78B4", 'Other Cytokines'="#B2DF8A", 'Pancreatic hormones'="#33A02C", 'Biochemical parameters'="#FB9A99", 'Th1- cytokines'="#E31A1C", 'Th2-cytokines'="#FDBF6F", 'Th17-cytokines'="#FF7F00", 'Anthropometric parameters'="#CAB2D6", 'Batch'="#6A3D9A")
    #category=brewer.pal(10,"Paired")
  )
  
  metadata <- data.frame(row.names=colnames(combined),Samples=together_date$samples, Day=as.factor(days), Year=years)
  meta <- data.frame(row.names=rownames(combined),Category=c('Adipocytokines', 'Adipocytokines', 'Cell count  frequency', 'Cell count  frequency', 'Other Cytokines', 'Pancreatic hormones', 'Other Cytokines', 'Biochemical parameters', 'Biochemical parameters', 'Biochemical parameters', 'Th1- cytokines', 'Biochemical parameters', 'Th2-cytokines', 'Th1- cytokines', 'Th2-cytokines', 'Th17-cytokines', 'Th17-cytokines', 'Th17-cytokines', 'Th1- cytokines', 'Th17-cytokines', 'Th2-cytokines', 'Th2-cytokines', 'Th2-cytokines', 'Other Cytokines', 'Pancreatic hormones', 'Adipocytokines', 'Cell count  frequency', 'Biochemical parameters', 'Biochemical parameters', 'Other Cytokines', 'Biochemical parameters', 'Other Cytokines', 'Cell count  frequency', 'Cell count  frequency', 'Biochemical parameters', 'Cell count  frequency', 'Biochemical parameters', 'Biochemical parameters', 'Adipocytokines', 'Other Cytokines', 'Th1- cytokines', 'Biochemical parameters', 'Adipocytokines', 'Cell count  frequency', 'Anthropometric parameters', 'Anthropometric parameters', 'Cell count  frequency', 'Cell count  frequency', 'Biochemical parameters', 'Anthropometric parameters'))
  
  for(i in c(1:ncol(combined))) {
    combined[,i] <- as.numeric(as.character(combined[,i]))
  }
  library(ComplexHeatmap)
  library(circlize)
  col_fun <- colorRamp2(c(-12,-10,-8,-6,-4,-2,0,1,2,3,4,5), colorRampPalette(rev(brewer.pal(n = 9, name = "RdBu")))(12))
  ha = HeatmapAnnotation(Samples=together_date$samples, Day=as.factor(days), Year=years, 
                         show_legend = c(TRUE, FALSE, TRUE), col = list(Samples = 
                                                                          c('DM+Ctl'="#1B9E77", 'DM+Inf_PreT'="#D95F02", 'DM+Inf_PostT'=
                                                                              "#7570B3", 'DM-Ctl'="#E7298A", 'DM-Inf_PreT'="#66A61E", 
                                                                            'DM-Inf_PostT'="#E6AB02"), Year = c('2013'="#1B9E77", '2014'="#D95F02", '2015'="#7570B3", '2016'="#E7298A")), 
                         annotation_legend_param = list(
                           Samples = list(
                             title = "Samples",
                             at = c('DM+Ctl', 'DM+Inf_PreT', 'DM+Inf_PostT',
                                    'DM-Ctl', 'DM-Inf_PreT', 'DM-Inf_PostT'),
                             labels = c('DM+Ctl', 'DM+Inf_PreT', 'DM+Inf_PostT',
                                        'DM-Ctl', 'DM-Inf_PreT', 'DM-Inf_PostT')
                           ),
                           Year = list(
                             title = "Year",
                             at = c(2013, 2014, 2015, 2016),
                             labels = c('2013', '2014', '2015', '2016')
                           )
                         ))
  ha2 = rowAnnotation(Category=c('Adipocytokines', 'Adipocytokines', 'Cell count  frequency', 'Cell count  frequency', 'Other Cytokines', 'Pancreatic hormones', 'Other Cytokines', 'Biochemical parameters', 'Biochemical parameters', 'Biochemical parameters', 'Th1- cytokines', 'Biochemical parameters', 'Th2-cytokines', 'Th1- cytokines', 'Th2-cytokines', 'Th17-cytokines', 'Th17-cytokines', 'Th17-cytokines', 'Th1- cytokines', 'Th17-cytokines', 'Th2-cytokines', 'Th2-cytokines', 'Th2-cytokines', 'Other Cytokines', 'Pancreatic hormones', 'Adipocytokines', 'Cell count  frequency', 'Biochemical parameters', 'Biochemical parameters', 'Other Cytokines', 'Biochemical parameters', 'Other Cytokines', 'Cell count  frequency', 'Cell count  frequency', 'Biochemical parameters', 'Cell count  frequency', 'Biochemical parameters', 'Biochemical parameters', 'Adipocytokines', 'Other Cytokines', 'Th1- cytokines', 'Biochemical parameters', 'Adipocytokines', 'Cell count  frequency', 'Anthropometric parameters', 'Anthropometric parameters', 'Cell count  frequency', 'Cell count  frequency', 'Biochemical parameters', 'Anthropometric parameters'), 
                      col = list(Category=c('Adipocytokines'="#A6CEE3", 'Cell count  frequency'="#1F78B4", 'Other Cytokines'="#B2DF8A", 'Pancreatic hormones'="#33A02C", 'Biochemical parameters'="#FB9A99", 'Th1- cytokines'="#E31A1C", 'Th2-cytokines'="#FDBF6F", 'Th17-cytokines'="#FF7F00", 'Anthropometric parameters'="#CAB2D6")
                      ), 
                      annotation_legend_param = list(
                        Category = list(
                          title = "Category",
                          at = c('Adipocytokines', 'Cell count  frequency', 'Other Cytokines', 'Pancreatic hormones', 'Biochemical parameters', 'Th1- cytokines', 'Th2-cytokines', 'Th17-cytokines', 'Anthropometric parameters'),
                          labels = c('Adipocytokines', 'Cell count  frequency', 'Other Cytokines', 'Pancreatic hormones', 'Biochemical parameters', 'Th1- cytokines', 'Th2-cytokines', 'Th17-cytokines', 'Anthropometric parameters')
                        )
                      ))
  
  ht_opt(legend_labels_gp = gpar(fontsize = 8), legend_title_gp = gpar(fontsize = 8, fontface = "bold"))
  pph_s <- Heatmap(t(scale(t(combined))), row_names_gp = gpar(fontsize = 8), col = col_fun, 
                   cluster_columns = FALSE,clustering_distance_rows = "euclidean", 
                   show_column_names = FALSE, top_annotation = ha, left_annotation = ha2,
                   heatmap_legend_param = list(title = "Variables"))
  pph_s
  
  
}

# Main command
wd_hp <- c("D:/work/DM_Hel/Heatmap/data/checking/")
supp_fig_2(wd_hp)

```

### Supplementary figure 2 

### Supplementary figure 3 and 4 

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











# Replication analysis

This file contains the necessary code to perform the replication analysis.

## Section 1 - Get the validation data
Run the function **Get_val_data()** before implementing the main command to get the validation data. The input for this function is the working directory where the validation data is downloaded. 
The output of this function is a list that stores the three groups of data, which later is split into the respective groups **Helminths infected and Diabetes +ve group**, **Helminths no-infection and Diabetes +ve group**, and **Helminths no-infection and Diabetes -ve group**.


```r
Get_val_data <- function(wd){
  library(readxl)
  setwd(wd)
  
  ## hel_p_dm_p (infected samples)
  p_p <- read_excel("help_dmp_val.xlsx", col_names =TRUE)
  #View(p_p)
  g <-seq(1,1,length.out = nrow(p_p))
  p_p <- cbind(p_p,g)
  h <-seq(1,1,length.out = nrow(p_p))
  p_p <- cbind(p_p,h)
  
  ## helm_dmp (hel - and dm +)
  m_p <- read_excel("helm_dmp_val.xlsx", col_names =TRUE)
  #View(m_p)
  g <-seq(1,1,length.out = nrow(m_p))
  m_p <- cbind(m_p,g)
  h <-seq(0,0,length.out = nrow(m_p))
  m_p <- cbind(m_p,h)
  
  ## helm_dmm (hel - and dm -)
  m_m <- read_excel("helm_dmm_val.xlsx", col_names =TRUE)
  #View(m_m)
  g <-seq(0,0,length.out = nrow(m_m))
  m_m <- cbind(m_m,g)
  h <-seq(0,0,length.out = nrow(m_m))
  m_m <- cbind(m_m,h)
  
  new_list <- list(p_p,m_p,m_m)
  
  base::return(new_list)}


wr_dr <- c("/data/nilesh/validation/validation_data/with_igg")

overall_list <- Get_val_data(wr_dr)
# Split the data into respective groups

# Helminths infected and Diabetes +ve group (pp)
val_data_1 <- overall_list[[1]]

# Helminths no-infection and Diabetes +ve group (mp)
val_data_2 <- overall_list[[2]]

# Helminths no-infection and Diabetes -ve group (mm)
val_data_3 <- overall_list[[3]]


```


## Section 2 - Get the discovery data 
Run this section of the code to load the discovery cohort. 
This is the same as **section 1** in **Main and Interaction effect analysis** file.

Note: If the discovery data is already loaded from the **Main and Interaction effect analysis** file, this step can be ignored.
```r
library(DMwR2)
for(file in c('Hel+DM+', 'Hel+DM+_Post-T', 'Hel-DM+', 'Hel+DM-', 'Hel-DM-', 'Hel+DM-_Post-T')){
  print(file)
  data <- read.table(paste("/data/nilesh/PCA/raw/data/",file, ".txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
  data <- data[ , order(names(data))]
  # Set all columns as numeric
  cols = c(1:ncol(data));  
  data[,cols] = apply(data[,cols], 2, function(x) as.numeric(x));
  # KNN Imputation
  if(file == 'Hel+DM+'){
    dm_p_pre <- knnImputation(data)
  }else if(file == 'Hel+DM+_Post-T'){
    dm_p_post <- knnImputation(data)
  }else if(file == 'Hel-DM+'){
    dm_p_con <- knnImputation(data)
  }else if(file == 'Hel+DM-'){
    dm_m_pre <- knnImputation(data)
  }else if(file == 'Hel-DM-'){
    dm_m_con <- knnImputation(data)
  }else if(file == 'Hel+DM-_Post-T'){
    dm_m_post <- knnImputation(data)
  }
}


```

## Section 3 - Perform replication analysis 

Run the function **Validation_res_plots()** before calling it in the main command. The inputs to this function are the three validation cohorts and their corresponding counterparts in the discovery cohort.
The output from this function is a list containing the plots under the results section for the replication analysis.
The final list in the output is a dataframe containing the p values for the features in both validation and discovery cohorts that were computed. This is stored as **pvals_val_dc** in the main command, which will be used as one of the inputs in the next section.

```r
Validation_res_plots <- function(d1_val, d2_val, d3_val, d1_dc, d2_dc, d3_dc){
  
  library(dplyr)
  library(rstatix)
  library(ggplot2)
  
  #### Step 1 - Perform pairwise DE analysis for Validation data
  
  ##### Step 1a - Data Pre-processing (getting the pairwise data)
  
  pw_data_fnc <- function(d_1, d_2, d_3){
    ### + + vs  - -
    pp_mm <- rbind(d_1, d_3)
    #View(pp_mm)
    pp_mm$Sex <- as.factor(pp_mm$Sex)
    levels(pp_mm$Sex) <- c(1,0)
    pp_mm$g <- as.factor(pp_mm$g)
    pp_mm$h <- as.factor(pp_mm$h)
    
    ### - + vs  - -
    mp_mm <- rbind(d_2, d_3)
    #View(mp_mm)
    mp_mm$Sex <- as.factor(mp_mm$Sex)
    levels(mp_mm$Sex) <- c(1,0)
    mp_mm$g <- as.factor(mp_mm$g)
    #mp_mm$h <- as.factor(mp_mm$h)
    
    ### - + vs  + +
    mp_pp <- rbind(d_2, d_1)
    #View(mp_pp)
    mp_pp$Sex <- as.factor(mp_pp$Sex)
    levels(mp_pp$Sex) <- c(1,0)
    #mp_pp$g <- as.factor(mp_pp$g)
    mp_pp$h <- as.factor(mp_pp$h)
    
    new_list_1 <- list(pp_mm, mp_mm, mp_pp)
    
    base::return(new_list_1)}
  
  ##### Step 1b - Performing DE
  
  De_pw_fnc <- function(ip_d){
    cvn <- c("Age", "ALT (U/L)", "AST (U/L)","Sex", "Creatinine (mg/dl)","g","h")
    cvi <- c()
    #overall_p <- function(my_model) {
    # f <- summary(my_model)$fstatistic
    #p <- pf(f[1],f[2],f[3],lower.tail=F)
    #attributes(p) <- NULL
    #return(p)
    #}
    for(i in 1:length(cvn))
    {
      cvi <- c(cvi, which(colnames(ip_d)==cvn[i]))
    }
    
    meidf <- ip_d[,-cvi]
    
    pval <- vector("numeric", length = ncol(meidf))
    feature_names <- colnames(meidf)
    for (i in 1:ncol(meidf) ) {
      f1 <- lm(meidf[[i]]~ Age+Sex+`Creatinine (mg/dl)`+`ALT (U/L)`+`AST (U/L)`+g+h, data = ip_d)
      x <- summary(f1)
      pval[i] <- x$coefficients[7,4]
    }  
    
    padj <- p.adjust(pval,method = "BH")
    pw_p_df <- data.frame(feature_names,pval,padj)
    return(pw_p_df)}
  
  
  
  #### Step 2 - Perform pairwise DE analysis for Validation data
  
  # 2a Preprocess
  
  prepro_disco <- function(d_1, d_2, d_3){
    #View(dm_m_con) # --
    mm <- d_1
    g <-seq(0,0,length.out = nrow(d_1))
    mm <- cbind(mm,g)
    h <-seq(0,0,length.out = nrow(d_1))
    mm <- cbind(mm,h)
    
    ## ++
    #View(dm_p_pre)
    pp <- d_2
    g <-seq(1,1,length.out = nrow(d_2))
    pp <- cbind(pp,g)
    h <-seq(1,1,length.out = nrow(d_2))
    pp <- cbind(pp,h)
    # -+
    #View(dm_p_con)
    mp <- d_3
    g <-seq(1,1,length.out = nrow(d_3))
    mp <- cbind(mp,g)
    h <-seq(0,0,length.out = nrow(d_3))
    mp <- cbind(mp,h)
    
    ### pairwise DE
    ### - + vs  - - (d_3 and d_1)
    dc_mp_mm <- rbind(mp, mm)
    #View(dc_mp_mm)
    dc_mp_mm$Sex <- as.factor(dc_mp_mm$Sex)
    levels(dc_mp_mm$Sex) <- c(1,0)
    dc_mp_mm$g <- as.factor(dc_mp_mm$g)
    #dc_mp_mm$h <- as.factor(dc_mp_mm$h)
    
    ### - + vs  ++ (d_3 and d_2)
    dc_mp_pp <- rbind(mp, pp)
    #View(dc_mp_pp)
    dc_mp_pp$Sex <- as.factor(dc_mp_pp$Sex)
    levels(dc_mp_pp$Sex) <- c(1,0)
    #dc_mp_pp$g <- as.factor(dc_mp_pp$g)
    dc_mp_pp$h <- as.factor(dc_mp_pp$h)
    
    ### - - vs  ++
    dc_mm_pp <- rbind(mm, pp)
    #View(dc_mm_pp)
    dc_mm_pp$Sex <- as.factor(dc_mm_pp$Sex)
    levels(dc_mm_pp$Sex) <- c(1,0)
    dc_mm_pp$g <- as.factor(dc_mm_pp$g)
    #dc_mm_pp$h <- as.factor(dc_mm_pp$h)
    
    new_list_2 <- list(dc_mp_mm,dc_mp_pp,dc_mm_pp)
    
    return(new_list_2)}
  
  ##### Step 2b - Performing DE for pairwise discovery cohort 
  
  
  De_pw_fnc_DC <- function(ip_d1){
    
    #dc_ids <- which(colnames(ip_d1) %in% colnames(ip_d2)) # ip_d1 is discovery data and ip_d2 is validation data
    #ip_d1 <- ip_d1[,dc_ids]
    
    cvn <- c("Age", "ALT (U/L)", "AST (U/L)","Sex", "Creatinine (mg/dl)","g","h")
    cvi <- c()
    
    for(i in 1:length(cvn))
    {
      cvi <- c(cvi, which(colnames(ip_d1)==cvn[i]))
    }
    
    meidf <- ip_d1[,-cvi]
    
    
    
    pval <- vector("numeric", length = ncol(meidf))
    feature_names <- colnames(meidf)
    for (i in 1:ncol(meidf) ) {
      f1 <- lm(meidf[[i]]~ Age+Sex+`Creatinine (mg/dl)`+`ALT (U/L)`+`AST (U/L)`+g+h, data = ip_d1)
      x <- summary(f1)
      pval[i] <- x$coefficients[7,4]
    }  
    
    padj <- p.adjust(pval,method = "BH")
    pw_p_df <- data.frame(feature_names,pval,padj)
    return(pw_p_df)}
  
  
  
  ############################################  Main set of commands within the function
  
  ##### Step 1a - Data Pre-processing (getting the pairwise data) for the validation data 
  overall_preprocess <- pw_data_fnc(d1_val,d2_val,d3_val)
  val_mm_pp<- overall_preprocess[[1]]
  val_mp_mm <- overall_preprocess[[2]]
  val_mp_pp <- overall_preprocess[[3]]
  
  ##### Step 1b - Performing DE for the validation data
  val_mm_pp_p_df <- De_pw_fnc(val_mm_pp)
  val_mp_mm_p_df <- De_pw_fnc(val_mp_mm)
  val_mp_pp_p_df <- De_pw_fnc(val_mp_pp)
  
  ##### Step 2a - Data Pre-processing (getting the pairwise data) for the discovery data 
  dc_prepro <- prepro_disco(d1_dc,d2_dc, d3_dc)
  dc_mp_mm <- dc_prepro[[1]]
  dc_mp_pp <- dc_prepro[[2]]
  dc_mm_pp <- dc_prepro[[3]]
  
  ##### Step 2b - Performing DE for the discovery data
  dc_mp_mm_p_df <- De_pw_fnc_DC(dc_mp_mm)
  dc_mp_pp_p_df <- De_pw_fnc_DC(dc_mp_pp)
  dc_mm_pp_p_df <- De_pw_fnc_DC(dc_mm_pp)
  
  #### To ensure same set of features are in discovery cohort as well
  cmm_fts <- intersect(val_mm_pp_p_df$feature_names, dc_mm_pp_p_df$feature_names)
  
  ids <- which(dc_mm_pp_p_df$feature_names %in% cmm_fts)
  
  dc_mm_pp_p_df <- dc_mm_pp_p_df[ids,]
  dc_mp_mm_p_df <- dc_mp_mm_p_df[ids,]
  dc_mp_pp_p_df <- dc_mp_pp_p_df[ids,]
  
  
  
  ##### Step 3 - Getting the data ready for boxplots and final results
  val_mp_mm_p_df <- val_mp_mm_p_df[order(match(val_mp_mm_p_df[,1],dc_mp_mm_p_df[,1])),]
  val_mp_pp_p_df <- val_mp_pp_p_df[order(match(val_mp_pp_p_df[,1],dc_mp_pp_p_df[,1])),]
  val_mm_pp_p_df <- val_mm_pp_p_df[order(match(val_mm_pp_p_df[,1],dc_mm_pp_p_df[,1])),]
  
  val_dc_adj_p <- data.frame(dc_mp_mm_p_df$feature_names,val_mm_pp_p_df$padj,dc_mm_pp_p_df$padj, val_mp_pp_p_df$padj, dc_mp_pp_p_df$padj, val_mp_mm_p_df$padj, dc_mp_mm_p_df$padj)
  
  names(val_dc_adj_p) <- c("Features","mm_pp_val", "mm_pp_dc", "mp_pp_val", "mp_pp_dc", "mp_mm_val", "mp_mm_dc")
  
  
  ##### To get the required plots 
  
  # data_ppmm
  
  xx_hit_mmpp <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[2]][i] < 0.05){
      xx_hit_mmpp <- c(xx_hit_mmpp,val_dc_adj_p[[2]][i])}}
  
  xx_nhit_mmpp <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[3]][i] > 0.05){
      xx_nhit_mmpp <- c(xx_nhit_mmpp,val_dc_adj_p[[3]][i])}}
  
  # data_mppp
  xx_hit_mppp <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[4]][i] < 0.05){
      xx_hit_mppp <- c(xx_hit_mppp,val_dc_adj_p[[4]][i])}}
  
  xx_nhit_mppp <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[5]][i] > 0.05){
      xx_nhit_mppp <- c(xx_nhit_mppp,val_dc_adj_p[[5]][i])}}
  
  # data_mpmm
  xx_hit_mpmm <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[6]][i] < 0.05){
      xx_hit_mpmm <- c(xx_hit_mpmm,val_dc_adj_p[[6]][i])}}
  xx_nhit_mpmm <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[7]][i] > 0.05){
      xx_nhit_mpmm <- c(xx_nhit_mpmm,val_dc_adj_p[[7]][i])}}
  
  
  bp_mod <- data.frame(
    groups = rep(c("hits","non-hits","hits","non-hits","hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp),length(xx_hit_mpmm),length(xx_nhit_mpmm),length(xx_hit_mppp),length(xx_nhit_mppp))),
    pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp),-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm),-log10(xx_hit_mppp),-log10(xx_nhit_mppp)),
    key = rep(c("Hel-DM- vs Hel+DM+","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel+DM+"), times=c(length(c(xx_hit_mmpp,xx_nhit_mmpp)),length(c(xx_hit_mpmm,xx_nhit_mpmm)),length(c(xx_hit_mppp,xx_nhit_mppp))))
  )
  
  bp_mod$groups <- as.factor(bp_mod$groups)
  bp_mod$key <- as.factor(bp_mod$key)
  p <- ggplot2::ggplot(data = bp_mod,mapping = ggplot2::aes(x=groups, y=pvalues, group= groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=groups))+ggplot2::facet_wrap(~key)+ggplot2::scale_x_discrete(labels=NULL, breaks = NULL)+ggplot2::xlab("Groups")+ggplot2::ylab("Negative log pvalue")
  
  
  stat_c <- bp_mod %>%
    group_by(key) %>%
    wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    adjust_pvalue(method = "BH") %>%
    add_significance("p.adj") %>%
    add_xy_position(x = "group" )
  
  rep_p <- p+ggpubr::stat_pvalue_manual(stat_c[,-c(13,14)] , label = "p.adj")
  
  
  ########## TNFa
  tnf_mm_val <- val_data_3$`TNF-a (pg/ml)`
  tnf_mp_val <- val_data_2$`TNF-a (pg/ml)`
  tnf_pp_val <- val_data_1$`TNF-a (pg/ml)`
  
  tnf_mm_dis <- dm_m_con$`TNF-a (pg/ml)`
  tnf_mp_dis <- dm_p_con$`TNF-a (pg/ml)`
  tnf_pp_dis <- dm_p_pre$`TNF-a (pg/ml)`
  
  tnf_df <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(tnf_mm_val),length(tnf_mp_val),length(tnf_pp_val),length(tnf_mm_dis),length( tnf_mp_dis), length( tnf_pp_dis))),
    Groups <- c(tnf_mm_val,tnf_mp_val,tnf_pp_val,tnf_mm_dis,tnf_mp_dis,tnf_pp_dis),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(tnf_mm_val,tnf_mp_val,tnf_pp_val)),length(c(tnf_mm_dis,tnf_mp_dis,tnf_pp_dis))))
  )
  
  colnames(tnf_df) <- c("Labels","Groups","Key")
  
  TNFa_p <- ggplot2::ggplot(tnf_df, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("TNFa(pg/ml)")
  
  
  ########## IFNg
  IFNg_mm_val <- val_data_3$`IFNg (pg/ml)`
  IFNg_mp_val <- val_data_2$`IFNg (pg/ml)`
  IFNg_pp_val <- val_data_1$`IFNg (pg/ml)`
  
  IFNg_mm_dis <- dm_m_con$`IFNg (pg/ml)`
  IFNg_mp_dis <- dm_p_con$`IFNg (pg/ml)`
  IFNg_pp_dis <- dm_p_pre$`IFNg (pg/ml)`
  
  IFNg_df <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(IFNg_mm_val),length(IFNg_mp_val),length(IFNg_pp_val),length(IFNg_mm_dis),length( IFNg_mp_dis), length( IFNg_pp_dis))),
    Groups <- c(IFNg_mm_val,IFNg_mp_val,IFNg_pp_val,IFNg_mm_dis,IFNg_mp_dis,IFNg_pp_dis),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(IFNg_mm_val,IFNg_mp_val,IFNg_pp_val)),length(c(IFNg_mm_dis,IFNg_mp_dis,IFNg_pp_dis))))
  )
  
  colnames(IFNg_df) <- c("Labels","Groups","Key")
  
  IFNg_p <- ggplot2::ggplot(IFNg_df, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IFNg(pg/ml)")
  
  some_list <- list(rep_p, TNFa_p, IFNg_p,val_dc_adj_p )
  
  
return(some_list)}


# Main command
plot_rep_fig4 <- Validation_res_plots(val_data_1,val_data_2, val_data_3, dm_m_con, dm_p_pre, dm_p_con)
pvals_val_dc <- plot_rep_fig4[[4]]

```


## Section 4 - Supplementary figure (S6 and S7 figures)
The input to this function **supp_figs_6_7()** is the same as the previous section which are the three validation cohorts and their corresponding counterparts in the discovery cohort. Along with these an additional data frame (output from the previous section) is used as input.
The outputs of this function are plots 6 and 7 in the supplementary figures.

```r
supp_figs_6_7 <- function(d1_val, d2_val, d3_val, d1_dc, d2_dc, d3_dc, tog_val_dc_pval){
  ########## IL-2
  IL2_mm_val <- d3_val$`IL-2 (pg/ml)`
  IL2_mp_val <- d2_val$`IL-2 (pg/ml)`
  IL2_pp_val <- d1_val$`IL-2 (pg/ml)`
  
  IL2_mm_dis <- d1_dc$`IL-2 (pg/ml)`
  IL2_mp_dis <- d3_dc$`IL-2 (pg/ml)`
  IL2_pp_dis <- d2_dc$`IL-2 (pg/ml)`
  
  IL2_df <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(IL2_mm_val),length(IL2_mp_val),length(IL2_pp_val),length(IL2_mm_dis),length( IL2_mp_dis), length( IL2_pp_dis))),
    Groups <- c(IL2_mm_val,IL2_mp_val,IL2_pp_val,IL2_mm_dis,IL2_mp_dis,IL2_pp_dis),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(IL2_mm_val,IL2_mp_val,IL2_pp_val)),length(c(IL2_mm_dis,IL2_mp_dis,IL2_pp_dis))))
  )
  
  colnames(IL2_df) <- c("Labels","Groups","Key")
  
  IL2_p <- ggplot2::ggplot(IL2_df, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IL-2(pg/ml)")
  
 
    xx_hit_mmpp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[2]][i] < 0.01){
        xx_hit_mmpp <- c(xx_hit_mmpp,tog_val_dc_pval[[2]][i])}}
    
    xx_nhit_mmpp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[3]][i] > 0.01){
        xx_nhit_mmpp <- c(xx_nhit_mmpp,tog_val_dc_pval[[3]][i])}}
    
    # data_mppp
    xx_hit_mppp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[4]][i] < 0.01){
        xx_hit_mppp <- c(xx_hit_mppp,tog_val_dc_pval[[4]][i])}}
    
    xx_nhit_mppp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[5]][i] > 0.01){
        xx_nhit_mppp <- c(xx_nhit_mppp,tog_val_dc_pval[[5]][i])}}
    
    # data_mpmm
    xx_hit_mpmm <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[6]][i] < 0.01){
        xx_hit_mpmm <- c(xx_hit_mpmm,tog_val_dc_pval[[6]][i])}}
    xx_nhit_mpmm <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[7]][i] > 0.01){
        xx_nhit_mpmm <- c(xx_nhit_mpmm,tog_val_dc_pval[[7]][i])}}
    bp_mod <- data.frame(
      groups = rep(c("hits","non-hits","hits","non-hits","hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp),length(xx_hit_mpmm),length(xx_nhit_mpmm),length(xx_hit_mppp),length(xx_nhit_mppp))),
      pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp),-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm),-log10(xx_hit_mppp),-log10(xx_nhit_mppp)),
      key = rep(c("Hel-DM- vs Hel+DM+","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel+DM+"), times=c(length(c(xx_hit_mmpp,xx_nhit_mmpp)),length(c(xx_hit_mpmm,xx_nhit_mpmm)),length(c(xx_hit_mppp,xx_nhit_mppp))))
    )
    
    bp_mod$groups <- as.factor(bp_mod$groups)
    bp_mod$key <- as.factor(bp_mod$key)
    p <- ggplot2::ggplot(data = bp_mod,mapping = ggplot2::aes(x=groups, y=pvalues, group= groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=groups))+ggplot2::facet_wrap(~key)+ggplot2::scale_x_discrete(labels=NULL, breaks = NULL)+ggplot2::xlab("Groups")+ggplot2::ylab("Negative log pvalue")
    
    
    stat_c <- bp_mod %>%
      group_by(key) %>%
      wilcox_test(pvalues ~ groups , alternative = "greater") %>%
      adjust_pvalue(method = "BH") %>%
      add_significance("p.adj") %>%
      add_xy_position(x = "group" )
    
    ss_f_rep_0.01 <- p+ggpubr::stat_pvalue_manual(stat_c[,-c(13,14)] , label = "p.adj")
    
    xx_hit_mmpp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[2]][i] < 0.0001){
        xx_hit_mmpp <- c(xx_hit_mmpp,tog_val_dc_pval[[2]][i])}}
    
    xx_nhit_mmpp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[3]][i] > 0.0001){
        xx_nhit_mmpp <- c(xx_nhit_mmpp,tog_val_dc_pval[[3]][i])}}
    
    # data_mppp
    xx_hit_mppp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[4]][i] < 0.0001){
        xx_hit_mppp <- c(xx_hit_mppp,tog_val_dc_pval[[4]][i])}}
    
    xx_nhit_mppp <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[5]][i] > 0.0001){
        xx_nhit_mppp <- c(xx_nhit_mppp,tog_val_dc_pval[[5]][i])}}
    
    # data_mpmm
    xx_hit_mpmm <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[6]][i] < 0.0001){
        xx_hit_mpmm <- c(xx_hit_mpmm,tog_val_dc_pval[[6]][i])}}
    xx_nhit_mpmm <- c()
    for(i in 1:length(tog_val_dc_pval$Features)){
      if(tog_val_dc_pval[[7]][i] > 0.0001){
        xx_nhit_mpmm <- c(xx_nhit_mpmm,tog_val_dc_pval[[7]][i])}}
    bp_mod <- data.frame(
      groups = rep(c("hits","non-hits","hits","non-hits","hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp),length(xx_hit_mpmm),length(xx_nhit_mpmm),length(xx_hit_mppp),length(xx_nhit_mppp))),
      pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp),-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm),-log10(xx_hit_mppp),-log10(xx_nhit_mppp)),
      key = rep(c("Hel-DM- vs Hel+DM+","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel+DM+"), times=c(length(c(xx_hit_mmpp,xx_nhit_mmpp)),length(c(xx_hit_mpmm,xx_nhit_mpmm)),length(c(xx_hit_mppp,xx_nhit_mppp))))
    )
    
    bp_mod$groups <- as.factor(bp_mod$groups)
    bp_mod$key <- as.factor(bp_mod$key)
    p <- ggplot2::ggplot(data = bp_mod,mapping = ggplot2::aes(x=groups, y=pvalues, group= groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=groups))+ggplot2::facet_wrap(~key)+ggplot2::scale_x_discrete(labels=NULL, breaks = NULL)+ggplot2::xlab("Groups")+ggplot2::ylab("Negative log pvalue")
    
    
    stat_c <- bp_mod %>%
      group_by(key) %>%
      wilcox_test(pvalues ~ groups , alternative = "greater") %>%
      adjust_pvalue(method = "BH") %>%
      add_significance("p.adj") %>%
      add_xy_position(x = "group" )
    
    ss_f_rep_0.0001 <- p+ggpubr::stat_pvalue_manual(stat_c[,-c(13,14)] , label = "p.adj")
  

  ss_somelist <- list(IL2_p,ss_f_rep_0.01,ss_f_rep_0.0001)
  
  
  
  
  
return(ss_somelist)}

# Main command
supp_fig_6_7 <- supp_figs_6_7(val_data_1,val_data_2, val_data_3, dm_m_con, dm_p_pre, dm_p_con,val_dc_adj_p)

```


## Section 5 - Supplementary table 
The input to this function is the dataframe from the output in **Section 3**. Also, provide a working directory to store the output file from the function as input in the main command. The function will generate a file containing the contents in the  **supplementary table 4**.

```r
supp_infos_val <- function(together_data, wd){
  val_dc_adj_p <- together_data
  library(stats)
  ################### Hel+DM+ vs Hel-DM-
  mmpp_disc_names <- c()
  mmpp_val_names <- c()
  mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[3]][i] < 0.05){
      mmpp_disc_names <- c(mmpp_disc_names,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[2]][i] < 0.05){
      mmpp_val_names <- c(mmpp_val_names,val_dc_adj_p[[1]][i])
    }  
  }
  mmpp_cmmn_names <- base::intersect(mmpp_val_names,mmpp_disc_names)
  #phyper(common-1,disco,total-disco,val)
  mmpp_dic_val_phyper <- phyper(length(mmpp_cmmn_names)-1,length(mmpp_disc_names ),35-length(mmpp_disc_names),length(mmpp_val_names))
  
  ################### Hel-DM+ vs Hel+DM+
  mppp_disc_names <- c()
  mppp_val_names <- c()
  mppp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[5]][i] < 0.05){
      mppp_disc_names <- c(mppp_disc_names,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[4]][i] < 0.05){
      mppp_val_names <- c(mppp_val_names,val_dc_adj_p[[1]][i])
    }  
  }
  mppp_cmmn_names <- base::intersect(mppp_val_names,mppp_disc_names)
  #phyper(common-1,disco,total-disco,val)
  mppp_dic_val_phyper <- phyper(length(mppp_cmmn_names)-1,length(mppp_disc_names ),35-length(mppp_disc_names),length(mppp_val_names))
  
  ################### Hel-DM+ vs Hel-DM-
  mpmm_disc_names <- c()
  mpmm_val_names <- c()
  mpmm_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[7]][i] < 0.05){
      mpmm_disc_names <- c(mpmm_disc_names,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[6]][i] < 0.05){
      mpmm_val_names <- c(mpmm_val_names,val_dc_adj_p[[1]][i])
    }  
  }
  mpmm_cmmn_names <- base::intersect(mpmm_val_names,mpmm_disc_names)
  #phyper(common-1,disco,total-disco,val)
  mpmm_dic_val_phyper <- phyper(length(mpmm_cmmn_names)-1,length(mpmm_disc_names ),35-length(mpmm_disc_names),length(mpmm_val_names))
  
  mmpp_list <- list(mmpp_disc_names,mmpp_val_names,mmpp_cmmn_names,mmpp_dic_val_phyper)
  names(mmpp_list) <- c("Discovery","Validation","Common","Phyper value")
  mppp_list <- list(mppp_disc_names,mppp_val_names,mppp_cmmn_names,mppp_dic_val_phyper)
  names(mppp_list) <- c("Discovery","Validation","Common","Phyper value")
  mpmm_list <- list(mpmm_disc_names,mpmm_val_names,mpmm_cmmn_names,mpmm_dic_val_phyper)
  names(mpmm_list) <- c("Discovery","Validation","Common","Phyper value")
  
  setwd(wd)
  sink("Supplementary_sheet_4.txt")
  print("Hel+DM+ vs Hel-DM-")
  print(mmpp_list)
  print("Hel-DM+ vs Hel+DM+")
  print(mppp_list)
  print("Hel-DM+ vs Hel-DM-")
  print(mpmm_list)
  sink()
  
}

# Main command  

wd <- c("/data/nilesh/Main_Interaction_effect/checking/Replication/checking")
supp_infos_val(pvals_val_dc,wd)


```



















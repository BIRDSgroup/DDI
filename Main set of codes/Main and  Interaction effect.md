# Main and Interaction effect analysis 
Main set of commands to run and generate the results and figures are given below. Please follow the provided instructions to generate the results.

## Section 1 - To load the data

Run the code in this section to get the datasets **dm_m_con**, **dm_m_pre**, **dm_p_con**, **dm_p_pre**, **dm_m_con**, **dm_m_post**, **dm_p_con**, **dm_p_post**. This data is required to run the analysis.

Change the working directory in line 4 accordingly to where the data is downloaded.
```r
library(DMwR2)
for(file in c('Hel+DM+', 'Hel+DM+_Post-T', 'Hel-DM+', 'Hel+DM-', 'Hel-DM-', 'Hel+DM-_Post-T')){
  print(file)
  data <- read.table(paste("/data/users/cs20d300/Dia_hel/raw_data/data/",file, ".txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
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

## Section 2 - Pre-processing

Pre-process step to obtain the *Before-treatment* and *After-treatment data*. Load the functions *BT_data_preprocess()* and *AT_data_preprocess()* before running the main command.

The input to the function *BT_data_preprocess()* are **dm_m_con**, **dm_m_pre**, **dm_p_con**, and **dm_p_pre**. The input to the function *AT_data_preprocess()* are **dm_m_con**, **dm_m_post**, **dm_p_con**, and **dm_p_post**. 

```r

BT_data_preprocess <- function(dm_m_con,dm_m_pre, dm_p_con, dm_p_pre){
  dm_m_pre_ <- dm_m_pre[1:44,]   # to match the post-treatment data for dm_m
  int_data_1 <- rbind(dm_m_con,dm_m_pre_,dm_p_con,dm_p_pre)
  ##############################
  g1 <-seq(0,0,length.out = 60)
  g2 <- seq(0,0,length.out = 44)
  g3 <- seq(1,1,length.out = 58)
  g4 <- seq(1,1,length.out = 60)
  g <- c(g1,g2,g3,g4)
  int_data_1 <- cbind(int_data_1,g)
  ##############################
  c1 <-seq(0,0,length.out = 60)
  c2 <- seq(1,1,length.out = 44)
  c3 <- seq(0,0,length.out = 58)
  c4 <- seq(1,1,length.out = 60)
  c <- c(c1,c2,c3,c4)
  int_data_1 <- cbind(int_data_1,c)
  ###############################
  y1 <- c(2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014)
  y2 <- c(2013,2013,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015)
  y4 <- c(2013,2013,2014,2014,2014,2014,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016)
  y5 <- c(2013,2013,2014,2014,2014,2014,2014,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2016,2016,2016,2016,2016,2016,2016)
  Y <- c(y1,y2,y4,y5)
  int_data_1 <- cbind(int_data_1,Y)
  View(int_data_1)
  ######################################################
  int_data_1$g <- as.factor(int_data_1$g)
  int_data_1$c <- as.factor(int_data_1$c)
  int_data_1$Y <- as.factor(int_data_1$Y)
  #int_data_1$Age <- as.factor(int_data_1$Age)
  ######################################################
  base::return(int_data_1)}





###  section - 2.2 - To prepare int_data_3

AT_data_preprocess <- function(dm_m_con,dm_m_post, dm_p_con, dm_p_post){
  int_data_3 <- rbind(dm_m_con,dm_m_post,dm_p_con,dm_p_post)
  ############################
  g1 <-seq(0,0,length.out = 60)
  g2 <- seq(0,0,length.out = 44)
  g3 <- seq(1,1,length.out = 58)
  g4 <- seq(1,1,length.out = 60)
  g <- c(g1,g2,g3,g4)
  int_data_3 <- cbind(int_data_3,g)
  ##############################
  c1 <-seq(0,0,length.out = 60)
  c2 <- seq(1,1,length.out = 44)
  c3 <- seq(0,0,length.out = 58)
  c4 <- seq(1,1,length.out = 60)
  c <- c(c1,c2,c3,c4)
  int_data_3 <- cbind(int_data_3,c)
  #################
  y1 <- c(2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014)
  y3 <- c(2014,2014,2014,2014,2014,2014,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2016,2016,2016,2016)
  y4 <- c(2013,2013,2014,2014,2014,2014,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016)
  y6 <- c(2013,2013,2014,2014,2014,2014,2015,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016)
  Y <- c(y1,y3,y4,y6)
  int_data_3 <- cbind(int_data_3,Y)
  View(int_data_3)
  ######################################################
  int_data_3$g <- as.factor(int_data_3$g)
  int_data_3$c <- as.factor(int_data_3$c)
  #int_data_3$Age <- as.factor(int_data_3$Age)
  int_data_3$Y <- as.factor(int_data_3$Y)
  
  ############################################################################## 
  base::return(int_data_3)}






# Main command

int_data_1 <- BT_data_preprocess(dm_m_con,dm_m_pre, dm_p_con, dm_p_pre)
int_data_3 <- AT_data_preprocess(dm_m_con,dm_m_post, dm_p_con, dm_p_post)

```

## Section 3 - Main and Interaction effect analysis

Perform Main and Interaction effect analysis for before-treatment (**int_data_1**) and after-treatment samples (**int_data_3**).
Load the function **MI_eff()** function. There are two arguments to this function:

1. Before/After-treatment data (from section 2)
2. Working directory to save the results generated

Subsequently, run the main commands.

Common function MI to calculate main and interaction effect. The outputs of this function (list of list) are:

1. List of main effect features (list)
2. List of interaction effect (list)
3. Main effect p values and adjusted p values (dataframe)
4. Interaction effect p values and adjusted p values (dataframe)

```r
MI_eff <- function(ov_data, wk_dir){
  co_var_names <- c("Age", "ALT (U/L)", "AST (U/L)","BMI","Sex", "Creatinine (mg/dl)","g","c","Y")
  co_var_ids <- c()
  for(i in 1:length(co_var_names))
  {
    co_var_ids <- c(co_var_ids, which(colnames(ov_data)==co_var_names[i]))
  }
  
  main_eff_int_3_df <- ov_data[,-co_var_ids]
  
  int_3_main_pval <- vector("numeric", length = ncol(main_eff_int_3_df))
  int_3_main_colname <- colnames(main_eff_int_3_df)
  for (i in 1:ncol(main_eff_int_3_df) ) 
  {
    f1 <- lm(main_eff_int_3_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g, data = ov_data)
    f1_ <- lm(main_eff_int_3_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y, data = ov_data)
    XA <- anova(f1,f1_)
    int_3_main_pval[i] <- XA$`Pr(>F)`[2]
  }
  
  x_main_eff_int3 <- data.frame(int_3_main_colname, int_3_main_pval)
  x_main_eff_int3$adj_pval_main <- p.adjust(x_main_eff_int3$int_3_main_pval, method = "BH")
  
  ### setting up for interaction effect
  ### take the variables from the main effect data frame that pass the cut off
  main_eff_var <- x_main_eff_int3[x_main_eff_int3$adj_pval_main<0.05,1]
  
  int_3_inter_eff_df <- ov_data[,main_eff_var]
  int_3_inter_pval <- vector("numeric", length = ncol(int_3_inter_eff_df))
  
  for (i in 1:ncol(int_3_inter_eff_df) ) 
  {
    f1 <- lm(int_3_inter_eff_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g+c:g, data = ov_data)
    f1_ <- lm(int_3_inter_eff_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g, data = ov_data)
    XA <- anova(f1,f1_)
    int_3_inter_pval[i] <- XA$`Pr(>F)`[2]
  }
  
  x_inter_eff_int3 <- data.frame(main_eff_var, int_3_inter_pval)
  x_inter_eff_int3$adj_pval_inter <- p.adjust(x_inter_eff_int3$int_3_inter_pval, method = "BH")
  
  inter_eff_var <- x_inter_eff_int3[x_inter_eff_int3$adj_pval_inter<0.05,1]
  dataframe_list <- list(x_main_eff_int3,x_inter_eff_int3,main_eff_var,inter_eff_var)
  setwd(wk_dir)
  ############################################### to write the main_effects anova results into a file for later viewing
  sink("DATA_main_effect.txt")
  for (i in 1:ncol(main_eff_int_3_df)) {
    f1 <- lm(main_eff_int_3_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g, data = ov_data)
    f1_ <- lm(main_eff_int_3_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y, data = ov_data)
    print(colnames(main_eff_int_3_df[i]))
    print(anova(f1,f1_))
  }
  sink()
  ######################################################################################
  ############################################### to write the interaction_effects  anova results into a file for later viewing
  sink("DATA_interaction_effect.txt")
  for (i in 1:ncol(int_3_inter_eff_df)) {
    f1 <- lm(int_3_inter_eff_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g+c:g, data = ov_data)
    f1_ <- lm(int_3_inter_eff_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g, data = ov_data)
    print(colnames(int_3_inter_eff_df[i]))
    print(anova(f1,f1_))
  }
  sink()
  ######################################################################################
  ############################################### to write the coefficients of the model - intercept, diabetes and helminth terms (supplementary sheet 2 and 3)
  library(jtools)
  intercep_model <- c()
  cterm_model <- c()
  gterm_model <- c()
  sink("DATA_coeff.txt")
  for (i in 1:ncol(main_eff_int_3_df)) {
    f1_ <- lm(main_eff_int_3_df[[i]]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g, data = ov_data)
    ss <- jtools::summ(f1_)
    intercep_model <- c(intercep_model,ss$coeftable[1,1])
    cterm_model <- c(cterm_model,ss$coeftable[11,1])
    gterm_model <- c(gterm_model,ss$coeftable[12,1])
  }
  new_list_coeff <- list(colnames(main_eff_int_3_df), intercep_model, cterm_model,gterm_model )
  print(new_list_coeff)
  sink()
  new_df <- data.frame(colnames(main_eff_int_3_df), intercep_model, cterm_model,gterm_model)
  setwd(wk_dir)
  write.csv(new_df, file = "Coeff_terms_data.csv")
  
  ######################################################################################
  
  
base::return(dataframe_list)}

```

### 3.1 MI function for before-treatment samples
Change the working directory accordingly to save the results generated. You can create a separate folder to store the results of the before-treatment analysis.
```r
wk_dir <- c("/data/users/cs20d300/Dia_hel/results/checking/BT/")
BT_main_inter <- MI_eff(int_data_1,wk_dir)
```
### 3.2 MI function for after-treatment samples
Change the working directory accordingly to save the results generated. You can create a separate folder to store the results of the after-treatment analysis.
```r
wk_dir <- c("/data/users/cs20d300/Dia_hel/results/checking/AT/")
AT_main_inter <- MI_eff(int_data_3,wk_dir)
```
## Section 4 - Ternary plots

### 4.1 Proportion of variance explained
The first step is to calculate the percentage of variance explained by class (c - variable for helminths), group (g - variable for diabetes) and interaction term (c:g - interaction between helminths and diabetes) on features in the dataset. Load the function **per_exp()** to run the main set of commands.

The input to this function is Before/After-treatment data (from section 2). The output of this function is a dataframe containing percentage of variance explained by the three terms mentioned above for the features in the data.

```r
per_exp <- function(ip_data){
  co_var_names <- c("Age", "ALT (U/L)", "AST (U/L)","BMI","Sex", "Creatinine (mg/dl)","g","c","Y")
  co_var_ids <- c()
  for(i in 1:length(co_var_names))
  {
    co_var_ids <- c(co_var_ids, which(colnames(ip_data)==co_var_names[i]))
  }
  
  ip_data_wo_cov <- ip_data[,-co_var_ids]
  #print(ncol(ip_data_wo_cov))
  PE_df = data.frame(matrix(nrow = 0, ncol = 4),stringsAsFactors = FALSE)
  
  for(i in 1:ncol(ip_data_wo_cov)){
    m <- list()
    fit <- lm(ip_data_wo_cov[,i]~ Age+BMI+`ALT (U/L)`+`AST (U/L)`+`Creatinine (mg/dl)`+Sex+Y+c+g+c:g, data = ip_data)
    m[[1]] <- fit
    m[[2]] <- update(m[[1]],~ . -c:g)
    m[[3]] <- update(m[[2]],~ . -g)
    m[[4]] <- update(m[[3]],~ . -c)
    m[[5]] <- update(m[[4]],~ . -Y)
    m[[6]] <- update(m[[5]],~ . -Sex)
    m[[7]] <- update(m[[6]],~ . -`Creatinine (mg/dl)`)
    m[[8]] <- update(m[[7]],~ . -`AST (U/L)`)
    m[[9]] <- update(m[[8]],~ . -`ALT (U/L)`)
    m[[10]] <- update(m[[9]],~ . -BMI)
    m[[11]] <- update(m[[10]],~ . -Age)
    m_ <- anova(m[[11]],m[[10]],m[[9]],m[[8]],m[[7]],m[[6]],m[[5]],m[[4]],m[[3]],m[[2]],m[[1]])
    
    mr <- m_$`Sum of Sq`[-1]
    PctExp=(mr/(sum(mr)+mr[10]))*100
    PctExp
    
    C <- PctExp[8]
    G <- PctExp[9]
    C_G <- PctExp[10]
    feat_nam <- colnames(ip_data_wo_cov[i])
    #print(c(C, G, C_G,feat_nam))
    PE_df[i,c(1,2,3,4)] <-  c(feat_nam, C, G, C_G)
  }
  
  colnames(PE_df) <- c("Features","Class", "Group", "Interaction")
  
  
  
  base::return(PE_df)}

 
 
```

#### On before-treatment data
Provide the working directory accordingly to save the results generated.
```r
per_exp_BT <- per_exp(int_data_1)
setwd("/data/users/cs20d300/Dia_hel/results/checking/BT/")
saveRDS(per_exp_BT, file = "per_exp_variance_BT.rds")
```
#### On after-treatment data
Provide the working directory accordingly to save the results generated.
```r
per_exp_AT <- per_exp(int_data_3) ## on after-treatment data
setwd("/data/users/cs20d300/Dia_hel/results/checking/AT/")
saveRDS(per_exp_AT, file = "per_exp_variance_AT.rds")

```
### 4.2 Relative proportion of variance

The next step is to use the output from previous step (dataframe) to calculate relative proportion of variance. Load the function **relative_df()** before running the main commands.
The output of this function is the same dataframe (obtained from previous step) with additional columns that has relative proportion of variance for the three terms.

```r
relative_df <- function(ip_data_){
  intermediate_df = data.frame(matrix(nrow = 0, ncol = 3))
  for(i in 1:nrow(ip_data_)){
    intermediate_df <- rbind(intermediate_df,(as.numeric(ip_data_[i,c(2,3,4)])/sum(as.numeric(ip_data_[i,c(2,3,4)])))*100)
  }
  colnames(intermediate_df) <- c("Class_rel","Group_rel","Interaction_rel")
  rel_df <- cbind(ip_data_,intermediate_df)
  
  base::return(rel_df)}
```

#### On before-treatment data
Provide the working directory accordingly to save the results generated
```r
rela_df_BT <- relative_df(per_exp_BT)
setwd("/data/users/cs20d300/Dia_hel/results/checking/BT/")
saveRDS(rela_df_BT, file = "rela_per_exp_variance_BT.rds")
```
#### On before-treatment data
Provide the working directory accordingly to save the results generated
```r
rela_df_AT <- relative_df(per_exp_AT)
setwd("/data/users/cs20d300/Dia_hel/results/checking/AT/")
saveRDS(rela_df_AT, file = "rela_per_exp_variance_AT.rds")
```

### 4.3 Plot
Load the function **ternp()**. The arguments for this function are:

1. Relative proportion of variance data (before/after-treatment) - output from **Section 4.2**
2. Output from the main and interaction effect analysis from Section 3 (before/after-treatment) 
3. Color for the points in the ternary plot

Subsequently, run the main commands.

```r
ternp <- function(r_df, main_op,colr){
  
  install.packages("Ternary")
  library(Ternary)
  v_in <- list()
  for(i in 1:nrow(r_df)){
    v_in[[i]] <- c(r_df[i,5],r_df[i,6],r_df[i,7])
  }
  names(v_in) <- r_df$Features
  
  
  yop <- v_in[main_op[[3]]]
  
  TernaryPlot(atip ="Helminth",btip = "Diabetes",ctip ="Interaction",grid.minor.lines = 0)
  Ternary::AddToTernary(points, v_in, cex =0.5)
  Ternary::TernaryPoints(yop,pch=1, col=colr)
  
}

```

#### Before-treatment plot
```r
BT_tern <- ternp(rela_df_BT,BT_main_inter,"green")
```
#### After-treatment plot
```r
AT_tern <- ternp(rela_df_AT, AT_main_inter,"red")
```











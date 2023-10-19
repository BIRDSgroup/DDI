######################################### New script for GitHub


################## proper set of codes for Main & Interaction effects (Refer to readme file for more clear instructions/explanation)

####################################      Functions      #########################################################################



##################        To do the pre-process and obtain two datasets      ############################################

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
  #View(int_data_1)
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
  #View(int_data_3)
  ######################################################
  int_data_3$g <- as.factor(int_data_3$g)
  int_data_3$c <- as.factor(int_data_3$c)
  #int_data_3$Age <- as.factor(int_data_3$Age)
  int_data_3$Y <- as.factor(int_data_3$Y)
  
  ############################################################################## 
  base::return(int_data_3)}


###################################################### Main and Interaction function 


MI_func <- function(input_data, covariates, disease_terms, cut_off, wk_dir){
  ipd <- input_data
  c_ls <- covariates
  d_ls <- disease_terms
  ap_co <- cut_off
  c_ids <- c()
  for(i in 1:length(c_ls))
  {
    c_ids <- c(c_ids, which(colnames(ipd)==c_ls[i]))
  }
  d_ids <- c()
  for(i in 1:length(d_ls))
  {
    d_ids  <- c(d_ids , which(colnames(ipd)==d_ls[i]))
  }
  
  m_int1 <- ipd[,-c_ids]
  
  int1_p <- vector("numeric", length = ncol(m_int1))
  int1_cn <- colnames(m_int1)
  for (i in 1:ncol(m_int1) ) 
  {
    f1 <- lm(m_int1[[i]]~ ., data = ipd[c_ids])
    f1_ <- lm(m_int1[[i]]~ ., data = ipd[setdiff(c_ids,d_ids)])
    XA <- anova(f1,f1_)
    int1_p[i] <- XA$`Pr(>F)`[2]
  }
  
  int1_m_df <- data.frame(int1_cn, int1_p)
  int1_m_df$adj_pval_main <- p.adjust(int1_m_df$int1_p, method = "BH")
  
  ### setting up for interaction effect
  ### take the variables from the main effect data frame that pass the cut off
  main_eff_var <- int1_m_df[int1_m_df$adj_pval_main<ap_co,1]
  
  colnames(int1_m_df) <- c("Features","P-value","Adjusted p-value")
  
  cpy_id1 <- ipd
  cpy_id1[,ncol(ipd)+1] <- ipd[,d_ids[1]]:ipd[,d_ids[2]]
  colnames(cpy_id1)[ncol(ipd)+1] <- "interaction"
  
  cov_int <- c_ids
  cov_int[length(c_ids)+1] <- ncol(cpy_id1)
  
  i_int1 <- cpy_id1[,main_eff_var]
  int_p <- vector("numeric", length = ncol(i_int1))
  
  for (i in 1:ncol(i_int1) ) 
  {
    f1 <- lm(i_int1[[i]]~ ., data = cpy_id1[cov_int])
    f1_ <- lm(i_int1[[i]]~ ., data = cpy_id1[c_ids])
    XA <- anova(f1,f1_)
    int_p[i] <- XA$`Pr(>F)`[2]
  }
  
  m_df_1 <- data.frame(main_eff_var, int_p)
  m_df_1$adj_pval_inter <- p.adjust(m_df_1$int_p, method = "BH")
  
  inter_eff_var <- m_df_1[m_df_1$adj_pval_inter<ap_co,1]
  
  colnames(m_df_1) <- c("Features","P-value","Adjusted p-value")
  
  setwd(wk_dir)
  ############################################### to write the main_effects anova results into a file for later viewing
  sink("DATA_main_effect.txt")
  for (i in 1:ncol(m_int1)) {
    f1 <- lm(m_int1[[i]]~ ., data = ipd[c_ids])
    f1_ <- lm(m_int1[[i]]~ ., data = ipd[setdiff(c_ids,d_ids)])
    print(colnames(m_int1[i]))
    print(anova(f1,f1_))
  }
  sink()
  ######################################################################################
  ############################################### to write the interaction_effects  anova results into a file for later viewing
  sink("DATA_interaction_effect.txt")
  for (i in 1:ncol(i_int1)) {
    f1 <- lm(i_int1[[i]]~ ., data = cpy_id1[cov_int])
    f1_ <- lm(i_int1[[i]]~ ., data = cpy_id1[c_ids])
    print(colnames(i_int1[i]))
    print(anova(f1,f1_))
  }
  sink()
  ######################################################################################
  ############################################### to write the coefficients of the model - intercept, diabetes and helminth terms (supplementary sheet 2 and 3)
  #install.packages("jtools")
  library(jtools)
  library(writexl)
  intercep_model <- c()
  cterm_model <- c()
  gterm_model <- c()
  sink("DATA_coeff.txt")
  for (i in 1:ncol(m_int1)) {
    f1 <- lm(m_int1[[i]]~ ., data = ipd[c_ids])
    ss <- jtools::summ(f1)
    intercep_model <- c(intercep_model,ss$coeftable[1,1])
    cterm_model <- c(cterm_model,ss$coeftable[11,1])
    gterm_model <- c(gterm_model,ss$coeftable[12,1])
  }
  new_list_coeff <- list(colnames(m_int1), intercep_model, cterm_model,gterm_model )
  print(new_list_coeff)
  sink()
  new_df <- data.frame(colnames(m_int1), intercep_model, cterm_model,gterm_model)
  #writexl::write_xlsx(new_df, path = tempfile(fileext = paste(wk_dir,"/COEFF_terms_data.xlsx" , sep = "")))
  setwd(wk_dir)
  write.csv(new_df, file = "Coeff_terms_data.csv")
  ######################################################################################
  
  mi_op_list <- list(int1_m_df,m_df_1,main_eff_var,inter_eff_var)
  names(mi_op_list) <- c("features_m_df", "features_i_df", "Main_effect_variables", "Interaction_effect_variables")
  
  
  return(mi_op_list)}



######### To calculate percentage explained of class, group and interaction term on the features ###############################################################


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








#################### to calculate relative proportion of variance for the features (class, group and interaction term)

relative_df <- function(ip_data_){
  intermediate_df = data.frame(matrix(nrow = 0, ncol = 3))
  for(i in 1:nrow(ip_data_)){
    intermediate_df <- rbind(intermediate_df,(as.numeric(ip_data_[i,c(2,3,4)])/sum(as.numeric(ip_data_[i,c(2,3,4)])))*100)
  }
  colnames(intermediate_df) <- c("Class_rel","Group_rel","Interaction_rel")
  rel_df <- cbind(ip_data_,intermediate_df)
  
  base::return(rel_df)}

####################  Ternary ploy generation


ternp <- function(r_df, main_op,colr, wd){
  
  #install.packages("Ternary")
  library(Ternary)
  v_in <- list()
  for(i in 1:nrow(r_df)){
    v_in[[i]] <- c(r_df[i,5],r_df[i,6],r_df[i,7])
  }
  names(v_in) <- r_df$Features
  
  
  yop <- v_in[main_op[[3]]]
  
  setwd(wd)
  png("Ternary_plot.png")
  TernaryPlot(atip ="Helminth",btip = "Diabetes",ctip ="Interaction",grid.minor.lines = 0)
  Ternary::AddToTernary(points, v_in, cex =0.5)
  Ternary::TernaryPoints(yop,pch=1, col=colr)
  dev.off()
}


##### section-1

##### Data for control-pre-T (before-treatment) and control-post-T (after-treatment)
###### knn imputation to remove Nas
wd_m <- c("D:/work/DM_Hel/reproduce/data/")  #### change wd to dir where data is stored

library(DMwR2)
for(file in c('Hel+DM+', 'Hel+DM+_Post-T', 'Hel-DM+', 'Hel+DM-', 'Hel-DM-', 'Hel+DM-_Post-T')){
  print(file)
  data <- read.table(paste(wd_m,file, ".txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
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

##### Creating dir to store the results
dir.create(paste0(wd_m,"before_treatment"))
dir.create(paste0(wd_m,"after_treatment"))
x_bt <- paste0(wd_m,"before_treatment")
x_at <- paste0(wd_m,"after_treatment")
#### section 2 - pre-process to obtain the before-treatment and after-treatmnet data

int_data_1 <- BT_data_preprocess(dm_m_con,dm_m_pre, dm_p_con, dm_p_pre)
int_data_3 <- AT_data_preprocess(dm_m_con,dm_m_post, dm_p_con, dm_p_post)


#View(int_data_1)
#View(int_data_3)

####   section 3 - performing Main and Interaction effect analysis for before-treatment and after-treatment samples

cov_n <- c("Age", "ALT (U/L)", "AST (U/L)","BMI","Sex", "Creatinine (mg/dl)","g","c","Y")
dis_term <- c("g","c")
apc <- 0.05


# MI function for before-treatment samples - con-pre
#wk_dir <- c("/data/users/cs20d300/Dia_hel/reproduce/mi/BT/")
#BT_main_inter <- MI_eff(int_data_1,wk_dir)


wd_bt <- c(x_bt) ## wk dir - file 1
wd_at <- c(x_at) ## wk dir - file 2



m_i_bt <- MI_func(int_data_1,cov_n,dis_term, cut_off = apc, wk_dir = wd_bt)
saveRDS(m_i_bt, file = "BT_mi_obj.Rds")

# MI function for after-treatment samples - con-post
#wk_dir <- c("/data/users/cs20d300/Dia_hel/reproduce/mi/AT/")
#AT_main_inter <- MI_eff(int_data_3,wk_dir)
m_i_at <- MI_func(int_data_3,cov_n,dis_term, cut_off = apc, wk_dir = wd_at)
saveRDS(m_i_at, file = "AT_mi_obj.Rds")



####              section 4 - to get the ternary plots

# to calculate percentage explained by class, group and interaction term on features
per_exp_BT <- per_exp(int_data_1) ## on before-treatment data
setwd(wd_bt)
saveRDS(per_exp_BT, file = "per_exp_variance_BT.rds")
per_exp_AT <- per_exp(int_data_3) ## on after-treatment data
setwd(wd_at)
saveRDS(per_exp_AT, file = "per_exp_variance_AT.rds")
# to calculate relative per_exp from per_exp data 

rela_df_BT <- relative_df(per_exp_BT)
setwd(wd_bt)
saveRDS(rela_df_BT, file = "rela_per_exp_variance_BT.rds")
rela_df_AT <- relative_df(per_exp_AT)
setwd(wd_at)
saveRDS(rela_df_AT, file = "rela_per_exp_variance_AT.rds")



## To plot ternary plots from the relative per_exp data
# Before-treatment plots
#BT_tern <- ternp(rela_df_BT,BT_main_inter,"green")
# After-treatment plots
#AT_tern <- ternp(rela_df_AT, AT_main_inter,"red")


BT_tern <- ternp(rela_df_BT,m_i_bt,"green", wd_bt)
AT_tern <- ternp(rela_df_AT, m_i_at,"red",wd_at)




##########################################################################################
setwd(wd_bt)
write.csv(m_i_bt[[1]], file = "Main_effect_pavls.csv", col.names = TRUE)
write.csv(m_i_bt[[2]], file = "Interaction_effect_pavls.csv", col.names = TRUE)


setwd(wd_at)
write.csv(m_i_at[[1]], file = "Main_effect_pavls.csv", col.names = TRUE)
write.csv(m_i_at[[2]], file = "Interaction_effect_pavls.csv", col.names = TRUE)

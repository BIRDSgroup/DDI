MI_func <- function(Control_data,Disease_1_data,Disaese_2_data,Disease_1_2_data, covariates, disease_terms, cut_off, wk_dir){
  input_data <- rbind(Control_data,Disease_1_data,Disaese_2_data,Disease_1_2_data)
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
  install.packages("jtools")
  library(jtools)
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
  writexl::write_xlsx(new_df, path = paste(wk_dir, "Coeff_terms.xlsx", sep = ""))
  
  ######################################################################################
  
  mi_op_list <- list(int1_m_df,m_df_1,main_eff_var,inter_eff_var)
  names(mi_op_list) <- c("features_m_df", "features_i_df", "Main_effect_variables", "Interaction_effect_variables")
  
  
  return(mi_op_list)}

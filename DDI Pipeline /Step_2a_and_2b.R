MI_function <- function(Control_data,Disease_1_data,Disaese_2_data,Disease_1_2_data, covariates, disease_terms, cut_off, wk_dir){
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
  
  colnames(int1_m_df) <- c("Variables","P-value","Adjusted p-value")
  
  cpy_id1 <- ipd
  int_term <- ipd[,d_ids[1]]:ipd[,d_ids[2]]
  #int_term <- droplevels(int_term)
  cpy_id1[,ncol(ipd)+1] <- int_term
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
  
  colnames(m_df_1) <- c("Variables","P-value","Adjusted p-value")
  
  nr <- c("(Intercept)",d_ls)
  
  
  setwd(wk_dir)
  ############################################### to write the main_effects anova results into a file for later viewing
  #sink("DATA_main_effect.txt")
  for (i in 1:ncol(m_int1)) {
    f1 <- lm(m_int1[[i]]~ ., data = ipd[c_ids])
    f1_ <- lm(m_int1[[i]]~ ., data = ipd[setdiff(c_ids,d_ids)])
    #print(colnames(m_int1[i]))
    #print(anova(f1,f1_))
  }
  #sink()
  ######################################################################################
  ############################################### to write the interaction_effects  anova results into a file for later viewing
  #sink("DATA_interaction_effect.txt")
  for (i in 1:ncol(i_int1)) {
    f1 <- lm(i_int1[[i]]~ ., data = cpy_id1[cov_int])
    f1_ <- lm(i_int1[[i]]~ ., data = cpy_id1[c_ids])
    #print(colnames(i_int1[i]))
    #print(anova(f1,f1_))
  }
  #sink()
  ######################################################################################
  ############################################### to write the coefficients of the main effect model - intercept, diabetes and helminth terms
  #install.packages("jtools")
  #library(jtools)
  intercep <- c()
  status_1 <- c()
  status_2 <- c()
  
  #sink("Main_eff_DATA_coeff.txt")
  for (i in 1:ncol(m_int1)) {
    f1 <- lm(m_int1[[i]]~ ., data = ipd[c_ids])
    #bb <- jtools::summ(f1)
    #bb_df <- as.data.frame(bb$coeftable)
    
    nr_m <- coef(f1)
    bb_x <- which(nr_m %in% nr)
    
    #ss_df$Est.[ss_x][3]
    
    intercep <- c(intercep,coef(f1)[[1]])
    status_1 <- c(status_1,coef(f1)[[2]])
    status_2 <- c(status_2,coef(f1)[[3]])
  }
  new_list_coeff <- list(colnames(m_int1), intercep,status_1,status_2)
  #print(new_list_coeff)
  #print(bb$coeftable)
  #sink()
  new_df <- data.frame(colnames(m_int1), intercep,status_1,status_2)
  #writexl::write_xlsx(new_df, path = paste(wk_dir, "/Main_eff_coeff_terms.xlsx", sep = ""))
  
  ######################################################################################
  ############################################### to write the coefficients of the main effect model - intercept, diabetes and helminth terms
  #install.packages("jtools")
  #library(jtools)
  intercep_i <- c()
  status_1_i <- c()
  status_2_i <- c()
  status_1_2_i <- c()
  #sink("Int_eff_DATA_coeff.txt")
  for (i in 1:ncol(i_int1)) {
    f1 <- lm(i_int1[[i]]~ ., data = cpy_id1[cov_int])
    #bb <- jtools::summ(f1)
    #bb_df <- as.data.frame(bb$coeftable)
    
    nr_m <- coef(f1)
    bb_x <- which(nr_m %in% nr)
    
    #ss_df$Est.[ss_x][3]
    
    intercep_i <- c(intercep_i,coef(f1)[[1]])
    status_1_i <- c(status_1_i,coef(f1)[[2]])
    status_2_i <- c(status_2_i,coef(f1)[[3]])
    status_1_2_i <- c(status_1_2_i,coef(f1)[[4]])
  }
  new_list_coeff <- list(colnames(i_int1), intercep_i,status_1_i,status_2_i,status_1_2_i)
  #print(new_list_coeff)
  #print(bb$coeftable)
  #sink()
  new_df <- data.frame(colnames(i_int1), intercep_i,status_1_i,status_2_i,status_1_2_i)
  #writexl::write_xlsx(new_df, path = paste(wk_dir, "/Int_eff_coeff_terms.xlsx", sep = ""))
  
  ######################################################################################
  
  mi_op_list <- list(int1_m_df,m_df_1,main_eff_var,inter_eff_var)
  names(mi_op_list) <- c("variables_m_df", "variables_i_df", "Main_effect_variables", "Interaction_effect_variables")
  
  
  names_var <- mi_op_list[[1]]$Variables
  final_df <- data.frame(names_var,mi_op_list[[1]][,c(2,3)],mi_op_list[[2]][,c(2,3)],intercep,status_1,status_2,intercep_i,status_1_i,status_2_i,status_1_2_i)
  colnames(final_df) <- c("Variables", "Main effect p-values", "Main effect adjusted p-values","Interaction effect p-values", "Interaction effect p-values",
                          "Main effect model - bo (Intercept term coefficient)","Main effect model - b1 (Disease 1 term coefficient)","Main effect model - b2 (Disease 2 term coefficient)",
                          "Interaction effect model - co (Intercept term coefficient)","Interaction effect model - c1 (Disease 1 term coefficient)","Interaction effect model - c2 (Disease 2 term coefficient)",
                          "Interaction effect model - c3 (Disease 1:Disease 2 interaction term)")
  
  setwd(wk_dir)
  write.csv(final_df,file = "MI_FUNCTION_OUTPT.csv", col.names = TRUE, row.names = FALSE)
  
  return(mi_op_list)}

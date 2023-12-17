################################  Overall VALIDATION code to obtain final set of results/tables and figures
library(WRS2)
############################################ Step 1 - Get the validation data
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

############################################ Step 3 - Get the replication results ouput
# 6 input data to this function

Validation_res_plots <- function(d1_val, d2_val, d3_val, d1_dc, d2_dc, d3_dc,wd){
  
  library(dplyr)
  #library(rstatix)
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
    if(val_dc_adj_p[[3]][i] < 0.0001){
      xx_hit_mmpp <- c(xx_hit_mmpp,val_dc_adj_p[[2]][i])}} 
  
  print(paste("mmpp hits: ",length(xx_hit_mmpp))) 
  
  xx_nhit_mmpp <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[3]][i] > 0.0001){
      xx_nhit_mmpp <- c(xx_nhit_mmpp,val_dc_adj_p[[2]][i])}}
  
  print(paste("mmpp nhits: ",length(xx_nhit_mmpp)))
  
  # data_mppp
  xx_hit_mppp <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[5]][i] < 0.0001){
      xx_hit_mppp <- c(xx_hit_mppp,val_dc_adj_p[[4]][i])}}
  
  print(paste("mppp hits: ",length(xx_hit_mppp)))
  
  xx_nhit_mppp <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[5]][i] > 0.0001){
      xx_nhit_mppp <- c(xx_nhit_mppp,val_dc_adj_p[[4]][i])}}
  
  print(paste("mppp nhits: ",length(xx_nhit_mppp)))
  
  # data_mpmm
  xx_hit_mpmm <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[7]][i] < 0.0001){
      xx_hit_mpmm <- c(xx_hit_mpmm,val_dc_adj_p[[6]][i])}}
  
  print(paste("mpmm hits: ",length(xx_hit_mpmm)))
  
  xx_nhit_mpmm <- c()
  for(i in 1:length(val_dc_adj_p$Features)){
    if(val_dc_adj_p[[7]][i] > 0.0001){
      xx_nhit_mpmm <- c(xx_nhit_mpmm,val_dc_adj_p[[6]][i])}}
  
  print(paste("mpmm nhits: ",length(xx_nhit_mpmm)))
  
  bp_mod <- data.frame(
    groups = rep(c("hits","non-hits","hits","non-hits","hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp),length(xx_hit_mpmm),length(xx_nhit_mpmm),length(xx_hit_mppp),length(xx_nhit_mppp))),
    pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp),-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm),-log10(xx_hit_mppp),-log10(xx_nhit_mppp)),
    key = rep(c("Hel-DM- vs Hel+DM+","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel+DM+"), times=c(length(c(xx_hit_mmpp,xx_nhit_mmpp)),length(c(xx_hit_mpmm,xx_nhit_mpmm)),length(c(xx_hit_mppp,xx_nhit_mppp))))
  )
  
  bp_mod$groups <- as.factor(bp_mod$groups)
  bp_mod$key <- as.factor(bp_mod$key)
  
  dir.create(paste0(wd,"Main_Figures"))
  
  p <- ggplot2::ggplot(data = bp_mod,mapping = ggplot2::aes(x=groups, y=pvalues, group= groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=groups))+ggplot2::facet_wrap(~key)+ggplot2::scale_x_discrete(labels=NULL, breaks = NULL)+ggplot2::xlab("Groups")+ggplot2::ylab("Negative log pvalue")+ggplot2::theme(text = ggplot2::element_text(size=18))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  
  setwd(paste0(wd,"Main_Figures"))
  jpeg("Replication.jpg")
  plot(p)
  dev.off()
  
  
  # for mmpp
  bp_mod_mmpp <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp))),
    pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp))
  )
  
  
  
  set.seed(2000)   # this is the seed for without nboot
  stat_c_mmpp <- bp_mod_mmpp %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  # adjust_pvalue(method = "BH") %>%
  #add_significance("p.adj") %>%
  #add_significance("p.value") %>%
  #add_xy_position(x = "group" )
  
  
  # for mppp
  bp_mod_mppp <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mppp),length(xx_nhit_mppp))),
    pvalues = c(-log10(xx_hit_mppp),-log10(xx_nhit_mppp))
  )
  
  
  
  set.seed(2001)  # this is the seed for without nboot
  stat_c_mppp <- bp_mod_mppp %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  
  # for mpmm
  bp_mod_mpmm <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mpmm),length(xx_nhit_mpmm))),
    pvalues = c(-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm))
  )
  
  
  
  set.seed(2002)  # this is the seed for without nboot
  stat_c_mpmm <- bp_mod_mpmm %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  
  #rep_p <- p+ggpubr::stat_pvalue_manual(stat_c[,-c(13,14)] , label = "p.adj")
  
  
  tnfa_mm_val <- val_data_3$`TNF-a (pg/ml)`
  tnfa_mp_val <- val_data_2$`TNF-a (pg/ml)`
  tnfa_pp_val <- val_data_1$`TNF-a (pg/ml)`
  
  tnfa_mm_dis <- dm_m_con$`TNF-a (pg/ml)`
  tnfa_mp_dis <- dm_p_con$`TNF-a (pg/ml)`
  tnfa_pp_dis <- dm_p_pre$`TNF-a (pg/ml)`
  
  tnfa_df <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(tnfa_mm_val),length(tnfa_mp_val),length(tnfa_pp_val),length(tnfa_mm_dis),length(tnfa_mp_dis), length(tnfa_pp_dis))),
    Groups <- c(log10(tnfa_mm_val),log10(tnfa_mp_val),log10(tnfa_pp_val),log10(tnfa_mm_dis),log10(tnfa_mp_dis),log10(tnfa_pp_dis)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(tnfa_mm_val,tnfa_mp_val,tnfa_pp_val)),length(c(tnfa_mm_dis,tnfa_mp_dis,tnfa_pp_dis))))
  )
  
  colnames(tnfa_df) <- c("Labels","Groups","Key")
  
  tnfa_p <- ggplot2::ggplot(tnfa_df, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("TNF-alpha in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  
  
  
  ifng_mm_val <- val_data_3$`IFNg (pg/ml)`
  ifng_mp_val <- val_data_2$`IFNg (pg/ml)`
  ifng_pp_val <- val_data_1$`IFNg (pg/ml)`
  
  ifng_mm_dis <- dm_m_con$`IFNg (pg/ml)`
  ifng_mp_dis <- dm_p_con$`IFNg (pg/ml)`
  ifng_pp_dis <- dm_p_pre$`IFNg (pg/ml)`
  
  ifng_df <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(ifng_mm_val),length(ifng_mp_val),length(ifng_pp_val),length(ifng_mm_dis),length(ifng_mp_dis), length(ifng_pp_dis))),
    Groups <- c(log10(ifng_mm_val),log10(ifng_mp_val),log10(ifng_pp_val),log10(ifng_mm_dis),log10(ifng_mp_dis),log10(ifng_pp_dis)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(ifng_mm_val,ifng_mp_val,ifng_pp_val)),length(c(ifng_mm_dis,ifng_mp_dis,ifng_pp_dis))))
  )
  
  colnames(ifng_df) <- c("Labels","Groups","Key")
  
  ifng_p <- ggplot2::ggplot(ifng_df, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IFN-gamma in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  
  il2_mm_val <- val_data_3$`IL-2 (pg/ml)`
  il2_mp_val <- val_data_2$`IL-2 (pg/ml)`
  il2_pp_val <- val_data_1$`IL-2 (pg/ml)`
  
  il2_mm_dis <- dm_m_con$`IL-2 (pg/ml)`
  il2_mp_dis <- dm_p_con$`IL-2 (pg/ml)`
  il2_pp_dis <- dm_p_pre$`IL-2 (pg/ml)`
  
  il2_df <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(il2_mm_val),length(il2_mp_val),length(il2_pp_val),length(il2_mm_dis),length(il2_mp_dis), length(il2_pp_dis))),
    Groups <- c(log10(il2_mm_val),log10(il2_mp_val),log10(il2_pp_val),log10(il2_mm_dis),log10(il2_mp_dis),log10(il2_pp_dis)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(il2_mm_val,il2_mp_val,il2_pp_val)),length(c(il2_mm_dis,il2_mp_dis,il2_pp_dis))))
  )
  
  colnames(il2_df) <- c("Labels","Groups","Key")
  
  il2_p <- ggplot2::ggplot(il2_df, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IL-2 in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  
 
  
  setwd(paste0(wd,"Main_Figures"))
  jpeg("TNF-alpha.jpg")
  plot(tnfa_p)
  dev.off()
  
  
  setwd(paste0(wd,"Main_Figures"))
  jpeg("IFN-gamma.jpg")
  plot(ifng_p)
  dev.off()
  
  setwd(paste0(wd,"Main_Figures"))
  jpeg("IL-2.jpg")
  plot(il2_p)
  dev.off()
  
  some_list <- list(p,stat_c_mmpp,stat_c_mppp,stat_c_mpmm,tnfa_p, ifng_p,il2_p,val_dc_adj_p )
  names(some_list) <- c("replication_image","Robust t-test pval - hel-dm- vs hel+dm+","Robust t-test pval - hel-dm+ vs hel+dm+","Robust t-test pval - hel-dm+ vs hel-dm-","TNFalpha_image","IFNgamma_image","IL2_image","pvalue_validation_discovery_cohort")
  
  
  return(some_list)}

## Main command / results generating command
wr_dr <- c("D:/work/DM_Hel/reproduce/Validation/validation_data/")

overall_list <- Get_val_data(wr_dr)
# Split the data into respective groups

# Helminths infected and Diabetes +ve group (pp)
val_data_1 <- overall_list[[1]]

# Helminths no-infection and Diabetes +ve group (mp)
val_data_2 <- overall_list[[2]]

# Helminths no-infection and Diabetes -ve group (mm)
val_data_3 <- overall_list[[3]]
########################################## Step 2 - Get the discovery data ( same data used in main and interaction effect)

##### Data for control-pre-T (before-treatment) and control-post-T (after-treatment)
###### knn imputation to remove Nas



wd_dir_disco <- c("D:/work/DM_Hel/reproduce/data/")
library(DMwR2)
for(file in c('Hel+DM+', 'Hel+DM+_Post-T', 'Hel-DM+', 'Hel+DM-', 'Hel-DM-', 'Hel+DM-_Post-T')){
  print(file)
  data <- read.table(paste(wd_dir_disco,file, ".txt", sep = ""), sep='\t', header=T, stringsAsFactors=F, check.names=FALSE)
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


######################################################

plot_rep_fig4 <- Validation_res_plots(val_data_1,val_data_2, val_data_3, dm_m_con, dm_p_pre, dm_p_con, wr_dr)
pvals_val_dc <- plot_rep_fig4[[8]]
setwd(wr_dr)
saveRDS(plot_rep_fig4, file = "validation_results.RDS")
saveRDS(pvals_val_dc, file = "pvalues_validation_discovery_cohorts.RDS")
########################  Supplementary figures for replication analysis 


supp_figs_6_7 <- function(d1_val, d2_val, d3_val, d1_dc, d2_dc, d3_dc, tog_val_dc_pval,wd){
  ########## IL-17a
  
  il17a_mm_val <- d3_val$`IL-17A (pg/ml)`
  il17a_mp_val <- d2_val$`IL-17A (pg/ml)`
  il17a_pp_val <- d1_val$`IL-17A (pg/ml)`
  
  il17a_mm_dis <- dm_m_con$`IL-17A (pg/ml)`
  il17a_mp_dis <- dm_p_con$`IL-17A (pg/ml)`
  il17a_pp_dis <- dm_p_pre$`IL-17A (pg/ml)`
  
  il17a_df_log10_m <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(il17a_mm_val),length(il17a_mp_val),length(il17a_pp_val),length(il17a_mm_dis),length(il17a_mp_dis), length(il17a_pp_dis))),
    Groups <- c(log10(il17a_mm_val),log10(il17a_mp_val),log10(il17a_pp_val),log10(il17a_mm_dis),log10(il17a_mp_dis),log10(il17a_pp_dis)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(il17a_mm_val,il17a_mp_val,il17a_pp_val)),length(c(il17a_mm_dis,il17a_mp_dis,il17a_pp_dis))))
  )
  
  colnames(il17a_df_log10_m) <- c("Labels","Groups","Key")
  
  il17a_p_log10 <- ggplot2::ggplot(il17a_df_log10_m, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IL-17A in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  ### Visfatin
  vis_mm_val <- d3_val$`Visfatin (pg/ml)`
  vis_mp_val <- d2_val$`Visfatin (pg/ml)`
  vis_pp_val <- d1_val$`Visfatin (pg/ml)`
  
  vis_mm_dis <- dm_m_con$`Visfatin (pg/ml)`
  vis_mp_dis <- dm_p_con$`Visfatin (pg/ml)`
  vis_pp_dis <- dm_p_pre$`Visfatin (pg/ml)`
  
  
  vis_df_log10_m <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(vis_mm_val),length(vis_mp_val),length(vis_pp_val),length(vis_mm_dis),length(vis_mp_dis), length(vis_pp_dis))),
    Groups <- c(log10(vis_mm_val),log10(vis_mp_val),log10(vis_pp_val),log10(vis_mm_dis),log10(vis_mp_dis),log10(vis_pp_dis)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(vis_mm_val,vis_mp_val,vis_pp_val)),length(c(vis_mm_dis,vis_mp_dis,vis_pp_dis))))
  )
  
  colnames(vis_df_log10_m) <- c("Labels","Groups","Key")
  
  vis_p_log10 <- ggplot2::ggplot(vis_df_log10_m, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("Visfatin in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  ### Il-4
  il4_mm_val <- d3_val$`IL-4 (pg/ml)`
  il4_mp_val <- d2_val$`IL-4 (pg/ml)`
  il4_pp_val <- d1_val$`IL-4 (pg/ml)`
  
  il4_mm_dis <- dm_m_con$`IL-4 (pg/ml)`
  il4_mp_dis <- dm_p_con$`IL-4 (pg/ml)`
  il4_pp_dis <- dm_p_pre$`IL-4 (pg/ml)`
  
  
  il4_df_log <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(il4_mm_val),length(il4_mp_val),length(il4_pp_val),length(il4_mm_dis),length(il4_mp_dis), length(il4_pp_dis))),
    Groups <- c(log10(il4_mm_val+0.5),log10(il4_mp_val+0.5),log10(il4_pp_val+0.5),log10(il4_mm_dis+0.5),log10(il4_mp_dis+0.5),log10(il4_pp_dis+0.5)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(il4_mm_val,il4_mp_val,il4_pp_val)),length(c(il4_mm_dis,il4_mp_dis,il4_pp_dis))))
  )
  
  colnames(il4_df_log) <- c("Labels","Groups","Key")
  
  il4_p_log <- ggplot2::ggplot(il4_df_log, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IL-4 in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  
  
  ### Il-10
  
  il10_mm_val <- d3_val$`IL-10 (pg/ml)`
  il10_mp_val <- d2_val$`IL-10 (pg/ml)`
  il10_pp_val <- d1_val$`IL-10 (pg/ml)`
  
  il10_mm_dis <- dm_m_con$`IL-10 (pg/ml)`
  il10_mp_dis <- dm_p_con$`IL-10 (pg/ml)`
  il10_pp_dis <- dm_p_pre$`IL-10 (pg/ml)`
  
  il10_df_log <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(il10_mm_val),length(il10_mp_val),length(il10_pp_val),length(il5_mm_dis),length(il10_mp_dis), length(il10_pp_dis))),
    Groups <- c(log10(il10_mm_val),log10(il10_mp_val),log10(il10_pp_val),log10(il10_mm_dis),log10(il10_mp_dis),log10(il10_pp_dis)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(il10_mm_val,il10_mp_val,il10_pp_val)),length(c(il10_mm_dis,il10_mp_dis,il10_pp_dis))))
  )
  
  colnames(il10_df_log) <- c("Labels","Groups","Key")
  
  il10_p_log <- ggplot2::ggplot(il10_df_log, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IL-10 in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  
  ### Il-5
  il5_mm_val <- d3_val$`IL-5 (pg/ml)`
  il5_mp_val <- d2_val$`IL-5 (pg/ml)`
  il5_pp_val <- d1_val$`IL-5 (pg/ml)`
  
  il5_mm_dis <- dm_m_con$`IL-5 (pg/ml)`
  il5_mp_dis <- dm_p_con$`IL-5 (pg/ml)`
  il5_pp_dis <- dm_p_pre$`IL-5 (pg/ml)`
  
  il5_df_log <- data.frame(
    label <- rep(c("Hel-DM-","Hel-DM+","Hel+DM+","Hel-DM-","Hel-DM+","Hel+DM+"),times=c(length(il5_mm_val),length(il5_mp_val),length(il5_pp_val),length(il5_mm_dis),length(il5_mp_dis), length(il5_pp_dis))),
    Groups <- c(log10(il5_mm_val),log10(il5_mp_val),log10(il5_pp_val),log10(il5_mm_dis),log10(il5_mp_dis),log10(il5_pp_dis)),
    key <- rep(c("Validation cohort", "Discovery cohort"), times=c(length(c(il5_mm_val,il5_mp_val,il5_pp_val)),length(c(il5_mm_dis,il5_mp_dis,il5_pp_dis))))
  )
  
  colnames(il5_df_log) <- c("Labels","Groups","Key")
  
  il5_p_log <- ggplot2::ggplot(il5_df_log, ggplot2::aes(Labels, Groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=Labels))+ggplot2::facet_wrap(~Key)+ggplot2::xlab("")+ggplot2::ylab("IL-5 in log scale")+ggplot2::theme(text = ggplot2::element_text(size=20))+ggplot2::scale_x_discrete(guide = guide_axis(angle = 90))+theme_bw(base_size = 18)
  
  
  
  
  xx_hit_mmpp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[3]][i] < 0.01){
      xx_hit_mmpp <- c(xx_hit_mmpp,tog_val_dc_pval[[2]][i])}}
  
  xx_nhit_mmpp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[3]][i] > 0.01){
      xx_nhit_mmpp <- c(xx_nhit_mmpp,tog_val_dc_pval[[2]][i])}}
  
  # data_mppp
  xx_hit_mppp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[5]][i] < 0.01){
      xx_hit_mppp <- c(xx_hit_mppp,tog_val_dc_pval[[4]][i])}}
  
  xx_nhit_mppp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[5]][i] > 0.01){
      xx_nhit_mppp <- c(xx_nhit_mppp,tog_val_dc_pval[[4]][i])}}
  
  # data_mpmm
  xx_hit_mpmm <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[7]][i] < 0.01){
      xx_hit_mpmm <- c(xx_hit_mpmm,tog_val_dc_pval[[6]][i])}}
  xx_nhit_mpmm <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[7]][i] > 0.01){
      xx_nhit_mpmm <- c(xx_nhit_mpmm,tog_val_dc_pval[[6]][i])}}
  bp_mod <- data.frame(
    groups = rep(c("hits","non-hits","hits","non-hits","hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp),length(xx_hit_mpmm),length(xx_nhit_mpmm),length(xx_hit_mppp),length(xx_nhit_mppp))),
    pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp),-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm),-log10(xx_hit_mppp),-log10(xx_nhit_mppp)),
    key = rep(c("Hel-DM- vs Hel+DM+","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel+DM+"), times=c(length(c(xx_hit_mmpp,xx_nhit_mmpp)),length(c(xx_hit_mpmm,xx_nhit_mpmm)),length(c(xx_hit_mppp,xx_nhit_mppp))))
  )
  
  bp_mod$groups <- as.factor(bp_mod$groups)
  bp_mod$key <- as.factor(bp_mod$key)
  p_0.01 <- ggplot2::ggplot(data = bp_mod,mapping = ggplot2::aes(x=groups, y=pvalues, group= groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=groups))+ggplot2::facet_wrap(~key)+ggplot2::scale_x_discrete(labels=NULL, breaks = NULL)+ggplot2::xlab("Groups")+ggplot2::ylab("Negative log pvalue")
  
  
  # for mmpp
  bp_mod_mmpp_0.01 <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp))),
    pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp))
  )
  
  
  
  set.seed(2011) # this is the seed for without nboot
  #set.seed(3011) # this is the seed for without nboot = 100
  #set.seed(4011)  # this is the seed for without nboot = 1000
  #set.seed(5011)  # this is the seed for without nboot = 10000
  stat_c_mmpp_0.01 <- bp_mod_mmpp_0.01 %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  # adjust_pvalue(method = "BH") %>%
  #add_significance("p.adj") %>%
  #add_significance("p.value") %>%
  #add_xy_position(x = "group" )
  
  
  # for mppp
  bp_mod_mppp_0.01 <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mppp),length(xx_nhit_mppp))),
    pvalues = c(-log10(xx_hit_mppp),-log10(xx_nhit_mppp))
  )
  
  
  
  set.seed(2012)  # this is the seed for without nboot
  #set.seed(3012)  # this is the seed for without nboot = 100
  #set.seed(4012)   # this is the seed for without nboot = 1000
  #set.seed(5012)   # this is the seed for without nboot = 10000
  stat_c_mppp_0.01 <- bp_mod_mppp_0.01 %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  
  # for mpmm
  bp_mod_mpmm_0.01 <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mpmm),length(xx_nhit_mpmm))),
    pvalues = c(-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm))
  )
  
  
  
  set.seed(2013)  # this is the seed for without nboot
  #set.seed(3013)  # this is the seed for without nboot = 100
  #set.seed(4013)   # this is the seed for without nboot = 1000
  #set.seed(5013)   # this is the seed for without nboot = 10000
  stat_c_mpmm_0.01 <- bp_mod_mpmm_0.01 %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 1000)
  
  
  
  
  
  
  #stat_c <- bp_mod %>%
  #group_by(key) %>%
  #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
  #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
  #set.seed(2002)
  #yuen(pvalues ~ groups, side = TRUE) %>%
  #adjust_pvalue(method = "BH") %>%
  #add_significance("p.adj") %>%
  #add_xy_position(x = "group" )
  
  #ss_f_rep_0.01 <- p+ggpubr::stat_pvalue_manual(stat_c[,-c(13,14)] , label = "p.adj")
  
  xx_hit_mmpp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[3]][i] < 0.05){
      xx_hit_mmpp <- c(xx_hit_mmpp,tog_val_dc_pval[[2]][i])}}
  
  xx_nhit_mmpp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[3]][i] > 0.05){
      xx_nhit_mmpp <- c(xx_nhit_mmpp,tog_val_dc_pval[[2]][i])}}
  
  # data_mppp
  xx_hit_mppp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[5]][i] < 0.05){
      xx_hit_mppp <- c(xx_hit_mppp,tog_val_dc_pval[[4]][i])}}
  
  xx_nhit_mppp <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[5]][i] > 0.05){
      xx_nhit_mppp <- c(xx_nhit_mppp,tog_val_dc_pval[[4]][i])}}
  
  # data_mpmm
  xx_hit_mpmm <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[7]][i] < 0.05){
      xx_hit_mpmm <- c(xx_hit_mpmm,tog_val_dc_pval[[6]][i])}}
  xx_nhit_mpmm <- c()
  for(i in 1:length(tog_val_dc_pval$Features)){
    if(tog_val_dc_pval[[7]][i] > 0.05){
      xx_nhit_mpmm <- c(xx_nhit_mpmm,tog_val_dc_pval[[6]][i])}}
  bp_mod <- data.frame(
    groups = rep(c("hits","non-hits","hits","non-hits","hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp),length(xx_hit_mpmm),length(xx_nhit_mpmm),length(xx_hit_mppp),length(xx_nhit_mppp))),
    pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp),-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm),-log10(xx_hit_mppp),-log10(xx_nhit_mppp)),
    key = rep(c("Hel-DM- vs Hel+DM+","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel+DM+"), times=c(length(c(xx_hit_mmpp,xx_nhit_mmpp)),length(c(xx_hit_mpmm,xx_nhit_mpmm)),length(c(xx_hit_mppp,xx_nhit_mppp))))
  )
  
  bp_mod$groups <- as.factor(bp_mod$groups)
  bp_mod$key <- as.factor(bp_mod$key)
  p_0.05 <- ggplot2::ggplot(data = bp_mod,mapping = ggplot2::aes(x=groups, y=pvalues, group= groups))+ggplot2::geom_boxplot(ggplot2::aes(fill=groups))+ggplot2::facet_wrap(~key)+ggplot2::scale_x_discrete(labels=NULL, breaks = NULL)+ggplot2::xlab("Groups")+ggplot2::ylab("Negative log pvalue")
  
  # for mmpp
  bp_mod_mmpp_0.05 <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mmpp),length(xx_nhit_mmpp))),
    pvalues = c(-log10(xx_hit_mmpp),-log10(xx_nhit_mmpp))
  )
  
  
  
  set.seed(2021) # this is the seed for without nboot
  #set.seed(3021) # this is the seed for without nboot = 100
  #set.seed(4021)  # this is the seed for without nboot = 1000
  #set.seed(5021)  # this is the seed for without nboot = 10000
  stat_c_mmpp_0.05 <- bp_mod_mmpp_0.05 %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  # adjust_pvalue(method = "BH") %>%
  #add_significance("p.adj") %>%
  #add_significance("p.value") %>%
  #add_xy_position(x = "group" )
  
  
  # for mppp
  bp_mod_mppp_0.05 <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mppp),length(xx_nhit_mppp))),
    pvalues = c(-log10(xx_hit_mppp),-log10(xx_nhit_mppp))
  )
  
  
  
  set.seed(2022) # this is the seed for without nboot
  #set.seed(3022)  # this is the seed for without nboot = 100
  #set.seed(4022)  # this is the seed for without nboot = 1000
  #set.seed(5022)  # this is the seed for without nboot = 10000
  stat_c_mppp_0.05 <- bp_mod_mppp_0.05 %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  
  # for mpmm
  bp_mod_mpmm_0.05 <- data.frame(
    groups = rep(c("hits","non-hits"), times=c(length(xx_hit_mpmm),length(xx_nhit_mpmm))),
    pvalues = c(-log10(xx_hit_mpmm),-log10(xx_nhit_mpmm))
  )
  
  
  
  set.seed(2023)  # this is the seed for without nboot
  #set.seed(3023)  # this is the seed for without nboot = 100
  #set.seed(4023)   # this is the seed for without nboot = 1000
  #set.seed(5023)   # this is the seed for without nboot = 10000
  stat_c_mpmm_0.05 <- bp_mod_mpmm_0.05 %>%
    #group_by(key) %>%
    #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
    #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
    yuen(formula = pvalues ~ groups, side = TRUE)
  #yuenbt(formula = pvalues ~ groups, side = TRUE,nboot = 10000)
  
  
  
  
  #stat_c <- bp_mod %>%
  #group_by(key) %>%
  #wilcox_test(pvalues ~ groups , alternative = "greater") %>%
  #t_test(pvalues ~ groups , alternative = "two.sided", paired = FALSE) %>%
  #set.seed(2001)
  #yuen(pvalues ~ groups, side = TRUE) %>%
  #adjust_pvalue(method = "BH") %>%
  #add_significance("p.adj") %>%
  #add_xy_position(x = "group" )
  
  #ss_f_rep_0.0001 <- p+ggpubr::stat_pvalue_manual(stat_c[,-c(13,14)] , label = "p.adj")
  
  dir.create(paste0(wd,"Supplementary_Figures"))
  setwd(paste0(wd,"Supplementary_Figures"))
  jpeg("IL-4.jpg")
  plot(il4_p_log)
  dev.off()
  jpeg("IL-5.jpg")
  plot(il5_p_log)
  dev.off()
  jpeg("IL-10.jpg")
  plot(il10_p_log)
  dev.off()
  jpeg("IL-17A.jpg")
  plot(il17a_p_log10)
  dev.off()
  jpeg("Visfatin.jpg")
  plot(vis_p_log10)
  dev.off()
  jpeg("Replication_image_cutoff0.01.jpg")
  plot(p_0.01)
  dev.off()
  jpeg("Replication_image_cutoff0.05.jpg")
  plot(p_0.05)
  dev.off()
  
  ss_somelist <- list(il4_p_log,il5_p_log,il10_p_log,il17a_p_log10,vis_p_log10,p_0.01,stat_c_mmpp_0.01,stat_c_mppp_0.01,stat_c_mpmm_0.01,p_0.05,stat_c_mmpp_0.05,stat_c_mppp_0.05,stat_c_mpmm_0.05)
  names(ss_somelist) <- c("IL4_image","IL5_image","IL10_image","IL17a_image","Visfatin_image","Replication_image_cutoff0.01","rtt_pval_mmpp_0.01","rtt_pval_mppp_0.01","rtt_pval_mpmm_0.01","Replication_image_cutoff0.05","rtt_pval_mmpp_0.05","rtt_pval_mppp_0.05","rtt_pval_mpmm_0.05")
  return(ss_somelist)}



supp_fig_6_7 <- supp_figs_6_7(val_data_1,val_data_2, val_data_3, dm_m_con, dm_p_pre, dm_p_con,pvals_val_dc,wr_dr)
setwd(wr_dr)
saveRDS(supp_fig_6_7, "Supplementary_Figs_6_7.RDS")

supp_infos_val <- function(together_data, wd){
  val_dc_adj_p <- together_data 
  library(stats)
  ################### Hel+DM+ vs Hel-DM-
  mmpp_hits_0.0001 <- c()
  mmpp_nhits_0.0001 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[3]][i] < 0.0001){
      mmpp_hits_0.0001 <- c(mmpp_hits_0.0001,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[3]][i] > 0.0001){
      mmpp_nhits_0.0001 <- c(mmpp_nhits_0.0001,val_dc_adj_p[[1]][i])
    }  
  }
  
  mmpp_hits_0.01 <- c()
  mmpp_nhits_0.01 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[3]][i] < 0.01){
      mmpp_hits_0.01 <- c(mmpp_hits_0.01,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[3]][i] > 0.01){
      mmpp_nhits_0.01 <- c(mmpp_nhits_0.01,val_dc_adj_p[[1]][i])
    }  
  }
  
  mmpp_hits_0.05 <- c()
  mmpp_nhits_0.05 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[3]][i] < 0.05){
      mmpp_hits_0.05 <- c(mmpp_hits_0.05,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[3]][i] > 0.05){
      mmpp_nhits_0.05 <- c(mmpp_nhits_0.05,val_dc_adj_p[[1]][i])
    }  
  }
  #mmpp_cmmn_names <- base::intersect(mmpp_val_names,mmpp_disc_names)
  #phyper(common-1,disco,total-disco,val)
  #mmpp_dic_val_phyper <- phyper(length(mmpp_cmmn_names)-1,length(mmpp_disc_names ),35-length(mmpp_disc_names),length(mmpp_val_names))
  
  ################### Hel-DM+ vs Hel+DM+
  mppp_hits_0.0001 <- c()
  mppp_nhits_0.0001 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[5]][i] < 0.0001){
      mppp_hits_0.0001 <- c(mppp_hits_0.0001,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[5]][i] > 0.0001){
      mppp_nhits_0.0001 <- c(mppp_nhits_0.0001,val_dc_adj_p[[1]][i])
    }  
  }
  
  mppp_hits_0.01 <- c()
  mppp_nhits_0.01 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[5]][i] < 0.01){
      mppp_hits_0.01 <- c(mppp_hits_0.01,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[5]][i] > 0.01){
      mppp_nhits_0.01 <- c(mppp_nhits_0.01,val_dc_adj_p[[1]][i])
    }  
  }
  
  mppp_hits_0.05 <- c()
  mppp_nhits_0.05 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[5]][i] < 0.05){
      mppp_hits_0.05 <- c(mppp_hits_0.05,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[5]][i] > 0.05){
      mppp_nhits_0.05 <- c(mppp_nhits_0.05,val_dc_adj_p[[1]][i])
    }  
  }
  
  #phyper(common-1,disco,total-disco,val)
  #mppp_dic_val_phyper <- phyper(length(mppp_cmmn_names)-1,length(mppp_disc_names ),35-length(mppp_disc_names),length(mppp_val_names))
  
  ################### Hel-DM+ vs Hel-DM-
  mpmm_hits_0.0001 <- c()
  mpmm_nhits_0.0001 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[7]][i] < 0.0001){
      mpmm_hits_0.0001 <- c(mpmm_hits_0.0001,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[7]][i] > 0.0001){
      mpmm_nhits_0.0001 <- c(mpmm_nhits_0.0001,val_dc_adj_p[[1]][i])
    }  
  }
  
  mpmm_hits_0.01 <- c()
  mpmm_nhits_0.01 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[7]][i] < 0.01){
      mpmm_hits_0.01 <- c(mpmm_hits_0.01,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[7]][i] > 0.01){
      mpmm_nhits_0.01 <- c(mpmm_nhits_0.01,val_dc_adj_p[[1]][i])
    }  
  }
  
  mpmm_hits_0.05 <- c()
  mpmm_nhits_0.05 <- c()
  #mmpp_cmmn_names <- c()
  for(i in 1:length(val_dc_adj_p[[3]])){
    if(val_dc_adj_p[[7]][i] < 0.05){
      mpmm_hits_0.05 <- c(mpmm_hits_0.05,val_dc_adj_p[[1]][i])
    } 
    if(val_dc_adj_p[[7]][i] > 0.05){
      mpmm_nhits_0.05 <- c(mpmm_nhits_0.05,val_dc_adj_p[[1]][i])
    }  
  }
  #mpmm_cmmn_names <- base::intersect(mpmm_val_names,mpmm_disc_names)
  #phyper(common-1,disco,total-disco,val)
  #mpmm_dic_val_phyper <- phyper(length(mpmm_cmmn_names)-1,length(mpmm_disc_names ),35-length(mpmm_disc_names),length(mpmm_val_names))
  
  #mmpp_list <- list(mmpp_hits_0.0001,mmpp_nhits_0.0001,mmpp_hits_0.01,mmpp_nhits_0.01,mmpp_hits_0.05,mmpp_nhits_0.05)
  #names(mmpp_list) <- c("Hits_0.0001","Non-hits_0.0001","Hits_0.01","Non-hits_0.01","Hits_0.05","Non-hits_0.05")
  #mppp_list <- list(mppp_hits_0.0001,mppp_nhits_0.0001,mppp_hits_0.01,mppp_nhits_0.01,mppp_hits_0.05,mppp_nhits_0.05)
  #names(mppp_list) <- c("Hits_0.0001","Non-hits_0.0001","Hits_0.01","Non-hits_0.01","Hits_0.05","Non-hits_0.05")
  #mpmm_list <- list(mpmm_hits_0.0001,mpmm_nhits_0.0001,mpmm_hits_0.01,mpmm_nhits_0.01,mpmm_hits_0.05,mpmm_nhits_0.05)
  #names(mpmm_list) <- c("Hits_0.0001","Non-hits_0.0001","Hits_0.01","Non-hits_0.01","Hits_0.05","Non-hits_0.05")
  
  
  
  group_name <- c("Hel+DM+ vs Hel-DM-","Hel+DM+ vs Hel-DM-","Hel+DM+ vs Hel-DM-","Hel-DM+ vs Hel+DM+","Hel-DM+ vs Hel+DM+","Hel-DM+ vs Hel+DM+","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel-DM-","Hel-DM+ vs Hel-DM-")
  fdr_cut_off <- c("0.0001","0.01","0.05","0.0001","0.01","0.05","0.0001","0.01","0.05")
  #Hits_in_rep <- list(c(mmpp_list$mmpp_hits_0.0001),c(mmpp_list$mmpp_hits_0.01),c(mmpp_list$mmpp_hits_0.05),c(mppp_list$mppp_hits_0.0001),c(mppp_list$mppp_hits_0.01),c(mppp_list$mppp_hits_0.05),c(mpmm_list$mpmm_hits_0.0001),c(mpmm_list$mpmm_hits_0.01),c(mpmm_list$mpmm_hits_0.05))
  #nHits_in_rep <- list(c(mmpp_list$mmpp_nhits_0.0001),c(mmpp_list$mmpp_nhits_0.01),c(mmpp_list$mmpp_nhits_0.05),c(mppp_list$mppp_nhits_0.0001),c(mppp_list$mppp_nhits_0.01),c(mppp_list$mppp_nhits_0.05),c(mpmm_list$mpmm_nhits_0.0001),c(mpmm_list$mpmm_nhits_0.01),c(mpmm_list$mpmm_nhits_0.05))
  s4_df <- matrix(0, nrow = 9, ncol = 4)
  s4_df <- as.data.frame(s4_df)
  #s4_df <- data.frame(group_name,fdr_cut_off,Hits_in_rep,nHits_in_rep)
  colnames(s4_df) <- c("Pairwise groups in validation cohort", "FDR cut-offs", "Replication hits in the discovery cohort","Replication non-hits in the discovery cohort")
  
  s4_df[[1]] <- group_name
  s4_df[[2]] <- fdr_cut_off
  s4_df[[3]][1] <- list(mmpp_hits_0.0001)
  s4_df[[3]][2] <- list(mmpp_hits_0.01)
  s4_df[[3]][3] <- list(mmpp_hits_0.05)
  s4_df[[3]][4] <- list(mppp_hits_0.0001)
  s4_df[[3]][5] <- list(mppp_hits_0.01)
  s4_df[[3]][6] <- list(mppp_hits_0.05)
  s4_df[[3]][7] <- list(mpmm_hits_0.0001)
  s4_df[[3]][8] <- list(mpmm_hits_0.01)
  s4_df[[3]][9] <- list(mpmm_hits_0.05)
  
  s4_df[[4]][1] <- list(mmpp_nhits_0.0001)
  s4_df[[4]][2] <- list(mmpp_nhits_0.01)
  s4_df[[4]][3] <- list(mmpp_nhits_0.05)
  s4_df[[4]][4] <- list(mppp_nhits_0.0001)
  s4_df[[4]][5] <- list(mppp_nhits_0.01)
  s4_df[[4]][6] <- list(mppp_nhits_0.05)
  s4_df[[4]][7] <- list(mpmm_nhits_0.0001)
  s4_df[[4]][8] <- list(mpmm_nhits_0.01)
  s4_df[[4]][9] <- list(mpmm_nhits_0.05)
  
  #setwd(wd)
  s4_df <- apply(s4_df,2,as.character)
  write.csv(s4_df, file = paste(wd,"/Supplementary_4_table.csv", sep = ""), col.names = T)
  
  #sink("Supplementary_sheet_4.txt")
  #print("Hel+DM+ vs Hel-DM-")
  #print(mmpp_list)
  #print("Hel-DM+ vs Hel+DM+")
  #print(mppp_list)
  #print("Hel-DM+ vs Hel-DM-")
  #print(mpmm_list)
  #sink()
  
}

# Main command  

#wd <- c("D:/work/DM_Hel/reproduce/Validation/")
supp_infos_val(pvals_val_dc,wr_dr)

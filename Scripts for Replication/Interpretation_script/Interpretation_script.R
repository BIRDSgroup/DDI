#######################################################################
library(ComplexHeatmap)
library(RColorBrewer)

figure_6_func <- function(wk_dir_path,wd){
  x_ <- readxl::read_xlsx(wk_dir_path)
  x_ <- as.data.frame(x_)
  x_df <- p.adjust(as.matrix(x_), method = "BH")
  
  x_new_mat <- matrix(x_df, nrow = nrow(x_), ncol = ncol(x_))
  
  for(i in 1:ncol(x_new_mat)){
    x_new_mat[,i] <- -log10(x_new_mat[,i])
  }
  
  for(i in 1:nrow(x_new_mat)){
    for(j in 1:ncol(x_new_mat)){
      if(x_new_mat[i,j]==Inf){
        x_new_mat[i,j]=0
      }
    }
  }
  colnames(x_new_mat) <- colnames(x_)
  m <- as.matrix(x_new_mat)
  rownames(m) <- c("G-CSF TGs","GM-CSF TGs","IFN-gamma TGs","IL-1b TGs","IL-2 TGs","IL-4 TGs","IL-5 TGs","IL-6 TGs","IL-10 TGs","IL-12 TGs","IL-13 TGs","IL-17A TGs","IL-22 TGs","TNF-alpha TGs")
  
  col_letters_1 = c("G-CSF TGs" = "purple", "GM-CSF TGs"= "purple",   "IFN-gamma TGs"= "purple", "IL-1b TGs" = "purple",    "IL-2 TGs" = "purple",     "IL-4 TGs" = "purple",     "IL-5 TGs"  = "purple",    "IL-6 TGs"= "purple",      "IL-10 TGs" = "purple",     "IL-12 TGs"  = "purple",  
                    "IL-13 TGs" = "purple",    "IL-17A TGs"  = "purple",  "IL-22 TGs" = "purple", "TNF-alpha TGs"= "purple")
  #col_letters_2 = c("G-CSF" = "purple", "GM-CSF"= "purple",   "IFN-gamma"= "purple", "IL-1b" = "purple",    "IL-2" = "purple",     "IL-4" = "purple",     "IL-5"  = "purple",    "IL-6"= "purple",      "I-10" = "purple",     "IL-12"  = "purple",  
  #"IL-13" = "purple",    "IL-17a"  = "pink",  "IL-22" = "purple",    "TGF-beta" = "purple", "TNF-alpha"= "pink")
  
  col_letters_2 = c("G-CSF TGs" = "white", "GM-CSF TGs"= "white",   "IFN-gamma TGs"= "white", "IL-1b TGs" = "white",    "IL-2 TGs" = "white",     "IL-4 TGs" = "white",     "IL-5 TGs"  = "white",    "IL-6 TGs"= "white",      "IL-10 TGs" = "white",     "IL-12 TGs"  = "white",  
                    "IL-13 TGs" = "white",    "IL-17A TGs"  = "purple",  "IL-22 TGs" = "white", "TNF-alpha TGs"= "purple")
  
  x_row_name <- rownames(m)
  x_row_name
  ha = rowAnnotation(
    Before_treatmnet_DDI = x_row_name, 
    After_treatmnet_DDI = x_row_name,
    col = list(Before_treatmnet_DDI = col_letters_1,
               After_treatmnet_DDI = col_letters_2
    )
  )
  
  coul <- colorRampPalette(brewer.pal(8, "YlOrRd"))(25)
  
  
  req_img <- Heatmap(m, name = "Negative log10 adjusted p-value", column_title = "Reactome pathways enriched for target genes (TGs) of DDI markers", 
                     column_names_max_height = unit(20, "cm"),row_names_max_width = unit(7,"cm"),
                     cluster_rows = TRUE, cluster_columns = TRUE,  row_names_side = "left", right_annotation = ha, col = coul, column_names_rot = 47)
  
  #dir.create(wd,"Figure_6")
  #setwd(paste0(wd,"Figure_6"))
  jpeg("Figure_6.jpg",width = 1000, height = 700)
  plot(req_img)
  dev.off()
  return(req_img)}

############################################## LM 22 ##################################################################
library(ADAPTS)
library(ComplexHeatmap)
library(RColorBrewer)

figure_5_func <- function(lm_mat,wd){
  
  list_genes_lm22 <- rownames(lm_mat)
  #setwd("D:/work/DM_Hel/Manuscript/Extra_analysis/lm_22/")
  #write.csv(list_genes_lm22, file = "Genes_in_lm22.csv", quote = FALSE)
  
  
  queryset_list <- c("IFNG", "IL17A", "IL1B" , "IL4","IL5" , "TNFAIP6","CSF2")
  
  queryset_list_id <- c()
  for(i in 1:length(queryset_list)){
    someid <-  which( list_genes_lm22 %in% queryset_list[i])
    queryset_list_id <- c(queryset_list_id, someid)
  }
  
  
  lm22_sca <- scale(t(lm22))
  
  some_m <- lm22_sca[,queryset_list_id]
  
  
  
  
  some_m <- as.matrix(some_m)
  colnames(some_m) <- c("IFN-gamma", "IL-17A", "IL-1beta" , "IL-4","IL-5" , "TNF-alpha","GM-CSF")
  row.names(some_m) <- c("B cells naive","B cells memory","Plasma cells","CD8 cells","CD4 cells naive","CD4 cells memory resting",
                         "CD4 cells memory activated", "T cells follicular helper","T cells Regulatory","T cells gamma delta",
                         "NK cells resting","NK cells activated","Monocytes","Macrophages M0","Macrophages M1","Macrophages M2",
                         "Dendritic cells resting","Dendritic cells activated", "Mast cells resting","Mast cells activated",
                         "Eosinophils", "Neutrophils")
  
  #some_m <- scale(t(some_m))
  
  
  #rownames(some_m) <- reactome_ddi_path_matrix$`DDI markers`
  
  coul_ <- colorRampPalette(brewer.pal(8, "PiYG"))(25)
  
  ri <- Heatmap(some_m,column_names_max_height = unit(12, "cm"),row_names_max_width = unit(7,"cm"),name = "Gene Expression", column_title = "Average gene expression of some of the DDI markers in immune cells", col = coul_)
  
  dir.create(paste0(wd,"Figure_5_and_6"))
  setwd( paste0(wd,"Figure_5_and_6"))
  jpeg("Figure_5.jpg")
  plot(ri)
  dev.off()
  
  return(ri)}




wd_5 <- c("D:/work/DM_Hel/Manuscript/new_interpret/")
library(ADAPTS)
lm22 <- ADAPTS::LM22
req_img_2 <- figure_5_func(lm22,wd_5)

path_to_file <- c("D:/work/DM_Hel/Manuscript/new_interpret/all_pval_reactome.xlsx")
req_img_1 <- figure_6_func(path_to_file)







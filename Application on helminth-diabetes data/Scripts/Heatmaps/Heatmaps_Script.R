wd_hp <- c("D:/work/DM_Hel/Heatmap/data/checking/")

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
  
  #main <- combined
  
}

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
  
  setwd(wd_hp)
  jpeg("Suppl_Fig_2.jpg")
  plot(pph_s)
  dev.off()
  
}

# Calling function to generate Figure 2 (in main paper)
heatmap_main_fig(wd_hp)
# Calling function to generate Supplementary Figure 1 (in main paper)
supp_fig_2(wd_hp)


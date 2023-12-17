wd_hp <- c("D:/work/DM_Hel/Heatmap/data/checking/")


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


########################

bn_tog <- read.delim("Hel_DM_togetherYearAdj_44_res_year_v1.txt",header = TRUE)
#View(bn_tog)
#################################
bn_tog_con_dm_p <- bn_tog[1:58,]

#new_bn_tog_con_dm_p <- new_bn_tog[1:58,]

bn_tog_pre_dm_p <- bn_tog[59:118,]
#new_bn_tog_pre_dm_p <- new_bn_tog[59:118,]

bn_tog_con_dm_m <- bn_tog[179:238,]
#new_bn_tog_con_dm_m <- new_bn_tog[179:238,]

bn_tog_pre_dm_m <- bn_tog[239:282,]
#new_bn_tog_pre_dm_m <- new_bn_tog[239:282,]
#################################
c <- seq(0,0,length.out = nrow(bn_tog_con_dm_p))
g <- seq(1,1,length.out = nrow(bn_tog_con_dm_p))
bn_tog_con_dm_p <- cbind(bn_tog_con_dm_p, c,g)

c <- seq(1,1,length.out = nrow(bn_tog_pre_dm_p))
g <- seq(1,1,length.out = nrow(bn_tog_pre_dm_p))
bn_tog_pre_dm_p <- cbind(bn_tog_pre_dm_p, c,g)

c <- seq(0,0,length.out = nrow(bn_tog_con_dm_m))
g <- seq(0,0,length.out = nrow(bn_tog_con_dm_m))
bn_tog_con_dm_m <- cbind(bn_tog_con_dm_m, c,g)

c <- seq(1,1,length.out = nrow(bn_tog_pre_dm_m))
g <- seq(0,0,length.out = nrow(bn_tog_pre_dm_m))
bn_tog_pre_dm_m <- cbind(bn_tog_pre_dm_m, c,g)

bn_tog_ <- rbind(bn_tog_con_dm_m,bn_tog_pre_dm_m,bn_tog_con_dm_p,bn_tog_pre_dm_p)
#head(bn_tog_)

colnames(bn_tog_) <- c("Adiponectin","Adipsin","Basophils","Eosinophils","G-CSF","Glucagon" ,"GM-CSF","HbA1c","HCT","Hgb","IFNg","IgG",                
                       "IL-10", "IL-12","IL-13" , "IL-17A","IL-17F","IL-1b",      
                       "IL-2","IL-22","IL-4","IL-5","IL-6" ,"IL-8",     
                       "Insulin","Leptin", "Lymphocytes","MCH" ,"MCHC","MCP",     
                       "MCV","MIP.1b" ,"Monocytes","Neutrophils","PLT","RBC",       
                       "RBG","RDW","Resisitin","TGF-b","TNF-a","Urea",      
                       "Visfatin","WBC","Age","BMI", "ALT","AST",          
                       "Creatinine","Sex","Year","Helminth status", "Diabetes status" )

bn_tog_ <- bn_tog_[,-51]  ### checking without year

bn_tog_$Age <- as.numeric(bn_tog_$Age)
bn_tog_$ALT <- as.numeric(bn_tog_$ALT)
bn_tog_$AST <- as.numeric(bn_tog_$AST)
bn_tog_$Sex <- as.numeric(bn_tog_$Sex)
# bn_tog_$Year <- as.numeric(bn_tog_$Year)
bn_tog_$BMI <- as.numeric(bn_tog_$BMI)
bn_tog_$Creatinine <- as.numeric(bn_tog_$Creatinine)

##################################### After-treatment plot
bn_tog_post_dm_p <- bn_tog[119:178,]
bn_tog_post_dm_m <- bn_tog[283:326,]

c <- seq(1,1,length.out = nrow(bn_tog_post_dm_p))
g <- seq(1,1,length.out = nrow(bn_tog_post_dm_p))
bn_tog_post_dm_p <- cbind(bn_tog_post_dm_p, c,g)

c <- seq(1,1,length.out = nrow(bn_tog_post_dm_m))
g <- seq(0,0,length.out = nrow(bn_tog_post_dm_m))
bn_tog_post_dm_m <- cbind(bn_tog_post_dm_m, c,g)

bn_tog_at <- rbind(bn_tog_con_dm_m,bn_tog_post_dm_m ,bn_tog_con_dm_p,bn_tog_post_dm_p)
colnames(bn_tog_at) <- c("Adiponectin","Adipsin","Basophils","Eosinophils","G-CSF","Glucagon" ,"GM-CSF","HbA1c","HCT","Hgb","IFNg","IgG",                
                         "IL-10", "IL-12","IL-13" , "IL-17A","IL-17F","IL-1b",      
                         "IL-2","IL-22","IL-4","IL-5","IL-6" ,"IL-8",     
                         "Insulin","Leptin", "Lymphocytes","MCH" ,"MCHC","MCP",     
                         "MCV","MIP.1b" ,"Monocytes","Neutrophils","PLT","RBC",       
                         "RBG","RDW","Resisitin","TGF-b","TNF-a","Urea",      
                         "Visfatin","WBC","Age","BMI", "ALT","AST",          
                         "Creatinine","Sex","Year","Helminth status", "Diabetes status" )

bn_tog_at <- bn_tog_at[,-51]   ### checking without year

bn_tog_at$Age <- as.numeric(bn_tog_at$Age)
bn_tog_at$ALT <- as.numeric(bn_tog_at$ALT)
bn_tog_at$AST <- as.numeric(bn_tog_at$AST)
bn_tog_at$Sex <- as.numeric(bn_tog_at$Sex)
#bn_tog_at$Year <- as.numeric(bn_tog_at$Year)
bn_tog_at$BMI <- as.numeric(bn_tog_at$BMI)
bn_tog_at$Creatinine <- as.numeric(bn_tog_at$Creatinine)

library(bnlearn)

set.seed(2000)
res_bt_50<- boot.strength(bn_tog_,m= nrow(bn_tog_),algorithm = "mmhc")
res_at_50<- boot.strength(bn_tog_at,m= nrow(bn_tog_at),algorithm = "mmhc")
avg_bt_50<- averaged.network(res_bt_50)
avg_at_50<- averaged.network(res_at_50)

dir.create(paste0(wd_hp,"/Supplementary_Figures_2a_and_2b"))
setwd(paste0(wd_hp,"/Supplementary_Figures_2a_and_2b"))
#setwd("/data/users/cs20d300/Dia_hel/results/checking/bn/without_year/five_seeds/different seeds/seed_1/")
saveRDS(avg_bt_50, file = "BT_50_new.rds")
saveRDS(avg_at_50, file = "AT_50_new.rds")

write.csv(BT_50_new$arcs, file = "BT_BN_reconstruction_arcs.csv", quote = FALSE)
write.csv(AT_50_new$arcs, file = "AT_BN_reconstruction_arcs.csv",quote = FALSE)




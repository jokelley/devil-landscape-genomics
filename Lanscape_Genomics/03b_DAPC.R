###########################################################################################################################
## 3b. Run DAPC
  # Ran two programs quantifying underying demographic structure 
  # Currently written for Pre-DFTD arrival data set as this was ran separately form Post-DFTD arrival
###########################################################################################################################
## Read in the VCF file
pre<-read.vcfR("pre_vcf.vcf")

## Convert to genind object for DAPC
pre_genind<-vcfR2genind(pre)

## Select the number of PCs that explain 100% of the cumulative proportion of variance
## select the number of clusters based on the elbow in the BIC plot
pre_genind_clusters<-find.clusters(pre_genind,max.n.clust=20)

## Incoporate these values as n.pca for number of clusters and n.da for number of discriminant axes accordingly below
pre_dapc<-dapc(pre_genind,pre_genind_clusters$grp,n.pca=1000,n.da=2)

## Use Base R to plot the outcomes with the scatter.dapc function
## Assign colors for each dot based on the population of origin (sampling location)
pdf("Pre_DFTD_2.pdf",height=4,width=5)
pre_dapc_fig<-scatter.dapc(pre_dapc,ratio.pca=0.5,bg="white",col=colors_pre,pch=20,solid=0.7,
leg=TRUE,posi.leg=c("topright"),posi.pca="upperright",txt.leg=pop_pre,cex=3,clabel=0.8,
scree.da=FALSE,cex.lab=2,cex.main=2,xaxt="n",yaxt="n",cleg=1.2)
axis(1,at=x.ticks,labels=x.ticks,pos=0)
axis(2,at=y.ticks,labels=y.ticks,pos=0)
dev.off()

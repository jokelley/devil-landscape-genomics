###########################################################################################################################
## 4a. Popualtion Genetics Statistics
###########################################################################################################################

############################# First portion of this script calculates heterozygosity #####################################
## Filtering options that decided "SNP" list (same as in plink files)
 # Directories where files are stored
INDIR="/Plink_Input"
OUTDIR="/Population_Genetics"
POPULATIONS="1 2 3 4 5 6 7"   # Replace numbers with your population names
Keep_File_Pre="$OUTDIR/focal_pre_disease.keep"
Keep_File_Post="$OUTDIR/focal_post_disease.keep"

## Load vcf tools and plink
  module load vcftools
  source /usr/share/modules/init/bash
  module load plink/1.90_extrachr

## Take converted file for VCF and use to calculate heterozygosity across all popualtions pre-dftd
  vcftools --gzvcf "${INDIR}/all.gp.vcf.gz" --keep $Keep_File_Pre --recode --recode-INFO-all --out "${OUTDIR}/pre_vcf"
  vcftools --vcf "${OUTDIR}/pre_vcf.recode.vcf" --het --out "${OUTDIR}/heterozygosity/pre_het"
   
## Pre-disease heterozygosity calculation
  for i in 1 2 3 4 5 6 7;
  do
## VCF tools to create pre-disease heterozygosity calculations for each population
   vcftools --gzvcf "${PROJDIR}/data/Rapture/all.gp.vcf.gz" --keep "${OUTDIR}/${i}.keep.before" --recode 
     --recode-INFO-all --out "${OUTDIR}/${i}_pre" \
   vcftools --vcf "${OUTDIR}/${i}_pre.recode.vcf" --het --out "${OUTDIR}/heterozygosity/${i}_pre_het"
  done

## Take converted file for VCF and use to calculate heterozygosity across all popualtions post-dftd
  vcftools --gzvcf "${INDIR}/all.gp.vcf.gz" --keep $Keep_File_Post --recode --recode-INFO-all --out "${OUTDIR}/post_vcf"
  vcftools --vcf "${OUTDIR}/post_vcf.recode.vcf" --het --out "${OUTDIR}/heterozygosity/post_het"

## Post-disease heterozygosity calculation
 for i in 1 2 3 4 5 6 7;
 do
## VCF tools to create post-disease heterozygosity calculations for each population
   vcftools --gzvcf "${PROJDIR}/data/Rapture/all.gp.vcf.gz" --keep ${OUTDIR}/"${i}.keep.after" --recode 
    --recode-INFO-all --out "${OUTDIR}/${i}_post" \
  vcftools --vcf "${OUTDIR}/${i}_post.recode.vcf" --het --out "${OUTDIR}/heterozygosity/${i}_post_het"
 done


############################# Second portion of this script calculates long runs of homozyogsity (LROH) ###############
  ## Make subdirectories for LROH files
   mkdir ${OUTDIR}/LROH
 
 ## VCF tools to create pre-dftd LROH file
  vcftools --vcf "${OUTDIR}/pre_vcf.recode.vcf" --LROH --out "${OUTDIR}/LROH/pre_LROH"
   
## Pre-disease LROH calculation
  for i in 1 2 3 4 5 6 7;
  do
## VCF tools to create post-disease LROH calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_pre.recode.vcf" --LROH --out "${OUTDIR}/LROH/${i}_pre_LROH"
 done

## VCF tools to create post-dftd LROH file
  vcftools --vcf "${OUTDIR}/post_vcf.recode.vcf" --LROH --out "${OUTDIR}/LROH/post_LROH"

## Post-disease LROH calculation
 for i in 1 2 3 4 5 6 7;
 do
## VCF tools to create post-disease LROH calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_post.recode.vcf" --LROH --out "${OUTDIR}/LROH/${i}_post_LROH"
 done


############################# Third portion of this script calculates Pi ########################################
 ## Make subdirectories for Pi files
  mkdir ${OUTDIR}/pi
  
 ## VCF tools to create pre-dftd Pi file
  vcftools --vcf "${OUTDIR}/pre_vcf.recode.vcf" --site-pi --out "${OUTDIR}/pi/pre_pi"
   
## Pre-disease Pi calculation
  for i in 1 2 3 4 5 6 7;
  do
## VCF tools to create post-disease Pi calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_pre.recode.vcf" --site-pi --out "${OUTDIR}/pi/${i}_pre_pi"
 done

## VCF tools to create post-dftd Pi file
  vcftools --vcf "${OUTDIR}/post_vcf.recode.vcf" --site-pi --out "${OUTDIR}/pi/post_pi"

## Post-disease Pi calculation
 for i in 1 2 3 4 5 6 7;
 do
## VCF tools to create post-disease Pi calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_post.recode.vcf" --site-pi --out "${OUTDIR}/pi/${i}_post_pi"
 done

############################# Fourth portion of this script calculates Tajima's D ########################################
  ## Make subdirectories for Tajima's D files
   mkdir ${OUTDIR}/Tajima_D
  
 ## VCF tools to create pre-dftd Tajima's D file
  vcftools --vcf "${OUTDIR}/pre_vcf.recode.vcf" --TajimaD 10000 --out "${OUTDIR}/Tajima_D/pre_tajima_d"
   
## Pre-disease Tajima's D calculation
  for i in 1 2 3 4 5 6 7;
  do
## VCF tools to create post-disease Tajima's D calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_pre.recode.vcf" --TajimaD 10000 --out "${OUTDIR}/Tajima_D/${i}_pre_tajima_d"
 done

## VCF tools to create post-dftd Tajima's D file
  vcftools --vcf "${OUTDIR}/post_vcf.recode.vcf" --TajimaD 10000 --out "${OUTDIR}/Tajima_D/post_tajima_d"

## Post-disease Tajima's D calculation
 for i in 1 2 3 4 5 6 7;
 do
## VCF tools to create post-disease Tajima's D calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_post.recode.vcf" --TajimaD 10000 --out "${OUTDIR}/Tajima_D/${i}_post_tajima_d"
 done
 
 ############################# Fifth portion of this script calculates linkage disequeilibrium (LD)#####################
  ## Make subdirectories for LD
   mkdir ${OUTDIR}/LD
  
 ## VCF tools to create pre-dftd LD file
  vcftools --vcf "${OUTDIR}/pre_vcf.recode.vcf" --geno-r2 --out "${OUTDIR}/LD/pre_ld"
   
## Pre-disease LD calculation
  for i in 1 2 3 4 5 6 7;
  do
## VCF tools to create post-disease LD calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_pre.recode.vcf" --geno-r2 --out "${OUTDIR}/LD/${i}_pre_ld"
 done

## VCF tools to create post-dftd LD file
  vcftools --vcf "${OUTDIR}/post_vcf.recode.vcf" --geno-r2 --out "${OUTDIR}/LD/post_ld"

## Post-disease Tajima's D calculation
 for i in 1 2 3 4 5 6 7;
 do
## VCF tools to create post-disease LD calculations for each population
   vcftools --vcf "${OUTDIR}/${i}_post.recode.vcf" --geno-r2 --out "${OUTDIR}/LD/${i}_post_ld"
 done

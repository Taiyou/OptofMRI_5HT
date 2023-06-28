# This is an example to show how to normalize T2 template with Allen Brain Atlas data.
# 
# ANTsR requires us to use the same data geometry (x,y,z) and same orientation.
# Therefore, you need to work with resampling (resampleToTarget) provided by ANTsR and re-orientation by 
# itksnap -> Tools -> Reorient image...
#
# itksnap: http://www.itksnap.org/pmwiki/pmwiki.php
# ANTsR: https://github.com/stnava/ANTsR 
#
# Multiple steps to complete the procedure
# 1. Resampling
# 2. check through the itksnap, and reorient the image
# 3. apply antsRegistration and antsApplyTransforms
# 4. re-size the image
#
# by Hiroaki Hamada, oist, 2016/12/20
# revised by Hiroaki Hamada, oist, 2019/04/19

library(ANTsR);
setwd('/Volumes/HD-ADU3/PVTanalysis/normalization/')
setwd("Documents/AllenBrainAtlas/Normalization/AllenToTemplate");

# read resampled and reoriented T2 template
#mi <- antsImageRead("T2_template_revised.nii");
fi <- antsImageRead("atlasVolume.nii");
#fi2 <- antsImageRead("HTR1b.nii");
#fi3 <- antsImageRead("HTR1f.nii");
#fi4 <- antsImageRead("HTR2a.nii");
#fi5 <- antsImageRead("HTR2c.nii");

mi <- antsImageRead("T2_brain_template_mouse.nii");
#finn <- resampleImage(fi, c(130,110,200),TRUE,0);
#finn2 <- resampleImage(fi2, c(130,110,200),TRUE,0);
finn < - resampleImage(mi, c(456,528,320), TRUE, 0);
finht1b <- resampleImage(fi2, c(58,67,41), TRUE, 0);
finht1f <- resampleImage(fi3, c(58,67,41), TRUE, 0);
finht2a <- resampleImage(fi4, c(58,67,41), TRUE, 0);
finht2c <- resampleImage(fi5, c(58,67,41), TRUE, 0);

resampled <- resampleImageToTarget(fi, mi);
#resampled2 <- resampleImageToTarget(fi2, mi);
#resampled3 <- resampleImageToTarget(fi3, mi);
#resampled4 <- resampleImageToTarget(fi4, mi);
#resampled5 <- resampleImageToTarget(fi5, mi);

#antsImageWrite(resampled, "resampledAtlas.nii");
#antsImageWrite(resampled2, "resampledhtr1b.nii");
#antsImageWrite(resampled3, "resampledhtr1f.nii");
#antsImageWrite(resampled4, "resampledhtr2a.nii");
#antsImageWrite(resampled5, "resampledhtr2c.nii");

# Caution!!!
# Caution!!!
# Caution!!!
#
# Before perming antsRegistration and antsApplyTransforms
# perform reorientation with itksnap for the resampled images.

# read resampled atlas
nfi <- antsImageRead("resampledAtlas.nii");
nfi2 <- antsImageRead("resampledhtr1b.nii");
nfi3 <- antsImageRead("resampledhtr1f.nii");
nfi4 <- antsImageRead("resampledhtr2a.nii");
nfi5 <- antsImageRead("resampledhtr2c.nii");

# registration
#mytx <- antsRegistration(fixed=mi, moving=nfi, typeofTransform = c('SyN') );
mytx <- antsRegistration(fixed=mi, moving=nfi, typeofTransform = c('ElasticSyN'));
#mytx <- antsRegistration(fixed=mi, moving=nfi, typeofTransform = c('SyNOnly') );

# apply registration to the actual image
# if you would like to apply the same normalization to other images, it is also possible.
# check details in the code
mywarpedimage <- antsApplyTransforms(fixed=mi, moving=nfi, transformlist=mytx$fwdtransforms);
#mywarpedimage2 <- antsApplyTransforms(fixed=mi, moving=nfi2, transformlist=mytx$fwdtransforms,interpolator=c("nearestNeighbor"));
#mywarpedimage3 <- antsApplyTransforms(fixed=mi, moving=nfi3, transformlist=mytx$fwdtransforms,interpolator=c("nearestNeighbor"));
#mywarpedimage4 <- antsApplyTransforms(fixed=mi, moving=nfi4, transformlist=mytx$fwdtransforms,interpolator=c("nearestNeighbor"));
#mywarpedimage5 <- antsApplyTransforms(fixed=mi, moving=nfi5, transformlist=mytx$fwdtransforms,interpolator=c("nearestNeighbor"));

# output image
antsImageWrite(mywarpedimage, "NormalizedAtlas2.nii");
#antsImageWrite(mywarpedimage2, "NormalizedHTR1b.nii");
#antsImageWrite(mywarpedimage3, "NormalizedHTR1f.nii");
#antsImageWrite(mywarpedimage4, "NormalizedHTR2a.nii");
#antsImageWrite(mywarpedimage5, "NormalizedHTR2c.nii");




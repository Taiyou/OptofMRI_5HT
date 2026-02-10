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
# revised by Hiroaki Hamada, oist, 2017/03/12

library(ANTsR);
setwd("Documents/AllenBrainAtlas/Normalization/TemplateToAllen");

# read resampled and reoriented T2 template
#mi <- antsImageRead("T2_template_revised.nii");
# template from the Allen Brain Atlas
fi <- antsImageRead("atlasVolume.nii");

# template from Hikishima et al.
mi <- antsImageRead("T2_brain_template_mouse.nii");
fin < - resampleImage(mi, c(456,528,320), TRUE, 0);

resampled <- resampleImageToTarget(mi, fi);
antsImageWrite(resampled, "resampledTempalte.nii");

# read resampled atlas
nfi <- antsImageRead("resampledTemplate.nii");

# registration
mytx <- antsRegistration(fixed=fi, moving=nfi, typeofTransform = c('SyN') );

# apply registration to the actual image
# if you would like to apply the same normalization to other images, it is also possible.
# check details in the code
mywarpedimage <- antsApplyTransforms(fixed=fi, moving=nfi, transformlist=mytx$fwdtransforms,interpolator=c("nearestNeighbor"));
# output image
antsImageWrite(mywarpedimage, "NormalizedTemplate.nii");






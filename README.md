# OptofMRI5HT [Hamada et al., Nat Commu, 2024]
This is the code repository for the project about optogenetic fMRI stimulating dorsal raphe serotonin neurons [Hamada et al., Nat Commu, 2024].
The dataset is also available from Openneuro [(project ID: optofMRI_DRN)](https://openneuro.org/datasets/ds005077) 

Findings of the works
1. Functional map of serotonergic activation by optogenetics, including reward-related network
2. General anesthetics, isoflurane, reverses brain-wide activation by DRN stimulation
3. Functional map was correlated with structural density.
4. The expression of 5-HT receptors and structural density can explain the functional maps.
5. General anesthetics may change receptor response.

<img width="807" alt="optofMRI_main" src="https://github.com/Taiyou/OptofMRI_5HT/assets/2386591/490f1ad7-4e41-49c4-84ff-2c9210a0a63f">

## Experiments
The experiment is composed of four sessions.
- Session 1. in awake state 
- Session 2. in awake state (replication)
- Session 3. in anesthesia
- Session 4. in awake state

<img width="1062" alt="スクリーンショット 2022-08-08 12 20 33" src="https://user-images.githubusercontent.com/2386591/183331826-1c81c660-2095-46f1-b9bc-14715fc2956c.png">

## Data
- 1. Time Series of each session
- 2. beta values of each session
- 3. ROIs: 28 Regions of Interest (ROIs)

(Raw data will be available from Openneuro soon.)

## Prerequisite
For this study, we introduced the following software tools.

<table>
  <tr>
    <td colspan="5">Software List</td>
  </tr>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Contributor</th>
    <th>Purpose</th>
    <th>URLs</th>
  </tr>
  <tr>
    <td>1</td>
    <td>Statistical Parametric Mapping 12(SPM12)</td>
    <td>The Wellcome Centre for Human Neuroimaging, UCL</td>
    <td>MRI data analysis</td>
    <td>https://www.fil.ion.ucl.ac.uk/spm</td>    
  </tr>
  <tr>
    <td>2</td>
    <td>MarsBaR region of interest toolbox for SPM</td>
    <td> </td>
    <td>Brain Reference Registration</td>
    <td>http://marsbar.sourceforge.net/</td>  
  </tr>
  <tr>
    <td>3</td>
    <td>MRIcroGL</td>
    <td>Chris Rorden, Neuropsychology Lab, University of South Carolina</td>
    <td>3D visualization of MRI data</td>
    <td>https://www.nitrc.org/projects/mricrogl/</td>  
  </tr>
  <tr>
    <td>4</td>
    <td>Probabilistic Threshold-free Cluster Enhancement (pTFCE) [1]</td>
    <td>Tamás Spisák</td>
    <td>A cluster-enhancement method</td>
    <td>https://spisakt.github.io/pTFCE/</td>  
  </tr>
  <tr>
    <td>5</td>
    <td>Allen Brain Atlas</td>
    <td>Allen Brain Institutes</td>
    <td>Reference atlas, 5HT projection map, 5HT receptor gene expressions</td>
    <td>https://portal.brain-map.org/</td>  
  </tr>
  <tr>
    <td>6</td>
    <td>Templates for In Vivo Mouse Brain [2]</td>
    <td>Keigo Hikishima (k-hikishima@ aist.go.jp)</td>
    <td>Mouse brain templates for registration and normalization</td>
    <td>https:// www.nitrc.org/ projects/tpm_mouse</td>  
  </tr>
  <tr>
    <td>7</td>
    <td>Gramm [3]</td>
    <td>Pierre Morel</td>
    <td>Visualization of Plotting</td>
    <td>https://github.com/piermorel/gramm</td>  
  </tr>
  <tr>
    <td>8</td>
    <td>in-house analysis programs</td>
    <td>Hiro Taiyo Hamada (hiroaki.hamada@oist.jp)</td>
    <td>Analysis for time series, Behavioral analysis</td>
    <td>https://github.com/Taiyou/OptofMRI_5HT</td>  
  </tr>
  <tr>
    <td>9</td>
    <td>MATLAB2020b</td>
    <td>MathWorks</td>
    <td>Main analyses and data visualization</td>
    <td>https://mathworks.com/</td>  
  </tr>
  <tr>
    <td>10</td>
    <td>A CBV opfMRI dataset</td>
    <td>Joanes Grandjean</td>
    <td>Analysis for functional maps</td>
    <td>https://doi.org/10.18112/openneuro.ds001541.v1.1.2
https://doi.org/10.34973/raa0-5z29</td>  
  </tr> 
</table>

# Program
Please install and make a path to [Gramm](https://github.com/piermorel/gramm) prior to running the codes.

```MATLAB
% check if all codes are functional.
run_allcodes
```

1. Allen Brain Atlas

![AllenAtlasCreation](https://user-images.githubusercontent.com/2386591/186835611-04562f9d-765d-4a94-9f04-854ccd046280.png)

- AllenBrainAtlas/AllenAtlasNorm.r
- AllenBrainAtlas/TemplateNorm.r 

2. Figure 2b, Figure 5a, Supplementary Figure S4
```MATLAB
main_COPE_session1_TestandPlot
```

3. Figure 3c
```MATLAB
main_COPE_session34_TestandPlot
```

4. Figure 3d & Supplementary Figure S11
```MATLAB
visualizeAllTimeSeriesSession3vs4
```
  
5. Figure 4b-c, Figure 5b-d, Table 3 & Supplementary Table TS3
```MATLAB
 main_corr5HTprojAndCOPE
```

6. Supplementary Figure S5 & S6
```MATLAB
visualizeAllTimeSeriesSession1st
```

7. Supplementary Figure S7
```MATLAB
supp_contrastBetweenSession1vs2
```

8. Supplementary Figure S8 a-b & S9
```MATLAB
supp_consistencyBetweenSession1AndSession2
```

9. Supplementary Figure S8 c-d
```MATLAB
supp_peaktimingANDBOLDconsistency
```

10. Supplementary Figure S14
```MATLAB
suppS14_extraction_TSdata_madino
```

11. Supplementary Figure S15

- 5HTR_correlation_plot.ipynb

12. Appendix
```MATLAB
% Motion Artefacts
cd motion_artefacts
run_session1MACheck
run_session2MACheck
run_session3MACheck
run_session4MACheck
run_comparison_ane1stVSane2nd
```

# Reference
1. Spisák, T., Spisák, Z., Zunhammer, M., Bingel, U., Smith, S., Nichols, T., & Kincses, T. (2019). Probabilistic TFCE: A generalized combination of cluster size and voxel intensity to increase statistical power. NeuroImage, 185, 12–26. https://doi.org/10.1016/j.neuroimage.2018.09.078
2. Hikishima, K., Komaki, Y., Seki, F., Ohnishi, Y., Okano, H. J., & Okano, H. (2017). In vivo microscopic voxel-based morphometry with a brain template to characterize strain-specific structures in the mouse brain. Scientific reports, 7(1), 85. https://doi.org/10.1038/s41598-017-00148-1
3. Morel, (2018). Gramm: grammar of graphics plotting in Matlab. Journal of Open Source Software, 3(23), 568, https://doi.org/10.21105/joss.00568
4. Hamada H.T.*, Abe Y.,  Takata N., Taira M, Tanaka F.K., and Doya K*. Optogenetic activation of dorsal raphe serotonin neurons induces brain-wide activation. Nat Commu, 15, 4152. https://doi.org/10.1038/s41467-024-48489-6 [Preprint](https://www.biorxiv.org/content/10.1101/2022.08.07.503074v6) [Dataset](https://openneuro.org/datasets/ds005077) [Codes](https://github.com/Taiyou/OptofMRI_5HT)

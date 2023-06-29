# OptofMRI5HT
This is the code repository for the project about optogenetic fMRI stimulating dorsal raphe serotonin neurons [Hamada et al., 2022].

Findings of the works
1. Functional map of serotonergic activation by optogenetics, including reward-related network
2. General anesthetics, isoflurane, reverses brain-wide activation by DRN stimulation
3. Functional map was correlated with structural density.
4. The expression of 5-HT receptors and structural density can explain the functional maps.
5. General anesthetics may change receptor response.

## Experiments
The experiment is composed of four sessions.
- session 1. in awake state 
- session 2. in awake state (replication)
- session 3. in anesthesia
- session 4. in awake state

<img width="1062" alt="スクリーンショット 2022-08-08 12 20 33" src="https://user-images.githubusercontent.com/2386591/183331826-1c81c660-2095-46f1-b9bc-14715fc2956c.png">

## Data
- 1. Time Series of each session
- 2. beta values of each session
- 3. ROIs: 28 Regions of Interest (ROIs)

# Programs
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

10. Supplementary Figure S13

- 5HTR_correlation_plot.ipynb

11. Appendix
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
1. Hamada H.T., Abe Y.,  Takata N., Taira M, Tanaka F.K., and Doya K. Optogenetic activation of dorsal raphe serotonin neurons induces brain-wide activation, including reward-related circuits. bioXiv. [https://www.biorxiv.org/content/10.1101/2022.08.07.503074v1](https://www.biorxiv.org/content/10.1101/2022.08.07.503074v1)

# OptofMRI5HT
Code repository for the project about optogenetic fMRI stimulating dorsal raphe serotonin neurons.


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
- Allen Brain Atlas

![AllenAtlasCreation](https://user-images.githubusercontent.com/2386591/186835611-04562f9d-765d-4a94-9f04-854ccd046280.png)

AllenBrainAtlas/AllenAtlasNorm.r
AllenBrainAtlas/TemplateNorm.r 

- Figure 2b & Figure 5a

main_COPE_session1_TestandPlot.m

- Figure 3c

main_COPE_session34_TestandPlot.m

- Figure 4b-c, Figure 5b-d, Table 3 & Supplementary Table TS3

main_corr5HTprojAndCOPE.m

- Supplementay Figure S4


- Supplementary Figure S8 a-b & S9

supp_consistencyBetweenPhasicAndRepli.m

- Supplementary Figure S8 c-d

supp_peaktimingANDBOLDconsistency.m

- Supplementary Figure S11 

- Supplementary Figure S13

5HTR_correlation_plot.ipynb

# Reference
1. Hamada H.T., Abe Y.,  Takata N., Taira M, Tanaka F.K., and Doya K. Optogenetic activation of dorsal raphe serotonin neurons induces brain-wide activation, including reward-related circuits. bioXiv. https://www.biorxiv.org/content/10.1101/2022.08.07.503074v1

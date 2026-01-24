% run_allcodes.m - Execute all analysis scripts for the optogenetic fMRI study
%
% This master script runs all analysis pipelines for the study:
% "Optogenetic activation of dorsal raphe serotonin neurons induces 
%  brain-wide activation" (Hamada et al., Nat Commu 2024)
%
% Prerequisites:
%   1. MATLAB 2020b or later
%   2. Gramm toolbox (https://github.com/piermorel/gramm)
%   3. SPM12 (for preprocessing only)
%   4. All data files in /data/ directory
%
% Usage:
%   >> cd /path/to/OptofMRI_5HT
%   >> addpath(genpath('/path/to/gramm'))
%   >> run_allcodes
%
% Output:
%   Figures saved to /figures/ directory, organized by figure number
%
% Script execution order:
%   1. main_COPE_session1_TestandPlot    - Figure 2b, 5a, S4
%   2. main_COPE_session34_TestandPlot   - Figure 3c
%   3. main_corr5HTprojAndCOPE           - Figure 4b-c, 5b-d, Table 3
%   4. supp_* scripts                    - Supplementary figures
%   5. visualizeAllTimeSeries* scripts   - Time series visualizations
%
% Author: Hiro Taiyo Hamada
% Reference: https://doi.org/10.1038/s41467-024-48489-6
%
% =========================================================================

main_COPE_session1_TestandPlot
main_COPE_session34_TestandPlot
main_corr5HTprojAndCOPE
supp_consistencyBetweenSession1AndSession2
supp_contractBetweenSession3vs4
supp_contrastBetweenSession1vs2
supp_peaktimingANDBOLDconsistency
visualizeAllTimeSeriesSession1st
visualizeAllTimeSeriesSession2nd
visualizeAllTimeSeriesSession3rd
visualizeAllTimeSeriesSession4th
visualizeAllTimeSeriesSession3vs4
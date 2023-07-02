% This program is intended to extract
%
% 
% time series of BOLD signals from session2
%
%
% by Hiro Taiyo Hamada, Araya Inc.

addpath(fullfile(pwd, '/programs'))

% session2Day 
datapath_session2nd     = fullfile(pwd, '/data/session2');
listing_tph_session2  = makeList(datapath_session2nd , '*TPH*');
listing_cont_session2 = makeList(datapath_session2nd , '*WT*');

%% TPHSKK
% blue
timeseries_TPHB_session2 = extGroupTSROI(listing_tph_session2, 'blue', 'tph');
% Yellow
timeseries_TPHY_session2 = extGroupTSROI(listing_tph_session2, 'yellow', 'tph');
BOLDresponse_tphb_session2 = extBOLDresponse(timeseries_TPHB_session2);
BOLDresponse_tphy_session2 = extBOLDresponse(timeseries_TPHY_session2);


%% control
% blue
timeseries_CNTB_session2    = extGroupTSROI(listing_cont_session2, 'blue', 'cont');
% yellow
timeseries_CNTY_session2    = extGroupTSROI(listing_cont_session2, 'yellow', 'cont');
BOLDresponse_contb_session2 = extBOLDresponse(timeseries_CNTB_session2);
BOLDresponse_conty_session2 = extBOLDresponse(timeseries_CNTY_session2);


% load ROI.name.
roipath   = fullfile(pwd, '/ROIs');
[ROIname] = ExtROIname(roipath);

resultpath_tph_session2  = fullfile(pwd, '/figures/FigureS5/session2/TPH');
resultpath_cont_session2 = fullfile(pwd, '/figures/FigureS5/session2/CONT');
resultpath_vsb_session2  = fullfile(pwd, '/figures/FigureS5/session2/TPHvsCont_blue');
resultpath_vsy_session2  = fullfile(pwd, '/figures/FigureS5/session2/TPHvsCont_yellow');
mkdir(resultpath_tph_session2);
mkdir(resultpath_cont_session2);
mkdir(resultpath_vsb_session2);
mkdir(resultpath_vsy_session2);

stim = 1:5;

% visualize and save the tph group
colors = {'g', 'b'};
[AUC_TPH_B_session2, AUC_TPH_Y_session2, meanTIME_TPH_B_session2, meanTIME_TPH_Y_session2,  maxTIMES_TPH_B_session2, maxTIMES_TPH_Y_session2, Pvalus_TPH_BvsY_session2] = notvisualizeBOLDresponses(BOLDresponse_tphb_session2, BOLDresponse_tphy_session2, ROIname, resultpath_tph_session2,colors, 'same', stim);
% visualize and save the cont group
colors = {'k', 'r'};
[AUC_CONT_B_session2, AUC_CONT_Y_session2, meanTIME_CONT_B_session2, meanTIME_CONT_Y_session2, maxTIMES_CONT_B_session2, maxTIMES_CONT_Y_session2, Pvalus_CONT_BvsY_session2]  = notvisualizeBOLDresponses(BOLDresponse_contb_session2, BOLDresponse_conty_session2, ROIname, resultpath_cont_session2, colors, 'same', stim);

% visualize and save the tph vs cont, blue stimulation
colors = {'r', 'b'};
[AUC_TPH_B_session2, AUC_CONT_B_session2, meanTIME_TPH_B_session2, meanTIME_CONT_B_session2, maxTIMES_TPH_B_session2, maxTIMES_CONT_B_session2, Pvalus_TPHvsCONT_b_session2]  = notvisualizeBOLDresponses(BOLDresponse_tphb_session2, BOLDresponse_contb_session2, ROIname, resultpath_vsb_session2, colors, 'different', stim);

% visualize and save the cont group
colors = {'k', 'g'};
[AUC_TPH_Y_session2, AUC_CONT_Y_session2, meanTIME_TPH_Y_session2, meanTIME_CONT_Y_session2, maxTIMES_TPH_Y_session2, maxTIMES_CONT_Y_session2, Pvalus_TPHvsCONT_y_session2] = notvisualizeBOLDresponses(BOLDresponse_tphy_session2, BOLDresponse_conty_session2, ROIname, resultpath_vsy_session2, colors,'different', stim);

close all;

%% visualization of statistical results.
% AUC of %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_TPH_B_session2 - AUC_TPH_Y_session2);
MC_pvals_AUC             = fdr_bh(pvals_AUC)

% mean BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_TPH_B_session2 - meanTIME_TPH_Y_session2);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB)

% Peaks BOLD signals, 
[sig_peakB1st, pvals_peakB1st] = ttest(maxTIMES_TPH_B_session2 - maxTIMES_TPH_Y_session2);
MC_pvals_peakBOLD1st        = fdr_bh(pvals_peakB1st)

% %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_CONT_B_session2 - AUC_CONT_Y_session2);
MC_pvals_AUC             = fdr_bh(pvals_AUC)

% AUC BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_CONT_B_session2 - meanTIME_CONT_Y_session2);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB)

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_CONT_B_session2 - maxTIMES_CONT_Y_session2);
MC_pvals_peakBOLD        = fdr_bh(pvals_peakB)


% visualization of statistical tests on 
timedur = 40;
% maxAUC and maxTIMES, B and Y, transgenic
[maxTIMES1_bsession2, maxTIMES2_ysession2, maxTIMES1id_bsession2, maxTIMES2id_ysession2, maxAUC1_bsession2, maxAUC2_ysession2, maxAUC1id_bsession2, maxAUC2nd_ysession2] = peaksearchBOLDresponses(BOLDresponse_tphb_session2, BOLDresponse_tphy_session2, ROIname, timedur, stim);
%[maxTIMES1_bsession22, maxTIMES2_ysession22, maxTIMES1id_bsession22, maxTIMES2id_ysession22, maxAUC1_bsession22, maxAUC2_ysession22, maxAUC1id_bsession22, maxAUC2nd_ysession22] = peaksearchBOLDresponses2(BOLDresponse_tphb_session2, BOLDresponse_tphy_session2, ROIname, timedur);

% maxAUC and maxTIMES, B and Y, control
[maxTIMES1_CONTsession2, maxTIMES2_CONTsession2, maxTIMES1id_CONTsession2, maxTIMES2id_CONTsession2, maxAUC1_CONTsession2, maxAUC2_CONTsession2, maxAUC1id_CONTsession2, maxAUC2nd_CONTsession2] = peaksearchBOLDresponses(BOLDresponse_contb_session2, BOLDresponse_conty_session2, ROIname, timedur, stim);


[a,b] = ttest(maxAUC1_bsession2 - maxAUC2_ysession2)
[a,b] = ttest(maxAUC1_CONTsession2 - maxAUC2_CONTsession2)
[a,b] = ttest2(maxAUC1_bsession2 - maxAUC2_ysession2, maxAUC1_CONTsession2 - maxAUC2_CONTsession2)


mean(maxTIMES1id_bsession2);
mean(maxTIMES2id_ysession2);
mean(maxTIMES1id_CONTsession2);
mean(maxTIMES2id_CONTsession2);


(maxAUC1id_bsession2 - maxTIMES1id_bsession2);
(maxAUC2nd_ysession2 - maxTIMES2id_ysession2);
(maxAUC1id_CONTsession2 - maxTIMES1id_CONTsession2);
(maxAUC2nd_CONTsession2 - maxTIMES2id_CONTsession2);

mean(maxAUC1id_bsession2 - maxTIMES1id_bsession2);
mean(maxAUC2nd_ysession2 - maxTIMES2id_ysession2);
mean(maxAUC1id_CONTsession2 - maxTIMES1id_CONTsession2);
mean(maxAUC2nd_CONTsession2 - maxTIMES2id_CONTsession2);


% correlation between peaks of bold and timing of BOLD, 
[r_PeakandTiming_b, pval_b] = corrcoef(mean(maxTIMES1_bsession2), mean(maxTIMES1id_bsession2));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_b(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_b(1,2));

[r_PeakandTiming_y, pval_y] = corrcoef(mean(maxTIMES2_ysession2), mean(maxTIMES2id_ysession2));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_y(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_y(1,2));



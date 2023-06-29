%close all; clear all;
addpath(fullfile(pwd, '/programs'))

% Anesthesia1st 
datapath_session3rd = fullfile(pwd, '/data/session3');
listing_tph = makeList(datapath_session3rd , '*TPH*');
listing_cont = makeList(datapath_session3rd , '*WT*');

%% TPHSKK
% blue
timeseries_TPHB = extGroupTSROI(listing_tph, 'blue', 'tph');
% Yellow
timeseries_TPHY = extGroupTSROI(listing_tph, 'yellow', 'tph');
BOLDresponse_tphb = extBOLDresponse(timeseries_TPHB);
BOLDresponse_tphy = extBOLDresponse(timeseries_TPHY);


%% control
% blue
timeseries_CNTB = extGroupTSROI(listing_cont, 'blue', 'cont');
% yellow
timeseries_CNTY = extGroupTSROI(listing_cont, 'yellow', 'cont');
BOLDresponse_contb = extBOLDresponse(timeseries_CNTB);
BOLDresponse_conty = extBOLDresponse(timeseries_CNTY);


% load ROI.name.
roipath   = fullfile(pwd, '/ROIs');
[ROIname] = ExtROIname(roipath);

% result path
% result path
resultpath_tph_session3  = fullfile(pwd, '/figures/FigureS5/session3/TPH');
resultpath_cont_session3 = fullfile(pwd, '/figures/FigureS5/session3/CONT');
resultpath_vsb_session3  = fullfile(pwd, '/figures/FigureS5/session3/TPHvsCont_blue');
resultpath_vsy_session3  = fullfile(pwd, '/figures/FigureS5/session3/TPHvsCont_yellow');
mkdir(resultpath_tph_session3);
mkdir(resultpath_cont_session3);
mkdir(resultpath_vsb_session3);
mkdir(resultpath_vsy_session3);

stim = 1:5;

% visualize and save the tph group
colors = {'g', 'b'};
[AUC_TPH_B_session3, AUC_TPH_Y_session3, meanTIME_TPH_B_session3, meanTIME_TPH_Y_session3,  maxTIMES_TPH_B_session3, maxTIMES_TPH_Y_session3, Pvalus_TPH_BvsY_session3] = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, resultpath_tph_session3,colors, 'same', stim);
% visualize and save the cont group
colors = {'k', 'r'};
[AUC_CONT_B_session3, AUC_CONT_Y_session3, meanTIME_CONT_B_session3, meanTIME_CONT_Y_session3, maxTIMES_CONT_B_session3, maxTIMES_CONT_Y_session3, Pvalus_CONT_BvsY_session3]  = notvisualizeBOLDresponses(BOLDresponse_contb, BOLDresponse_conty, ROIname, resultpath_cont_session3, colors, 'same', stim);

% visualize and save the tph vs cont, blue stimulation
colors = {'r', 'b'};
[AUC_TPH_B_session3, AUC_CONT_B_session3, meanTIME_TPH_B_session3, meanTIME_CONT_B_session3, maxTIMES_TPH_B_session3, maxTIMES_CONT_B_session3, Pvalus_TPHvsCONT_b_session3]  = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_contb, ROIname, resultpath_vsb_session3, colors, 'different', stim);

% visualize and save the cont group
colors = {'k', 'g'};
[AUC_TPH_Y_session3, AUC_CONT_Y_session3, meanTIME_TPH_Y_session3, meanTIME_CONT_Y_session3, maxTIMES_TPH_Y_session3, maxTIMES_CONT_Y_session3, Pvalus_TPHvsCONT_y_session3] = notvisualizeBOLDresponses(BOLDresponse_tphy, BOLDresponse_conty, ROIname, resultpath_vsy_session3, colors,'different', stim);

close all;

%% visualization of statistical results.
% AUC of %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_TPH_B_session3 - AUC_TPH_Y_session3);
MC_pvals_AUC             = fdr_bh(pvals_AUC);

% mean BOLD signals,
[sig_meanB, pvals_meanB] = ttest2(meanTIME_TPH_B_session3,meanTIME_CONT_B_session3);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB);

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_TPH_B_session3 - maxTIMES_TPH_Y_session3);
MC_pvals_peakBOLD        = fdr_bh(pvals_peakB);

% %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_CONT_B_session3 - AUC_CONT_Y_session3);
MC_pvals_AUC             = fdr_bh(pvals_AUC);

% AUC BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_CONT_B_session3 - meanTIME_CONT_Y_session3);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB);

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_CONT_B_session3 - maxTIMES_CONT_Y_session3);

% visualization of statistical tests on 
timedur = 40;

% maxAUC and maxTIMES, B and Y, transgenic
[maxTIMES1_bsession3, maxTIMES2_ysession3, maxTIMES1id_bsession3, maxTIMES2id_ysession3, maxAUC1_bsession3, maxAUC2_ysession3, maxAUC1id_bsession3, maxAUC2nd_ysession3] = peaksearchBOLDresponses2(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, timedur, stim);
% maxAUC and maxTIMES, B and Y, control
[maxTIMES1_CONTsession3, maxTIMES2_CONTsession3, maxTIMES1id_CONTsession3, maxTIMES2id_CONTsession3, maxAUC1_CONTsession3, maxAUC2_CONTsession3, maxAUC1id_CONTsession3, maxAUC2nd_CONTsession3] = peaksearchBOLDresponses2(BOLDresponse_contb, BOLDresponse_conty, ROIname, timedur, stim);

% correlation between peaks of bold and timing of BOLD, 
[r_PeakandTiming_b, pval_b] = corrcoef(mean(maxTIMES1_bsession3), mean(maxTIMES1id_bsession3));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_b(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_b(1,2));

[r_PeakandTiming_y, pval_y] = corrcoef(mean(maxTIMES2_ysession3), mean(maxTIMES2id_ysession3));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_y(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_y(1,2));


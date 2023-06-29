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
resultpath_tph = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia1st_TS/TPH';
resultpath_cont = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia1st_TS/Cont';
resultpath_vsb = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia1st_TS/TPHvsCont_blue';
resultpath_vsy = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia1st_TS/TPHvsCont_yellow';
mkdir(resultpath_tph);
mkdir(resultpath_cont);
mkdir(resultpath_vsb);
mkdir(resultpath_vsy);

stim = 1:5;

% visualize and save the tph group
colors = {'g', 'b'};
[AUC_TPH_B_ane1st, AUC_TPH_Y_ane1st, meanTIME_TPH_B_ane1st, meanTIME_TPH_Y_ane1st,  maxTIMES_TPH_B_ane1st, maxTIMES_TPH_Y_ane1st, Pvalus_TPH_BvsY_ane1st] = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, resultpath_tph,colors, 'same', stim);
% visualize and save the cont group
colors = {'k', 'r'};
[AUC_CONT_B_ane1st, AUC_CONT_Y_ane1st, meanTIME_CONT_B_ane1st, meanTIME_CONT_Y_ane1st, maxTIMES_CONT_B_ane1st, maxTIMES_CONT_Y_ane1st, Pvalus_CONT_BvsY_ane1st]  = notvisualizeBOLDresponses(BOLDresponse_contb, BOLDresponse_conty, ROIname, resultpath_cont, colors, 'same', stim);

% visualize and save the tph vs cont, blue stimulation
colors = {'r', 'b'};
[AUC_TPH_B_ane1st, AUC_CONT_B_ane1st, meanTIME_TPH_B_ane1st, meanTIME_CONT_B_ane1st, maxTIMES_TPH_B_ane1st, maxTIMES_CONT_B_ane1st, Pvalus_TPHvsCONT_b_ane1st]  = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_contb, ROIname, resultpath_vsb, colors, 'different', stim);

% visualize and save the cont group
colors = {'k', 'g'};
[AUC_TPH_Y_ane1st, AUC_CONT_Y_ane1st, meanTIME_TPH_Y_ane1st, meanTIME_CONT_Y_ane1st, maxTIMES_TPH_Y_ane1st, maxTIMES_CONT_Y_ane1st, Pvalus_TPHvsCONT_y_ane1st] = notvisualizeBOLDresponses(BOLDresponse_tphy, BOLDresponse_conty, ROIname, resultpath_vsy, colors,'different', stim);

close all;

%% visualization of statistical results.
% AUC of %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_TPH_B_ane1st - AUC_TPH_Y_ane1st);
MC_pvals_AUC             = fdr_bh(pvals_AUC);

% mean BOLD signals,
[sig_meanB, pvals_meanB] = ttest2(meanTIME_TPH_B_ane1st,meanTIME_CONT_B_ane1st);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB);

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_TPH_B_ane1st - maxTIMES_TPH_Y_ane1st);
MC_pvals_peakBOLD        = fdr_bh(pvals_peakB);

% %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_CONT_B_ane1st - AUC_CONT_Y_ane1st);
MC_pvals_AUC             = fdr_bh(pvals_AUC);

% AUC BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_CONT_B_ane1st - meanTIME_CONT_Y_ane1st);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB);

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_CONT_B_ane1st - maxTIMES_CONT_Y_ane1st);

% visualization of statistical tests on 
timedur = 40;

% maxAUC and maxTIMES, B and Y, transgenic
[maxTIMES1_bane1st, maxTIMES2_yane1st, maxTIMES1id_bane1st, maxTIMES2id_yane1st, maxAUC1_bane1st, maxAUC2_yane1st, maxAUC1id_bane1st, maxAUC2nd_yane1st] = peaksearchBOLDresponses2(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, timedur, stim);
% maxAUC and maxTIMES, B and Y, control
[maxTIMES1_CONTane1st, maxTIMES2_CONTane1st, maxTIMES1id_CONTane1st, maxTIMES2id_CONTane1st, maxAUC1_CONTane1st, maxAUC2_CONTane1st, maxAUC1id_CONTane1st, maxAUC2nd_CONTane1st] = peaksearchBOLDresponses2(BOLDresponse_contb, BOLDresponse_conty, ROIname, timedur, stim);

% correlation between peaks of bold and timing of BOLD, 
[r_PeakandTiming_b, pval_b] = corrcoef(mean(maxTIMES1_bane1st), mean(maxTIMES1id_bane1st));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_b(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_b(1,2));

[r_PeakandTiming_y, pval_y] = corrcoef(mean(maxTIMES2_yane1st), mean(maxTIMES2id_yane1st));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_y(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_y(1,2));


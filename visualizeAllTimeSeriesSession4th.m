%close all; clear all;

addpath(fullfile(pwd, '/programs'))

% Anesthesia2nd 
datapath_session4th = fullfile(pwd, '/data/session4');
listing_tph = makeList(datapath_session4th , '*TPH*');
listing_cont = makeList(datapath_session4th , '*WT*');

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

stim = 1:4;

% load ROI.name.
roipath   = fullfile(pwd, '/ROIs');
[ROIname] = ExtROIname(roipath);

% result path
resultpath_tph = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia2nd_TS/TPH';
resultpath_cont = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia2nd_TS/Cont';
resultpath_vsb = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia2nd_TS/TPHvsCont_blue';
resultpath_vsy = '/Volumes/HD-ADU3/tphskk/Results/Anesthesia/Anesthesia2nd_TS/TPHvsCont_yellow';
mkdir(resultpath_tph);
mkdir(resultpath_cont);
mkdir(resultpath_vsb);
mkdir(resultpath_vsy);

% visualize and save the tph group
colors = {'g', 'b'};
[AUC_TPH_B_ane2nd, AUC_TPH_Y_ane2nd, meanTIME_TPH_B_ane2nd, meanTIME_TPH_Y_ane2nd,  maxTIMES_TPH_B_ane2nd, maxTIMES_TPH_Y_ane2nd, Pvalus_TPH_BvsY_ane2nd] = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, resultpath_tph,colors, 'same', stim);
% visualize and save the cont group
colors = {'k', 'r'};
[AUC_CONT_B_ane2nd, AUC_CONT_Y_ane2nd, meanTIME_CONT_B_ane2nd, meanTIME_CONT_Y_ane2nd, maxTIMES_CONT_B_ane2nd, maxTIMES_CONT_Y_ane2nd, Pvalus_CONT_BvsY_ane2nd]  = notvisualizeBOLDresponses(BOLDresponse_contb, BOLDresponse_conty, ROIname, resultpath_cont, colors, 'same', stim);

% visualize and save the tph vs cont, blue stimulation
colors = {'r', 'b'};
[AUC_TPH_B_ane2nd, AUC_CONT_B_ane2nd, meanTIME_TPH_B_ane2nd, meanTIME_CONT_B_ane2nd, maxTIMES_TPH_B_ane2nd, maxTIMES_CONT_B_ane2nd, Pvalus_TPHvsCONT_b_ane2nd]  = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_contb, ROIname, resultpath_vsb, colors, 'different', stim);

% visualize and save the cont group
colors = {'k', 'g'};
[AUC_TPH_Y_ane2nd, AUC_CONT_Y_ane2nd, meanTIME_TPH_Y_ane2nd, meanTIME_CONT_Y_ane2nd, maxTIMES_TPH_Y_ane2nd, maxTIMES_CONT_Y_ane2nd, Pvalus_TPHvsCONT_y_ane2nd] = notvisualizeBOLDresponses(BOLDresponse_tphy, BOLDresponse_conty, ROIname, resultpath_vsy, colors,'different', stim);

close all;

%% visualization of statistical results.
% AUC of %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_TPH_B_ane2nd - AUC_TPH_Y_ane2nd);
MC_pvals_AUC             = fdr_bh(pvals_AUC);

% mean BOLD signals,
[sig_meanB, pvals_meanB] = ttest2(meanTIME_TPH_B_ane2nd,meanTIME_CONT_B_ane2nd);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB);

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_TPH_B_ane2nd - maxTIMES_TPH_Y_ane2nd);
MC_pvals_peakBOLD        = fdr_bh(pvals_peakB);

% %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_CONT_B_ane2nd - AUC_CONT_Y_ane2nd);
MC_pvals_AUC             = fdr_bh(pvals_AUC);

% AUC BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_CONT_B_ane2nd - meanTIME_CONT_Y_ane2nd);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB);

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_CONT_B_ane2nd - maxTIMES_CONT_Y_ane2nd);


% visualization of statistical tests on 
timedur = 40;

% maxAUC and maxTIMES, B and Y, transgenic
[maxTIMES1_bane2nd, maxTIMES2_yane2nd, maxTIMES1id_bane2nd, maxTIMES2id_yane2nd, maxAUC1_bane2nd, maxAUC2_yane2nd, maxAUC1id_bane2nd, maxAUC2nd_yane2nd] = peaksearchBOLDresponses2(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, timedur, stim);
% maxAUC and maxTIMES, B and Y, control
[maxTIMES1_CONTane2nd, maxTIMES2_CONTane2nd, maxTIMES1id_CONTane2nd, maxTIMES2id_CONTane2nd, maxAUC1_CONTane2nd, maxAUC2_CONTane2nd, maxAUC1id_CONTane2nd, maxAUC2nd_CONTane2nd] = peaksearchBOLDresponses2(BOLDresponse_contb, BOLDresponse_conty, ROIname, timedur, stim);

% correlation between peaks of bold and timing of BOLD, 
[r_PeakandTiming_b, pval_b] = corrcoef(mean(maxTIMES1_bane2nd), mean(maxTIMES1id_bane2nd));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_b(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_b(1,2));

[r_PeakandTiming_y, pval_y] = corrcoef(mean(maxTIMES2_yane2nd), mean(maxTIMES2id_yane2nd));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_y(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_y(1,2));



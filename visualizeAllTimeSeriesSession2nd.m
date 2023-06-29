% this program is meant to caluclate the MIX1 data,
%
%
%
%
% by Hiro Taiyo Hamada,

addpath(fullfile(pwd, '/programs'))

% Mix1stDay 
datapath_session2nd     = fullfile(pwd, '/data/session2');
listing_tph_mix1st  = makeList(datapath_session2nd , '*TPH*');
listing_cont_mix1st = makeList(datapath_session2nd , '*WT*');

%% TPHSKK
% blue
timeseries_TPHB_mix1st = extGroupTSROI(listing_tph_mix1st, 'blue', 'tph');
% Yellow
timeseries_TPHY_mix1st = extGroupTSROI(listing_tph_mix1st, 'yellow', 'tph');
BOLDresponse_tphb_mix1st = extBOLDresponse(timeseries_TPHB_mix1st);
BOLDresponse_tphy_mix1st = extBOLDresponse(timeseries_TPHY_mix1st);


%% control
% blue
timeseries_CNTB_mix1st    = extGroupTSROI(listing_cont_mix1st, 'blue', 'cont');
% yellow
timeseries_CNTY_mix1st    = extGroupTSROI(listing_cont_mix1st, 'yellow', 'cont');
BOLDresponse_contb_mix1st = extBOLDresponse(timeseries_CNTB_mix1st);
BOLDresponse_conty_mix1st = extBOLDresponse(timeseries_CNTY_mix1st);


% load ROI.name.
roipath   = fullfile(pwd, '/ROIs');
[ROIname] = ExtROIname(roipath);

resultpath_tph_mix1st  = '/Volumes/HD-ADU3/tphskk/Results/MIX/mix1st_TS/TPH';
resultpath_cont_mix1st = '/Volumes/HD-ADU3/tphskk/Results/MIX/mix1st_TS/Cont';
resultpath_vsb_mix1st  = '/Volumes/HD-ADU3/tphskk/Results/MIX/mix1st_TS/TPHvsCont_blue';
resultpath_vsy_mix1st  = '/Volumes/HD-ADU3/tphskk/tphskk/Results/MIX/mix1st_TS/TPHvsCont_yellow';
mkdir(resultpath_tph_mix1st);
mkdir(resultpath_cont_mix1st);
mkdir(resultpath_vsb_mix1st);
mkdir(resultpath_vsy_mix1st);

stim = 1:5;

% visualize and save the tph group
colors = {'g', 'b'};
[AUC_TPH_B_mix1st, AUC_TPH_Y_mix1st, meanTIME_TPH_B_mix1st, meanTIME_TPH_Y_mix1st,  maxTIMES_TPH_B_mix1st, maxTIMES_TPH_Y_mix1st, Pvalus_TPH_BvsY_mix1st] = notvisualizeBOLDresponses(BOLDresponse_tphb_mix1st, BOLDresponse_tphy_mix1st, ROIname, resultpath_tph_mix1st,colors, 'same', stim);
% visualize and save the cont group
colors = {'k', 'r'};
[AUC_CONT_B_mix1st, AUC_CONT_Y_mix1st, meanTIME_CONT_B_mix1st, meanTIME_CONT_Y_mix1st, maxTIMES_CONT_B_mix1st, maxTIMES_CONT_Y_mix1st, Pvalus_CONT_BvsY_mix1st]  = notvisualizeBOLDresponses(BOLDresponse_contb_mix1st, BOLDresponse_conty_mix1st, ROIname, resultpath_cont_mix1st, colors, 'same', stim);

% visualize and save the tph vs cont, blue stimulation
colors = {'r', 'b'};
[AUC_TPH_B_mix1st, AUC_CONT_B_mix1st, meanTIME_TPH_B_mix1st, meanTIME_CONT_B_mix1st, maxTIMES_TPH_B_mix1st, maxTIMES_CONT_B_mix1st, Pvalus_TPHvsCONT_b_mix1st]  = notvisualizeBOLDresponses(BOLDresponse_tphb_mix1st, BOLDresponse_contb_mix1st, ROIname, resultpath_vsb_mix1st, colors, 'different', stim);

% visualize and save the cont group
colors = {'k', 'g'};
[AUC_TPH_Y_mix1st, AUC_CONT_Y_mix1st, meanTIME_TPH_Y_mix1st, meanTIME_CONT_Y_mix1st, maxTIMES_TPH_Y_mix1st, maxTIMES_CONT_Y_mix1st, Pvalus_TPHvsCONT_y_mix1st] = notvisualizeBOLDresponses(BOLDresponse_tphy_mix1st, BOLDresponse_conty_mix1st, ROIname, resultpath_vsy_mix1st, colors,'different', stim);

close all;

%% visualization of statistical results.
% AUC of %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_TPH_B_mix1st - AUC_TPH_Y_mix1st);
MC_pvals_AUC             = fdr_bh(pvals_AUC)

% mean BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_TPH_B_mix1st - meanTIME_TPH_Y_mix1st);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB)

% Peaks BOLD signals, 
[sig_peakB1st, pvals_peakB1st] = ttest(maxTIMES_TPH_B_mix1st - maxTIMES_TPH_Y_mix1st);
MC_pvals_peakBOLD1st        = fdr_bh(pvals_peakB1st)

% %BOLD signals,
[sig_AUC, pvals_AUC]     = ttest(AUC_CONT_B_mix1st - AUC_CONT_Y_mix1st);
MC_pvals_AUC             = fdr_bh(pvals_AUC)

% AUC BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_CONT_B_mix1st - meanTIME_CONT_Y_mix1st);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB)

% Peaks BOLD signals, 
[sig_peakB, pvals_peakB] = ttest(maxTIMES_CONT_B_mix1st - maxTIMES_CONT_Y_mix1st);
MC_pvals_peakBOLD        = fdr_bh(pvals_peakB)


% visualization of statistical tests on 
timedur = 40;
% maxAUC and maxTIMES, B and Y, transgenic
[maxTIMES1_bmix1st, maxTIMES2_ymix1st, maxTIMES1id_bmix1st, maxTIMES2id_ymix1st, maxAUC1_bmix1st, maxAUC2_ymix1st, maxAUC1id_bmix1st, maxAUC2nd_ymix1st] = peaksearchBOLDresponses(BOLDresponse_tphb_mix1st, BOLDresponse_tphy_mix1st, ROIname, timedur, stim);
%[maxTIMES1_bmix1st2, maxTIMES2_ymix1st2, maxTIMES1id_bmix1st2, maxTIMES2id_ymix1st2, maxAUC1_bmix1st2, maxAUC2_ymix1st2, maxAUC1id_bmix1st2, maxAUC2nd_ymix1st2] = peaksearchBOLDresponses2(BOLDresponse_tphb_mix1st, BOLDresponse_tphy_mix1st, ROIname, timedur);

% maxAUC and maxTIMES, B and Y, control
[maxTIMES1_CONTmix1st, maxTIMES2_CONTmix1st, maxTIMES1id_CONTmix1st, maxTIMES2id_CONTmix1st, maxAUC1_CONTmix1st, maxAUC2_CONTmix1st, maxAUC1id_CONTmix1st, maxAUC2nd_CONTmix1st] = peaksearchBOLDresponses(BOLDresponse_contb_mix1st, BOLDresponse_conty_mix1st, ROIname, timedur, stim);


[a,b] = ttest(maxAUC1_bmix1st - maxAUC2_ymix1st)
[a,b] = ttest(maxAUC1_CONTmix1st - maxAUC2_CONTmix1st)
[a,b] = ttest2(maxAUC1_bmix1st - maxAUC2_ymix1st, maxAUC1_CONTmix1st - maxAUC2_CONTmix1st)


mean(maxTIMES1id_bmix1st);
mean(maxTIMES2id_ymix1st);
mean(maxTIMES1id_CONTmix1st);
mean(maxTIMES2id_CONTmix1st);


(maxAUC1id_bmix1st - maxTIMES1id_bmix1st);
(maxAUC2nd_ymix1st - maxTIMES2id_ymix1st);
(maxAUC1id_CONTmix1st - maxTIMES1id_CONTmix1st);
(maxAUC2nd_CONTmix1st - maxTIMES2id_CONTmix1st);

mean(maxAUC1id_bmix1st - maxTIMES1id_bmix1st);
mean(maxAUC2nd_ymix1st - maxTIMES2id_ymix1st);
mean(maxAUC1id_CONTmix1st - maxTIMES1id_CONTmix1st);
mean(maxAUC2nd_CONTmix1st - maxTIMES2id_CONTmix1st);


% correlation between peaks of bold and timing of BOLD, 
[r_PeakandTiming_b, pval_b] = corrcoef(mean(maxTIMES1_bmix1st), mean(maxTIMES1id_bmix1st));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_b(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_b(1,2));

[r_PeakandTiming_y, pval_y] = corrcoef(mean(maxTIMES2_ymix1st), mean(maxTIMES2id_ymix1st));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_y(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_y(1,2));



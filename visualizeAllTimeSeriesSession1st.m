% This program is intended to extract the 
%
% 
% Figure 2, Supplementary Figure S5, S6.
%
%
% by Hiro Taiyo Hamada, Araya Inc.

clear all; close all;


addpath(fullfile(pwd, '/programs'))

% session1 
datapath = fullfile(pwd, '/data/session1');
listing_tph = makeList(datapath, '*TPH*');
listing_cont = makeList(datapath, '*WT*');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extraction of time series
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
resultpath_tphBlue   = fullfile(pwd, '/figures/FigureS5/Blue');
resultpath_tphYellow = fullfile(pwd, '/figures/FigureS5/Yellow');

resultpath_tph  = fullfile(pwd, '/figures/FigureS5/TPH');
resultpath_cont = fullfile(pwd, '/figures/FigureS5/CONT');
resultpath_vsb  = fullfile(pwd, '/figures/FigureS5/TPHvsCont_blue');
resultpath_vsy  = fullfile(pwd, '/figures/FigureS5/TPHvsCont_yellow');
mkdir(resultpath_tph);
mkdir(resultpath_cont);
mkdir(resultpath_vsb);
mkdir(resultpath_vsy);

% stimulation
stim = 1:5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualize and save the tph group
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract mean timeseries TPHSKK blue stimulation vs. yellow stimulation
% Figure 2 
colors = {[0.9216,0.7294,0.1020], [0, 0.8, 0.8]};
[AUC_TPH_B, AUC_TPH_Y, meanTIME_TPH_B_session1, meanTIME_TPH_Y_session1,  maxTIMES_TPH_B, maxTIMES_TPH_Y, Pvalus_TPH_BvsY]        = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, resultpath_tph,colors,'same', stim);

% extract mean timeseries TPHSKK blue stimulation vs. yellow stimulation
%[AUC_TPH_B2, AUC_TPH_Y2, meanTIME_TPH_B_session12, meanTIME_TPH_Y_session12,  maxTIMES_TPH_B2, maxTIMES_TPH_Y2, Pvalus_TPH_BvsY2] = notvisualizeBOLDresponses2(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, resultpath_tph,colors,'same', stim);


% visualize and save the cont group

% extract mean timeseries CONT blue stimulation vs. yellow stimulation
% black and green
colors = {[0.1, 0.1, 0.1], [0, 0.5, 0]};
[AUC_CONT_B, AUC_CONT_Y, meanTIME_CONT_B_session1, meanTIME_CONT_Y_session1, maxTIMES_CONT_B, maxTIMES_CONT_Y, Pvalus_CONT_BvsY] = notvisualizeBOLDresponses(BOLDresponse_contb, BOLDresponse_conty, ROIname, resultpath_cont, colors,'same', stim);


% visualize and save the tph vs cont, blue stimulation
% extract mean timeseries TPHSKK blue stimulation vs. CONT blue stimulation
% Supplementary Figure S5
colors = {'r', 'b'};
[AUC_TPH_B, AUC_CONT_B, meanTIME_TPH_B_session1, meanTIME_CONT_B_session1, maxTIMES_TPH_B, maxTIMES_CONT_B, Pvalus_TPHvsCONT_b] = notvisualizeBOLDresponses(BOLDresponse_tphb, BOLDresponse_contb, ROIname, resultpath_vsb, colors,'different', stim);
%[AUC_TPH_B2, AUC_CONT_B2, meanTIME_TPH_B_session12, meanTIME_CONT_B_session12, maxTIMES_TPH_B2, maxTIMES_CONT_B2, Pvalus_TPHvsCONT_b2] = notvisualizeBOLDresponses2(BOLDresponse_tphb, BOLDresponse_contb, ROIname, resultpath_vsb, colors,'different', stim);


% visualize and save the cont group
% Supplementary Figure S6
colors = {'k', 'g'};
[AUC_TPH_Y, AUC_CONT_Y, meanTIME_TPH_Y_session1, meanTIME_CONT_Y_session1, maxTIMES_TPH_Y, maxTIMES_CONT_Y, Pvalus_TPHvsCONT_y] = visualizeBOLDresponses(BOLDresponse_tphy, BOLDresponse_conty, ROIname, resultpath_vsy, colors,'different', stim);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% contrast between mean values of BOLD signals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% visualization of statistical results.

% mean BOLD signals, TPH Blue vs Yellow
% Figure 2
[sig_meanB, pvals_meanB] = ttest(meanTIME_TPH_B_session1 - meanTIME_TPH_Y_session1);
MC_pvals_meanBOLD        = fdr_bh(pvals_meanB)

% mean BOLD signals, CONT Blue vs Yellow
[sig_AUC, pvals_AUC]     = ttest(AUC_CONT_B - AUC_CONT_Y);
MC_pvals_AUC             = fdr_bh(pvals_AUC)

% mean BOLD signals, TPH Blue vs. CONT Blue
% Supplementary Figure S5
[sig_meanBY, pvals_meanBY] = ttest2(meanTIME_TPH_B_session1, meanTIME_CONT_B_session1);
MC_pvals_meanBOLDBY        = fdr_bh(pvals_meanBY)
ROIname(MC_pvals_meanBOLDBY)

% mean BOLD signals, TPH Yellow vs. CONT Yellow
% Supplementary Figure S6
[sig_meanY, pvals_meanY] = ttest2(meanTIME_TPH_Y_session1, meanTIME_CONT_Y_session1);
[MC_sig_meanBOLDY,~,~,MC_pval_meanBOLDY] = fdr_bh(pvals_meanY)
ROIname(MC_sig_meanBOLDY)


%% peaks loc and max AUC of statistical results.
timedur = 40;
% maxAUC and maxTIMES, B and Y, transgenic

[maxTIMES1_bsession1, maxTIMES2_ysession1, maxTIMES1id_bsession1, maxTIMES2id_ysession1, maxAUC1_bsession1, maxAUC2_ysession1, maxAUC1id_bsession1, maxAUC_ysession1]                         = peaksearchBOLDresponses(BOLDresponse_tphb, BOLDresponse_tphy, ROIname, timedur, stim);

% maxAUC and maxTIMES, B and Y, control
[maxTIMES1_CONTsession1, maxTIMES2_CONTsession1, maxTIMES1id_CONTsession1, maxTIMES2id_CONTsession1, maxAUC1_CONTsession1, maxAUC2_CONTsession1, maxAUC1id_CONTsession1, maxAUC_CONTsession1] = peaksearchBOLDresponses(BOLDresponse_contb, BOLDresponse_conty, ROIname, timedur, stim);

% correlation between peaks of bold and timing of BOLD, 
[r_PeakandTiming_b, pval_b] = corrcoef(mean(maxTIMES1_bsession1), mean(maxTIMES1id_bsession1));
fprintf('correlation between peaks and timing: r = %f \n', r_PeakandTiming_b(1,2));
fprintf('correlation between peaks and timing: pval = %f \n', pval_b(1,2));
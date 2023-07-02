% This program is to contrast between session 3 and session4.
%
%
%
% by Hiro Taiyo Hamada, Araya Inc.

clear all; close all;

% extract time series from session 3
visualizeAllTimeSeriesSession3rd
% extract time series from session 4
visualizeAllTimeSeriesSession4th

%%% statistical tests on differences

%% Means of %BOLD
%% blue vs yellow difference, TPH,
[sig_meanT_tphby, b_meanT_tphby]  = ttest2(meanTIME_TPH_B_session3 - meanTIME_TPH_B_session4, meanTIME_TPH_Y_session3 - meanTIME_TPH_Y_session4);
fprintf('Mean of blue stimulation of transgenic mice vs yello stimulation between session 3 and session 4 \n');
ROIname(fdr_bh(b_meanT_tphby))

%% blue vs yellow difference, WT, 
[sig_meanT_WTby, b_meanT_WTby]    = ttest2(meanTIME_CONT_B_session3 - meanTIME_CONT_B_session4, meanTIME_CONT_Y_session3 - meanTIME_CONT_Y_session4);
fprintf('Mean of blue stimulation of wild-type mice vs yello stimulation between session 3 and session 4 \n');
fdr_bh(b_meanT_WTby)

%% TPH
%% blue, TPH, session 3 vs. 4
[sig_meanT_tphb, b_meanT_tphb]    = ttest(meanTIME_TPH_B_session3 - meanTIME_TPH_B_session4);
fprintf('mean BOLD of blue stimulation of transgenic mice \n');
[~,~,~, pval_b_meanT_tphb] = fdr_bh(b_meanT_tphb)
ROIname(fdr_bh(b_meanT_tphb))

%% blue, CONT, session 3 vs. 4
[sig_meanT_tphb, b_meanT_tphb] = ttest(meanTIME_CONT_B_session3 - meanTIME_CONT_B_session4);
fprintf('mean BOLD of blue stimulation of wild-type mice \n');
fdr_bh(b_meanT_tphb)
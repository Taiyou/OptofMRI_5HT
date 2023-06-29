

addpath(fullfile(pwd, '/programs'))


%% contrast between anesthesia 1st and 2nd
% Anesthesia 1st
datapath = fullfile(pwd, '/data/session3');
listing_tph1 = makeList(datapath1, '*TPH*');
listing_cont1 = makeList(datapath1, '*WT*');

% Anesthesia 2nd
datapath = fullfile(pwd, '/data/session4');
listing_tph2 = makeList(datapath2, '*TPH*');
listing_cont2 = makeList(datapath2, '*WT*');

%% Anesthesia 1st
%% transgenic
% blue
timeseries_TPHB1 = extGroupTSROI(listing_tph1, 'blue', 'tph');
% Yellow
timeseries_TPHY1 = extGroupTSROI(listing_tph1, 'yellow', 'tph');
BOLDresponse_tphb1 = extBOLDresponse(timeseries_TPHB1);
BOLDresponse_tphy1 = extBOLDresponse(timeseries_TPHY1);

%% control
% blue
timeseries_CNTB1 = extGroupTSROI(listing_cont1, 'blue', 'cont');
% yellow
timeseries_CNTY1 = extGroupTSROI(listing_cont1, 'yellow', 'cont');
BOLDresponse_contb1 = extBOLDresponse(timeseries_CNTB1);
BOLDresponse_conty1 = extBOLDresponse(timeseries_CNTY1);

%% Awake 2nd
%% TPHSKK
% blue
timeseries_TPHB2 = extGroupTSROI(listing_tph2, 'blue', 'tph');
% Yellow
timeseries_TPHY2 = extGroupTSROI(listing_tph2, 'yellow', 'tph');
BOLDresponse_tphb2 = extBOLDresponse(timeseries_TPHB2);
BOLDresponse_tphy2 = extBOLDresponse(timeseries_TPHY2);

%% control
% blue
timeseries_CNTB2 = extGroupTSROI(listing_cont2, 'blue', 'cont');
% yellow
timeseries_CNTY2 = extGroupTSROI(listing_cont2, 'yellow', 'cont');
BOLDresponse_contb2 = extBOLDresponse(timeseries_CNTB2);
BOLDresponse_conty2 = extBOLDresponse(timeseries_CNTY2);


% load ROI.name.
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));

% result path
resultpath_vsb = fullfile(pwd, '/figures/FigureS11/TPHvsCont_blue');
resultpath_vsy = fullfile(pwd, '/figures/FigureS11/TPHvsCont_yellow');
mkdir(resultpath_vsb);
mkdir(resultpath_vsy);

stim = 1:5;

% visualize and save the tph group, 1st and 2nd days, blue stimulation
colors = {'b', 'm'};
[AUC_TPH_B_ane1st, AUC_TPH_B_ane2nd, meanTIME_TPH_B_ane1st, meanTIME_TPH_B_ane2nd,  maxTIMES_TPH_B_ane1st, maxTIMES_TPH_B_ane2nd, Pvalus_TPH_B1stvs2nd_ane] = visualizeBOLDresponses(BOLDresponse_tphb1, BOLDresponse_tphb2, ROIname, resultpath_vsb, colors, 'same', stim);
% visualize and save the tph group, 1st and 2nd days, yellow stimulation
colors = {[0.7294, 0.3333, 0.8275], [0.9216,0.7294,0.1020]};
[AUC_TPH_Y_ane1st, AUC_CONT_Y_ane2nd, meanTIME_TPH_Y_ane1st, meanTIME_TPH_Y_ane2nd, maxTIMES_TPH_Y_ane1st, maxTIMES_TPH_Y_ane2nd,  Pvalus_TPH_Y1stvs2nd_ane] = notvisualizeBOLDresponses(BOLDresponse_tphy1, BOLDresponse_tphy2, ROIname, resultpath_vsy, colors,'same', stim);


%% visualization of statistical results.
% mean BOLD signals,
[sig_meanB, pvals_meanB] = ttest(meanTIME_TPH_B_ane1st, meanTIME_TPH_B_ane2nd);
MC_sig_meanBOLD_B      = fdr_bh(pvals_meanB)
ROIname(MC_sig_meanBOLD_B)
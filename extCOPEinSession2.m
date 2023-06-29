% This program is intended to extract contrast of parameter estimate (COPE) 
%clear all; close all;

% set ROIs info% list of the data
% session2, tph blue stimulation,
datapath_tph_blue = fullfile(pwd, '/data/COPEResults/session2/BLUE/TPH');
ContrastList_session2_tphblue = makeList(datapath_tph_blue, 'TPH*.nii');
% session2, tph yellow stimulation,
datapath_tph_yellow = fullfile(pwd, '/data/COPEResults/session2/YELLOW/TPH');
ContrastList_session2_tphyellow = makeList(datapath_tph_yellow, 'TPH*.nii');
% session2, cont blue stimulation,
datapath_cont_blue = fullfile(pwd, '/data/COPEResults/session2/BLUE/CONT');
ContrastList_session2_contblue = makeList(datapath_cont_blue, 'WT*.nii');
% session2, cont yellow stimulation,
datapath_cont_yellow = fullfile(pwd, '/data/COPEResults/session2/YELLOW/CONT');
ContrastList_session2_contyellow = makeList(datapath_cont_yellow, 'WT*.nii');

storagePath = fullfile(pwd, '/data/COPEResults/session2');

% ROI extraction
ROIpath           = '/ROIs';
ROIlist           = makeList(fullfile(pwd, ROIpath), 'ID*.nii');
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));
nROI = length(ROIname);

% extraction of contrast data
[COPE_session2_tph_blue] = extCOPE(ContrastList_session2_tphblue,ROIlist);
[COPE_session2_tph_yellow] = extCOPE(ContrastList_session2_tphyellow, ROIlist);
[COPE_session2_cont_blue] = extCOPE(ContrastList_session2_contblue, ROIlist);
[COPE_session2_cont_yellow] = extCOPE(ContrastList_session2_contyellow, ROIlist);

save(fullfile(storagePath,'tphB_session2.mat'),'COPE_session2_tph_blue');
save(fullfile(storagePath,'tphY_session2.mat'),'COPE_session2_tph_yellow');
save(fullfile(storagePath,'CONTB_session2.mat'),'COPE_session2_cont_blue');
save(fullfile(storagePath,'CONTY_session2.mat'),'COPE_session2_cont_yellow');

% comp between Tph blue vs. TPH yellow
pval_tphB_VS_tphY_session2 = COPEComp(COPE_session2_tph_blue, COPE_session2_tph_yellow, ROIname);
% comp between Tph blue vs. Cont blue
pval_tphB_VS_contB_session2 = COPEComp(COPE_session2_tph_blue, COPE_session2_cont_blue, ROIname);
% comp between Cont blue vs. Cont yellow
pval_contB_VS_contY_session2 = COPEComp(COPE_session2_cont_blue, COPE_session2_cont_yellow, ROIname);

save(fullfile(storagePath,'pval_tphB_VS_tphY_session2.mat'),'pval_tphB_VS_tphY_session2');
save(fullfile(storagePath,'pval_tphB_VS_contB_session2.mat'),'pval_tphB_VS_contB_session2');
save(fullfile(storagePath,'pval_contB_VS_contY_session2.mat'),'pval_contB_VS_contY_session2');

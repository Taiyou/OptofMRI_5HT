% This program is intended to extract contrast of parameter estimate (COPE) 
%clear all; close all;

% set ROIs info list of the data
% session1, tph blue stimulation,
datapath_tph_blue = fullfile(pwd, '/data/COPEResults/session1/BLUE/TPH/');
ContrastList_session1_tphblue = makeList(datapath_tph_blue, 'TPH*.nii');
% session1, tph yellow stimulation,
datapath_cont_blue = fullfile(pwd, '/data/COPEResults/session1/BLUE/CONT');
ContrastList_session1_contblue = makeList(datapath_cont_blue, 'WT*.nii');
% session1, cont blue stimulation,
datapath_tph_yellow = fullfile(pwd, '/data/COPEResults/session1/YELLOW/TPH');
ContrastList_session1_tphyellow = makeList(datapath_tph_yellow, 'TPH*.nii');
% session1, cont yellow stimulation,
datapath_cont_yellow = fullfile(pwd, '/data/COPEResults/session1/YELLOW/CONT');
ContrastList_session1_contyellow = makeList(datapath_cont_yellow, 'WT*.nii');

storagePath = fullfile(pwd, '/data/COPEResults/session1');

% ROI extraction
ROIpath           = '/ROIs';
ROIlist           = makeList(fullfile(pwd, ROIpath), 'ID*.nii');
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));
nROI = length(ROIname);

% extraction of contrast data
[COPE_session1_tph_blue] = extCOPE(ContrastList_session1_tphblue,ROIlist);
[COPE_session1_tph_yellow] = extCOPE(ContrastList_session1_tphyellow, ROIlist);
[COPE_session1_cont_blue] =  extCOPE(ContrastList_session1_contblue, ROIlist);
[COPE_session1_cont_yellow] = extCOPE(ContrastList_session1_contyellow, ROIlist);

save(fullfile(storagePath,'COPE_session1_tph_blue.mat'),'COPE_session1_tph_blue');
save(fullfile(storagePath,'COPE_session1_tph_yellow.mat'),'COPE_session1_tph_yellow');
save(fullfile(storagePath,'COPE_session1_cont_blue.mat'),'COPE_session1_cont_blue');
save(fullfile(storagePath,'COPE_session1_cont_yellow.mat'),'COPE_session1_cont_yellow');

% comp between Tph blue vs. TPH yellow
pval_tphB_VS_tphY_session1 = COPEComp(COPE_session1_tph_blue, COPE_session1_tph_yellow, ROIname);
% comp between Tph blue vs. Cont blue
pval_tphB_VS_contB_session1 = COPEComp(COPE_session1_tph_blue, COPE_session1_cont_blue, ROIname);
% comp between Cont blue vs. Cont yellow
pval_contB_VS_contY_session1 = COPEComp(COPE_session1_cont_blue, COPE_session1_cont_yellow, ROIname);


save(fullfile(storagePath,'pval_tphB_VS_tphY_session1.mat'),'pval_tphB_VS_tphY_session1');
save(fullfile(storagePath,'pval_tphB_VS_contB_session1.mat'),'pval_tphB_VS_contB_session1');
save(fullfile(storagePath,'pval_contB_VS_contY_session1.mat'),'pval_contB_VS_contY_session1');

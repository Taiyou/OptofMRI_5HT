% This program is intedended to contrast of peak intensity between CBV from Grandjean2019
% and %BOLD under anesthesia
%
%
% by Hiro Taiyo Hamada, Araya Inc.

close all; clear all; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data preparation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% datapath
data_path = '/Volumes/HD-ADU3/replication_optofMRI/TS';
listing_data = makeList(data_path, 'data*');
listing_design = makeList(data_path, 'design*.txt');

% roi path
roipath = '/Volumes/HD-ADU3/replication_optofMRI/ROIs';
listing_roi = makeList(roipath, 'ID*_*.nii');

% result path
resultpath = '/Volumes/HD-ADU3/replication_optofMRI/resutls';
resultpath_madino = fullfile(pwd, '/figures/FigureS14/');

% extract the BOLD signals from tph subjects.
%[BOLDtimeSeries_madino] = BOLDresponseCondition_madino(listing_data, listing_roi);
tempdata = load('/Users/hirotaiyohamada/Desktop/OptofMRI_5HT-main/Mandino2022/TS/data_madino_data.mat');
tempdata_timeseries = tempdata.timeseries;
timeseries = tempdata_timeseries {1};

%here is original data to store 
%splitName = strsplit(listing_data(1).name, '/');
%outputname = strcat(splitName{length(splitName)}, '.mat');
%resultname = fullfile(resultpath, outputname);
    
% save files
%save(resultname, 'timeseries');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% align stimulation timing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initial stimulation timing
% [Mandino et al., 2022] https://www.nature.com/articles/s41380-021-01298-5
% design matrix is from https://doi.org/10.34973/raa0-5z29
stimulation_timing = [75,85,85,75,85,85,54,75,75,75,74,74,85,85,75,75,74,75,76,75,85,85,76,76,76,75,71,85,74,75,75,75,85,76,75,67,75,75,75,78,74,85,85,76,75,75,74,75,74,85,85,77,85,85,75,67,67,74,85,85,75,75,75];

% extraction of CBV signals aligned with stimulation timing
for irun = 1:length(stimulation_timing),
    CBVtime_aligned(irun,:,:) = timeseries(irun,stimulation_timing(irun)-19:1:stimulation_timing(irun)+210,:);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualization of full time series 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ROI extraction
roipath   = fullfile(pwd, '/ROIs');
[ROIname] = ExtROIname(roipath);

% visualization of full time series
color = [0.3, 0, 0.3];
visualizeFullTS_madino(CBVtime_aligned, ROIname, resultpath_madino, color);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualization of CBV responses and extraction of peak intensity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CBVresponse_madino = extCBVresponse_madino(-CBVtime_aligned);

% extraction of 5HT receptors
niftidirect = fullfile(pwd, '/5HTR');
niftiList = makeList(niftidirect, '*.nii');

template = fullfile(pwd,'/atlas.nii');
savepath = fullfile(pwd,'/ReceptorExpressions');

% 28 ROIs
ROIIds = {1,26,24,4,23,3,8,34,33,38,13,5,35,16,52,51,70,56,57,78,65,62,59,49,69,47,46,45};

% this is for the 5HTR expression
[HTExpSignals] = EXPext(niftiList, template, ROIIds);
% normalization
normalized_HTExpSignals = (HTExpSignals-min(HTExpSignals))./max(HTExpSignals-min(HTExpSignals));

% visualization ofof CBV responses
stim = 1:6;
mkdir(resultpath_madino);
colors = [0.6350 0.0780 0.1840]; % deep mazenta
[AUC1, meanTIMESERIES1, maxTIMES1] = visualizeCBVresponses_madino(CBVresponse_madino, ROIname, resultpath_madino, colors,stim);

% visualization of statistical tests on 
timedur = 30;

% maxAUC and maxTIMES(peak intensity) extractions
stim = 1:6;
[maxTIMES_madino, maxTIMES1id_madino, maxAUC_madino, maxAUCid_madino] = peaksearchCBVresponses2(CBVresponse_madino, ROIname, timedur, stim);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% correlation between peak of CBV signals and structural density
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

visualizeAllTimeSeriesSession3rd
% comparison between awake (second) and 5HT projection density
index = find(~isnan(normalized_HTExpSignals(:, 6)) .* ~isnan(transpose(mean(maxTIMES_madino))));
% peak intensity of CBV signals
val1  = transpose(mean(maxTIMES_madino(:,index)));
% structural density
val2  = normalized_HTExpSignals(index, 6);
% peak intensity of BOLD signals
val3  = transpose(mean(maxTIMES1_bsession3(:,index))) * 100;

% structural density & peaks of CBV signals
[r_mandino, pval_mandino]  = corr(val2, val1);
fprintf('structural density and CBV signals(Grandjean2019):\n r = %f \n', r_mandino);
fprintf('pvals of between structural density and CBV signals:\n pval = %f \n', pval_mandino);

% structural density & peaks of BOLD signals
[r_session3, pval_session3] = corr(val2, val3);
fprintf('structural density and BOLD signals(Hamada2023):\n r = %f \n', r_session3);
fprintf('pvals of between structural density and BOLD signals:\n pval = %f \n', pval_session3);

% comparison between awake (second) and 5HT projection density
texts(1) = {'5HT projection density (a.u.)'};
texts(2) = {'ΔCBV/%BOLD(a.u.)'};
texts(3) = {'Structural_corr_Grandjean2019_Hamada'};
texts(4) = {resultpath_madino};

deep_mazenta = [0.3, 0, 0.3];
mazenta = [1, 0, 1];
color(1,:) = mazenta;
color(2,:) = deep_mazenta;

visualizeContrastMadinoHamada1(val2, val1, val3, texts, color);

% peaks between CBV and BOLD signals
[r_mh, pval_hm] = corr(val1, val3);
fprintf('correlation of peaks between CBV and BOLD signals: r = %f \n', r_mh);
fprintf('pvals of peaks between CBV and BOLD signals: pval = %f \n', pval_hm);

texts(1) = {'ΔCBV(a.u.; Grandjean2019)'};
texts(2) = {'%BOLD(a.u.; Session3)'};
texts(3) = {'Contrast_Mandino2022vsSession3'};
texts(4) = {resultpath_madino};
color(1,:) =  [0, 0.5, 0.5];

visualizeContrastMadinoHamada2(val1, val3, texts, color);

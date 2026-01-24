function [AllTimeSeries] = extGroupTSROI(listing, StimType, GroupType)
% extGroupTSROI - Extract ROI time series for a group of subjects
%
% This function loads preprocessed fMRI data for multiple subjects and
% extracts time series for each ROI. It handles both transgenic (TPH-Cre)
% and control (WT) groups with blue or yellow stimulation conditions.
%
% Syntax:
%   [AllTimeSeries] = extGroupTSROI(listing, StimType, GroupType)
%
% Input:
%   listing   - Structure array from makeList() containing paths to
%               preprocessed .mat files (e.g., TPH*_main_preprocessed.mat)
%
%   StimType  - Stimulation type: 'blue' (ChR2 activation) or 
%               'yellow' (control light)
%
%   GroupType - Animal group: 'tph' (transgenic TPH-Cre) or 
%               'cont' (wild-type control)
%
% Output:
%   AllTimeSeries - [nSub x nTime x nROI] 3D array of time series
%                   nSub: number of subjects in the group
%                   nTime: time points per session (typically 680)
%                   nROI: number of ROIs (28)
%
% Notes:
%   - .mat files contain 'timeseries' (TPH) or 'timeseries2' (WT) cell arrays
%   - Data is normalized using normOPTOtimeseries before extraction
%   - Blue light (473nm) activates ChR2 in transgenic mice only
%   - Yellow light (593nm) serves as control (no opsin activation)
%
% Example:
%   listing_tph = makeList('/data/session1', '*TPH*');
%   timeseries_blue = extGroupTSROI(listing_tph, 'blue', 'tph');
%
% See also: extROITS, normOPTOtimeseries, makeList
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/08/29

nSub = length(listing);
sample = load(listing(1).name);

if strcmp(GroupType, 'tph'),
    sampleTS = sample.timeseries{1};
    [nTS, nROIs] = size(sampleTS);
else,
    sampleTS = sample.timeseries2{1};
    [nTS, nROIs] = size(sampleTS);
end

% all data info
AllTimeSeries = zeros(nSub,nTS,nROIs);

% extract the ROI data from each person
for nsub = 1:nSub,
    AllTimeSeries(nsub, :, :) = extROITS(listing(nsub).name, StimType, GroupType);
end
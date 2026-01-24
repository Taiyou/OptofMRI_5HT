function [subtimeseries] = extROITS(targetpath, StimType, GroupType)
% extROITS - Extract and normalize ROI time series for a single subject
%
% This function loads preprocessed fMRI data from a .mat file and extracts
% the appropriate time series based on stimulation type and animal group.
% Data is normalized using percent signal change and detrending.
%
% Syntax:
%   [subtimeseries] = extROITS(targetpath, StimType, GroupType)
%
% Input:
%   targetpath - Full path to preprocessed .mat file
%                e.g., '/data/session1/TPH2_main_preprocessed.mat'
%
%   StimType   - 'blue'  : Blue light (473nm) ChR2 activation
%                'yellow': Yellow light (593nm) control
%
%   GroupType  - 'tph'  : Transgenic TPH-Cre mice (uses 'timeseries' variable)
%                'cont' : Wild-type controls (uses 'timeseries2' variable)
%
% Output:
%   subtimeseries - [nTime x nROI] normalized time series matrix
%                   nTime: typically 680 time points
%                   nROI: 28 regions of interest
%
% Data structure in .mat files:
%   For TPH group ('timeseries' cell array):
%     timeseries{1} = yellow light time series
%     timeseries{2} = blue light time series
%
%   For Control group ('timeseries2' cell array):
%     timeseries2{1} = yellow light time series
%     timeseries2{2} = blue light time series
%
% Notes:
%   - Applies normOPTOtimeseries for percent signal change & detrending
%   - Called by extGroupTSROI for batch processing
%
% See also: extGroupTSROI, normOPTOtimeseries
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/08/29

temporalSub = load(targetpath);

if strcmp(GroupType, 'tph'),
    if strcmp(StimType, 'blue'),
        subtimeseries = temporalSub.timeseries{2};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    else,
        subtimeseries = temporalSub.timeseries{1};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    end
else
    if strcmp(StimType, 'blue'),
        subtimeseries = temporalSub.timeseries2{2};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    else,
        subtimeseries = temporalSub.timeseries2{1};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    end
end
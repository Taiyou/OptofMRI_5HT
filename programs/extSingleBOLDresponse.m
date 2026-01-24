function [singleresponse] = extSingleBOLDresponse(timeseries)
% extSingleBOLDresponse - Extract stimulus-locked BOLD responses from time series
%
% This function extracts individual BOLD responses aligned to each stimulation
% onset from continuous fMRI time series data. The response is baseline-corrected
% using the 20 time points preceding stimulation onset.
%
% Syntax:
%   [singleresponse] = extSingleBOLDresponse(timeseries)
%
% Input:
%   timeseries - [nTime x nROI] matrix of fMRI time series data
%                nTime: total number of time points (typically 680)
%                nROI: number of regions of interest (28 in this study)
%
% Output:
%   singleresponse - [120 x 5 x nROI] array of extracted BOLD responses
%                    120: time window (-20 to +99 seconds from stim onset)
%                    5: number of stimulation trials per session
%                    nROI: number of ROIs
%
% Notes:
%   - Stimulation paradigm: 5 ON/OFF cycles at time points [81,201,321,441,561]
%   - Each cycle: 20s baseline + 20s stimulation + ~80s recovery
%   - TR = 1 second (1 time point = 1 second)
%   - Baseline correction: subtract mean of 20 pre-stimulus time points
%
% See also: extBOLDresponse, extGroupTSROI
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/Sep/22

[nTime, nROI] = size(timeseries);

% Initialize output array: [timepoints x stimulations x ROIs]
singleresponse = zeros(120, 5, nROI);

% Stimulation onset time points (in TR units, 1 TR = 1 second)
% Paradigm: 5 stimulation blocks at these time points
BOLDStim = [81, 201, 321, 441, 561];

% Extract each stimulation trial
for nstim = 1:5
    % Extract window: 20 points before to 99 points after stimulation onset
    % Window size: 120 time points total (-20s to +99s)
    temporalsignal = timeseries(BOLDStim(nstim)-20:BOLDStim(nstim)+99, :);
    
    % Baseline correction: subtract mean of first 20 time points (pre-stimulus)
    singleresponse(:, nstim, :) = temporalsignal - mean(temporalsignal(1:20, :));
end